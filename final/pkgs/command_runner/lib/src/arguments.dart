/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';

import '../command_runner.dart';

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
  String get usage => '$name:  $help';
}

abstract class Command<T> extends Argument {
  @override
  String get name;

  String get description;

  late CommandRunner<T> runner;

  @override
  String? help;

  @override
  String? abbr;

  @override
  String? defaultValue;

  @override
  String? valueHelp;

  final Map<String, Option> _options = {};

  UnmodifiableMapView<String, Option> get options =>
      UnmodifiableMapView(_options);

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
    _options[name] = option;
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
    _options[name] = option;
  }

  FutureOr<T> run(ArgResults args);

  @override
  String get usage {
    return '$name:  $description';
  }
}

class ArgResults {
  Command? command;
  String? commandArg;
  Map<Option, String?> options = {};

  bool flag(String name) {
    for (var option in options.keys) {
      if (option.name == name) {
        return true;
      }
    }
    return false;
  }

  bool option(String name) {
    return options.containsKey(name);
  }
}
