/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'exceptions.dart';

part 'command.dart';

/// Establishes a protocol for the app to communicate continuously with I/O.
/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
class CommandRunner<T> {
  CommandRunner({this.onOutput, this.onExit});

  /// Called (and awaited) in the [quit] method before [exit] is called.
  /// The exit code is passed into the callback.
  FutureOr<void> Function(int)? onExit;

  /// If not null, this method is used to handle output. Useful if you want to
  /// execute code before the output is printed to the console, or if you
  /// want to do something other than print output the console.
  /// If null, the onInput method will [print] the output.
  FutureOr<void> Function(String)? onOutput;

  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  final StreamController<Object> _onErrorController = StreamController();
  Stream get onError => _onErrorController.stream;

  Future<void> run() async {
    await for (final List<int> data in stdin) {
      // Convert byte data into a string, and trim whitespace so that it's
      // easier to handle user input.
      final String input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    // ADDED step_10 (try/catch)
    try {
      final String base = input.split(' ').first;
      // ADDED step_8
      final String inputArgs = input.split(' ').sublist(1).join(' ');
      final Command<T> cmd = parse(base);

      if (cmd is CommandWithArgs) {
        final Map<Arg, String?> args = parseArgs(
          cmd as CommandWithArgs,
          inputArgs,
        );
        await for (final T message in (cmd as CommandWithArgs).run(
          args: args,
        )) {
          if (onOutput != null) {
            await onOutput!(message.toString());
          } else {
            print(message.toString());
          }
        }
      } else {
        await for (final T message in cmd.run()) {
          if (onOutput != null) {
            await onOutput!(message.toString());
          } else {
            print(message.toString());
          }
        }
      }
      // ADDED step_10
      // For any exception, the program should give feedback and continue running.
      // The program will terminate on Error.
    } on FormatException catch (e) {
      _onErrorController.add(e);
    } on HttpException catch (e) {
      _onErrorController.add(e);
    } on ArgumentException catch (e) {
      _onErrorController.add(e);
    } on Exception catch (e) {
      _onErrorController.add(e);
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      // ADDED step_10
      // This indicates a bug in the code of the consumer of this API
      // Therefore, the program should terminate during development.
      if (_commands.containsKey(name)) {
        throw ArgumentError('[addCommand] - Input $name already exists.');
      } else {
        _commands[name] = command;
        command.runner = this;
      }
    }
  }

  // ADDED step_10 (updated)
  Command<T> parse(String input) {
    if (_commands.containsKey(input)) {
      return _commands[input]!;
    }
    // Indicates a problem with *usage* at runtime, not a bug in the code.
    // The program shouldn't crash.
    throw FormatException('Invalid input. $input is not a known command.');
  }

  Map<Arg, String?> parseArgs(CommandWithArgs cmd, String inputArgs) {
    final argMap = <Arg, String?>{};
    final List<String> allArgs = inputArgs.split(',');
    for (var inputArg in allArgs) {
      var equalSignIndex = inputArg.indexOf('=');
      if (equalSignIndex == -1) {
        // Indicates a problem with *usage* at runtime, not a bug in the code.
        // The program shouldn't crash.
        throw ArgumentException(
          'Arguments must be formatted as name=value, got $inputArg',
        );
      }

      var argName = inputArg.substring(0, equalSignIndex).trim();
      var argValue = inputArg.substring(equalSignIndex + 1);

      // ADDED step_10 (updated to add orElse)
      // If it didn't split, that means it didn't contain an '=' sign and is formatted incorrectly.
      var arg = cmd.arguments.firstWhere(
        (Arg a) => a.name == argName,
        orElse: () {
          throw ArgumentException(
            "Argument $argName doesn't exist on command ${cmd.name}",
          );
        },
      );

      // ADDED step_10
      // Indicates a problem with *usage* at runtime, not a bug in the code.
      // The program shouldn't crash.
      if (argMap.keys.any((existingArg) => existingArg.name == arg.name)) {
        throw ArgumentException(
          'Arguments must have unique names. There are multiple arguments called $argName',
        );
      }
      argMap[arg] = argValue;
    }

    return argMap;
  }

  void quit([int code = 0]) async {
    if (onExit != null) {
      await onExit!(code);
    }

    onError.drain();
    await _onErrorController.close();
    exit(code);
  }
}
