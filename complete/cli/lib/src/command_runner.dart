/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:collection';
import 'dart:io';

import 'package:cli/src/model/command.dart';

import 'console.dart' as console;

class CommandRunner<T> {
  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  Future<void> run() async {
    await onInput('help');
    await for (final List<int> data in stdin) {
      final String input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    final String base = input.split(' ').first;
    final String inputArgs = input.split(' ').sublist(1).join(' ');

    final Command<T>? cmd = parse(base);

    if (cmd == null) {
      await console.write('Invalid input $input');
      return;
    }

    if (cmd is CommandArgs) {
      final Map<Arg, String?> args = parseArgs(cmd as CommandArgs, inputArgs);
      await for (final T message in (cmd as CommandArgs).run(args: args)) {
        await console.write(message.toString());
      }
    }

    await for (final T message in cmd.run()) {
      await console.write(message.toString());
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      if (_commands.containsKey(name)) {
        throw ArgumentError('[addCommand] - Input $name already exists.');
      } else {
        _commands[name] = command;
        command.runner = this;
      }
    }
  }

  Command<T>? parse(String input) {
    if (_commands.containsKey(input)) {
      return _commands[input]!;
    }
    return null;
  }

  void quit([int code = 0]) => _quit(code);

  void _quit(int code) {
    exit(code);
  }

  Map<Arg, String?> parseArgs(CommandArgs cmd, String inputArgs) {
    final argMap = <Arg, String?>{};
    final List<String> allArgs = inputArgs.split(',');
    for (var inputArg in allArgs) {
      var separated = inputArg.split('=');
      if (separated.length <= 1) {
        throw ArgumentError(
          'Arguments must be formatted as name=value, got $inputArg}',
        );
      }
      var argName = separated.first.trim();
      print(argName);
      var arg = cmd.arguments.firstWhere((Arg a) => a.name == argName);
      // rejoin, accounting for equals signs within the argument value.
      var argValue = separated.sublist(1).join('=');

      if (argMap.keys.any((existingArg) => existingArg.name == arg.name)) {
        throw ArgumentError(
          'Arguments must have unique names. There are multiple arguments called $argName',
        );
      }

      argMap[arg] = argValue;
    }

    return argMap;
  }
}
