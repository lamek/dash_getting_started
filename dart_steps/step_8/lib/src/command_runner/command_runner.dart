/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

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
    final String base = input.split(' ').first;
    // ADDED step_8
    final String inputArgs = input.split(' ').sublist(1).join(' ');
    final Command<T>? cmd = parse(base);
    // TODO: handle errors (run time)
    if (cmd is CommandWithArgs) {
      final Map<Arg, String?> args = parseArgs(
        cmd as CommandWithArgs,
        inputArgs,
      );
      print(await (cmd as CommandWithArgs).run(args: args));
    } else {
      // TODO: handle errors
      print(await cmd?.run());
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      // TODO: handle error (build time)
      _commands[name] = command;
      command.runner = this;
    }
  }

  Command<T>? parse(String input) {
    // TODO: handle error (run time)
    return _commands[input];
  }

  Map<Arg, String?> parseArgs(CommandWithArgs cmd, String inputArgs) {
    final argMap = <Arg, String?>{};
    final List<String> allArgs = inputArgs.split(',');
    for (var inputArg in allArgs) {
      var separated = inputArg.split('=');
      // TODO: handle error (run time)
      var argName = separated.first.trim();
      var arg = cmd.arguments.firstWhere((Arg a) => a.name == argName);
      // rejoin, accounting for equals signs within the argument value.
      var argValue = separated.sublist(1).join('=');
      // TODO: handle error (build time)
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
