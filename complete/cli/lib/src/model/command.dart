/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */
import 'dart:async';

import 'package:cli/cli.dart';

const nameColumnLength = 20;
const aliasColumnLength = 6;
const argsColumnLength = 14;
const descriptionColumnLength = 39;
const totalScreenWidth =
    nameColumnLength +
    aliasColumnLength +
    argsColumnLength +
    descriptionColumnLength;

abstract class Command<T> {
  String get description;
  String get name;
  List<String> get aliases;

  late CommandRunner<T> runner;

  Stream<T> run();

  String get usage {
    var stringBuffer = StringBuffer()..write(name);
    var numSpaces = nameColumnLength - name.length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    stringBuffer.writeAll(aliases, ', ');
    numSpaces = aliasColumnLength - aliases.join(', ').length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    // Base Command implementers don't have args, so enter blank space
    numSpaces = argsColumnLength;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    var splitDescription = description.splitLinesByLength(
      descriptionColumnLength,
    );
    stringBuffer.write(splitDescription.first);

    if (splitDescription.length == 1) return stringBuffer.toString();

    stringBuffer.write('\n');
    for (var line in splitDescription.sublist(1)) {
      stringBuffer.write(
        ' ' * (totalScreenWidth - descriptionColumnLength) + line,
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

abstract class CommandArgs<T> extends Command<T> {
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
    var numSpaces = nameColumnLength - name.length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    stringBuffer.writeAll(aliases, ', ');
    numSpaces = aliasColumnLength - aliases.join(', ').length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    for (var arg in arguments) {
      stringBuffer.write("${arg.name}=${arg.help}");
    }

    numSpaces = argsColumnLength - arguments.join('').length;
    while (numSpaces > 0) {
      stringBuffer.write(' ');
      numSpaces--;
    }

    var splitDescription = description.splitLinesByLength(
      descriptionColumnLength,
    );
    stringBuffer.write(splitDescription.first);

    if (splitDescription.length == 1) return stringBuffer.toString();

    stringBuffer.write('\n');
    for (var line in splitDescription.sublist(1)) {
      stringBuffer.write(
        ' ' * (totalScreenWidth - descriptionColumnLength) + line,
      );
    }
    return stringBuffer.toString();
  }
}
