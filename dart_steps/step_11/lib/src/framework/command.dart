/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */
part of 'command_runner.dart';

abstract class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;

  late CommandRunner<T> runner;

  // ADDED step_10 -- all command.run implementations changed from FutureOr to Stream
  Stream<T> run();

  String get usage {
    return '$name - ${aliases.join(', ')} - $description';
  }
}

class Arg {
  final String name;
  final String? help;
  final bool required;
  final String? defaultValue;

  Arg(this.name, {this.help, this.required = false, this.defaultValue});
}

abstract class CommandWithArgs<T> extends Command<T> {
  List<Arg> get arguments;

  @override
  Stream<T> run({Map<Arg, String?> args});

  bool validateArgs(Map<Arg, String?> argInputs) {
    for (var arg in argInputs.entries) {
      if (arg.key.required && arg.value == null ||
          arg.key.required && arg.value!.isEmpty) {
        return false;
      }
    }

    return true;
  }

  @override
  String get usage {
    final Iterable<String> argsToString = arguments.map(
      (a) => '${a.name}=${a.help}',
    );
    return '$name - ${aliases.join(', ')} - $description - ARGS: ${argsToString.join(', ')}';
  }
}
