/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */
part of 'command_runner.dart';

const _nameColumnLength = 14;
const _aliasColumnLength = 6;
const _argsColumnLength = 18;
const _descriptionColumnLength = 39;
const _totalScreenWidth =
    _nameColumnLength +
    _aliasColumnLength +
    _argsColumnLength +
    _descriptionColumnLength;

class Option {
  final String name;
  final String? help;
  final bool required;
  final String? defaultValue;

  Option(this.name, {this.help, this.required = false, this.defaultValue});
}

abstract class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;
  List<Option> options = [];

  late CommandRunner<T> runner;

  // ADDED step_9 -- all command.run implementations changed from FutureOr to Stream
  Stream<T> run();

  String get usage {
    var stringBuffer = StringBuffer()..write(name);
    var numSpaces = _nameColumnLength - name.length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    stringBuffer.writeAll(aliases, ', ');
    numSpaces = _aliasColumnLength - aliases.join(', ').length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    // base Command implementers don't have args, so enter blank space
    numSpaces = _argsColumnLength;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    var splitDescription = description.splitLinesByLength(
      _descriptionColumnLength,
    );
    stringBuffer.write(splitDescription.first);

    if (splitDescription.length == 1) return stringBuffer.toString();

    stringBuffer.write('\n');
    for (var line in splitDescription.sublist(1)) {
      stringBuffer.write(
        ' ' * (_totalScreenWidth - _descriptionColumnLength) + line,
      );
    }
    return stringBuffer.toString();
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
    var stringBuffer = StringBuffer()..write(name);
    var numSpaces = _nameColumnLength - name.length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    stringBuffer.writeAll(aliases, ', ');
    numSpaces = _aliasColumnLength - aliases.join(', ').length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    var printArgs = arguments
        .map((Arg arg) => "${arg.name}=${arg.help}")
        .join(', ');

    // TODO: should be printed on second line
    if (printArgs.length > _argsColumnLength) {
      printArgs.substring(0, _argsColumnLength);
    }

    stringBuffer.write(printArgs);
    numSpaces = _argsColumnLength - printArgs.length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    var splitDescription = description.splitLinesByLength(
      _descriptionColumnLength,
    );
    stringBuffer.write(splitDescription.first);

    if (splitDescription.length == 1) return stringBuffer.toString();

    stringBuffer.write('\n');
    for (var line in splitDescription.sublist(1)) {
      stringBuffer.write(
        ' ' * (_totalScreenWidth - _descriptionColumnLength) + line,
      );
    }
    return stringBuffer.toString();
  }
}
