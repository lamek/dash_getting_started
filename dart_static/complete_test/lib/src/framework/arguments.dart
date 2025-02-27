/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';

import 'command_runner.dart';

enum OptionType { flag, option }

sealed class Argument {
  String get name;
  String? get help;
  String? get abbr;
  String? get defaultValue;
  String? get valueHelp;
  String get usage;
}

class Option extends Argument {
  Option(
    this.name, {
    required this.type,
    this.help,
    this.abbr,
    this.defaultValue,
    this.valueHelp,
  });

  @override
  final String name;

  final OptionType type;

  @override
  final String? help;

  @override
  final String? abbr;

  @override
  final String? defaultValue;

  @override
  final String? valueHelp;

  @override
  String get usage => toString();
}

abstract class Command<T> extends Argument {
  Command({this.logger});

  @override
  String get name;

  String get description;

  final Logger? logger;

  late CommandRunner<T> runner;

  @override
  String? help;

  @override
  String? abbr;

  @override
  String? defaultValue;

  @override
  String? valueHelp;

  List<Option> _options = [];

  set options(List<Option> options) {
    _options = options;
  }

  UnmodifiableListView<Option> get options => UnmodifiableListView(_options);

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
    _options.add(option);
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
    _options.add(option);
  }

  FutureOr<T> run(ArgResults results);

  @override
  String get usage {
    return '$name:  $description';
  }
}

class ArgResults {
  ArgResults({
    this.command,
    this.positionalArgs = const [],
    this.options = const {},
  });
  Command? command;
  List<String> positionalArgs;
  Map<Option, String?> options;
}
