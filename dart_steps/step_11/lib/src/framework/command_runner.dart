/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import 'exceptions.dart';

part 'command.dart';
part 'logging.dart';

/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
class CommandRunner<T> {
  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  Future<void> run() async {
    _initLogger();
    _frameworkLogger.info('App startup');
    await for (final List<int> data in stdin) {
      // Convert byte data into a string, and trim whitespace so that it's
      // easier to handle user input.
      final String input = String.fromCharCodes(data).trim();
      _frameworkLogger.log(Level.INFO, "Raw user input: $input");
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
      _frameworkLogger.info("CMD parsed=${cmd.name}");
      if (cmd is CommandWithArgs) {
        CommandWithArgs cmdWithArg = cmd as CommandWithArgs;
        final Map<Arg, String?> args = parseArgs(
          cmd as CommandWithArgs,
          inputArgs,
        );
        _frameworkLogger.info(
          "ARGS: ${args.entries.map((entry) => '${entry.key.name}=${entry.value}').join(', ')}",
        );
        await for (final T message in (cmd as CommandWithArgs).run(
          args: args,
        )) {
          print(message.toString());
        }
      } else {
        await for (final T message in cmd.run()) {
          print(message.toString());
        }
      }
      // ADDED step_9
      // For any exception, the program should give feedback and continue running.
      // The program will terminate on Error.
    } on FormatException catch (e) {
      // ADDED step_11
      _frameworkLogger.warning('FormatException: ${e.message}');
      print(e.message);
    } on HttpException catch (e) {
      // ADDED step_11
      _frameworkLogger.warning('HttpException: ${e.message}');
      print(e.message);
    } on ArgumentException catch (e) {
      // ADDED step_11
      _frameworkLogger.warning('ArgumentException: ${e.message}');
      print(e.message);
    } on Exception {
      // ADDED step_11
      _frameworkLogger.warning('UnknownException');
      print('Unknown issue occurred. Please try again.');
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      // ADDED step_9
      // This indicates a bug in the code of the consumer of this API
      // Therefore, the program should terminate during development.
      if (_commands.containsKey(name)) {
        _frameworkLogger.info('User input invalid. Duplicate command names');
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
      var arg = cmd.arguments.firstWhere(
        (Arg a) => a.name == argName,
        orElse: () {
          throw ArgumentException(
            "Argument name $argName doesn't match known argument",
          );
        },
      );
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
    // ADDED step_11
    _frameworkLogger.info('Application terminated with exit code $code');
    exit(code);
  }
}
