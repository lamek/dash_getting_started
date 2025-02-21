/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:step_9/src/command_runner/exceptions.dart';

part 'command.dart';

/// Establishes a protocol for the app to communicate continuously with I/O.
/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
class CommandRunner<T> {
  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  Future<void> run() async {
    await for (final List<int> data in stdin) {
      // Convert byte data into a string, and trim whitespace so that it's
      // easier to handle user input.
      final String input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    // ADDED step_9 (try/catch)
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
        print(await (cmd as CommandWithArgs).run(args: args));
      } else {
        print(await cmd.run());
      }
      // ADDED step_9
      // For any exception, the program should give feedback and continue running.
      // The program will terminate on Error.
    } on FormatException catch (e) {
      print(e.message);
    } on HttpException catch (e) {
      print(e.message);
      // Swallow the exception, but give feedback.
    } on ArgumentException catch (e) {
      print(e.message);
    } on Exception {
      print('Unknown issue occurred. Please try again');
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      // ADDED step_9
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

  // ADDED step_9 (updated)
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
      print(allArgs.length);
      var separated = inputArg.split('=');
      // ADDED step_9
      // If it didn't split, that means it didn't contain an '=' sign and is formatted incorrectly.
      if (separated.length <= 1) {
        // Indicates a problem with *usage* at runtime, not a bug in the code.
        // The program shouldn't crash.
        throw ArgumentException(
          'Arguments must be formatted as name=value, got $inputArg',
        );
      }
      var argName = separated.first.trim();
      var arg = cmd.arguments.firstWhere((Arg a) => a.name == argName);
      // rejoin, accounting for equals signs within the argument value.
      var argValue = separated.sublist(1).join('=');

      // ADDED step_9
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

  void quit([int code = 0]) => _quit(code);

  void _quit(int code) {
    // TODO: add any teardown code here.
    exit(code);
  }
}
