/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'arguments.dart';
import 'exceptions.dart';

part 'command.dart';

/// Establishes a protocol for the app to communicate continuously with I/O.
/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
///
// TODO: rename so it isn't confused with pkg:args CommandRunner
class CommandRunner<T> {
  CommandRunner({this.onOutput, this.onError, this.onExit});

  /// If not null, this method is used to handle output. Useful if you want to
  /// execute code before the output is printed to the console, or if you
  /// want to do something other than print output the console.
  /// If null, the onInput method will [print] the output.
  FutureOr<void> Function(String)? onOutput;

  /// Called (and awaited) in the [quit] method before [exit] is called.
  /// The exit code is passed into the callback.
  FutureOr<void> Function(int)? onExit;

  FutureOr<void> Function(Object)? onError;

  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  final Map<String, Option> _options = <String, Option>{};

  UnmodifiableSetView<Option> get options =>
      UnmodifiableSetView<Option>(<Option>{..._options.values});

  // Stream get onError => _onErrorController.stream;
  // final StreamController<Object> _onErrorController = StreamController();

  void addCommand(Command<T> command) {
    if (_validateArgument(command)) {
      _commands[command.name] = command;
      command.runner = this;
    }
  }

  void addFlag(
    String name, {
    String? help,
    String? abbr,
    String? defaultValue,
    String? valueHelp,
  }) {
    final option = Option(
      name,
      help: help,
      abbr: abbr,
      defaultValue: defaultValue,
      valueHelp: valueHelp,
      type: OptionType.flag,
    );
    if (_validateArgument(option)) {
      _options[option.name] = option;
      if (option.abbr != null) {
        _options[option.abbr!] = option;
      }
    }
  }

  void addOption(
    String name, {
    String? help,
    String? abbr,
    String? defaultValue,
    String? valueHelp,
  }) {
    final option = Option(
      name,
      help: help,
      abbr: abbr,
      defaultValue: defaultValue,
      valueHelp: valueHelp,
      type: OptionType.option,
    );
    if (_validateArgument(option)) {
      _options[option.name] = option;
      if (option.abbr != null) {
        _options[option.abbr!] = option;
      }
    }
  }

  Future<void> run(List<String> input) async {
    try {
      final ArgResults results = parse(input);
      if (results.command != null) {
        T? output = await results.command!.run(results);
        if (onOutput != null) {
          await onOutput!(output.toString());
        } else {
          print(output.toString());
        }
      }
      // Errors shouldn't be caught
    } on Exception catch (e) {
      _onError(e);
    }
  }

  void _onError(Object error) {
    if (onError != null) {
      onError!(error);
    } else {
      throw error;
    }
  }

  ArgResults parse(List<String> input, {ArgResults? argResults}) {
    ArgResults results = argResults ?? ArgResults();
    if (input.isEmpty) return results;
    final bool hasOptions = input.any((arg) => arg.startsWith('-'));
    if (!_commands.containsKey(input.first) && !hasOptions) {
      return results..positionalArgs = input;
    }

    if (results.command != null && _commands.containsKey(input.first)) {
      throw ArgumentException(
        'Input can only contain one command. Got ${input.first} and ${results.command!.name}',
      );
    }

    if (_commands.containsKey(input.first)) {
      results.command = _commands[input.first];
      return parse(input.sublist(1), argResults: results);
    }

    if (hasOptions) {
      Map<Option, String?> options = {};
      int i = 0;
      while (i < input.length) {
        if (input[i].startsWith('-')) {
          var base = _removeDash(input[i]);
          var option = _options[base];
          if (option == null) {
            throw ArgumentException('Unknown option ${input[i]}');
          }
          if (option.type == OptionType.option) {
            if (i + 1 >= input.length) {
              throw ArgumentException(
                'Option ${option.name} requires an argument',
              );
            }
            if (input[i + 1].startsWith('-')) {
              throw ArgumentException(
                'Option ${option.name} requires an argument, but got option ${input[i + 1]}',
              );
            }

            var arg = input[i + 1];
            options[option] = arg;
            i += 2;
          } else if (option.type == OptionType.flag) {
            options[option] = null;
            i++;
          }
        } else {
          results.positionalArgs.add(input[i]);
          i++;
        }
      }
      results.options = options;
    }

    return results;
  }

  String _removeDash(String input) {
    if (input.startsWith('--')) {
      return input.substring(2);
    }
    if (input.startsWith('-')) {
      return input.substring(1);
    }
    return input;
  }

  bool _validateArgument(Argument arg) {
    for (var name in <String>[arg.name, arg.abbr!]) {
      if (_commands.containsKey(name) || _options.containsKey(name)) {
        // This indicates a bug in the code of the consumer of this API that
        // needs to be caught at compile time.
        throw ArgumentError('[addCommand] - Input $name already exists.');
      }
    }

    return true;
  }

  void printUsage() {
    StringBuffer buffer = StringBuffer(
      'Usage: dart bin/cli.dart <command?> [options]\n\n',
    );

    for (var option in options) {
      buffer.writeln(option.usage);
    }
    buffer.writeln('');
    buffer.writeln('Available commands:');
    for (var cmd in commands) {
      buffer.writeln('${cmd.name}: ${cmd.description}');
    }

    if (onOutput != null) {
      onOutput!(buffer.toString());
    } else {
      print(buffer.toString());
    }
  }

  void quit([int code = 0]) async {
    if (onExit != null) {
      await onExit!(code);
    }
    exit(code);
  }
}
