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

  // In the case of flags, the default value is a bool
  // In other options and commands, the default value is String
  // NB: flags are just Option objects that don't take arguments
  Object? get defaultValue;

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
  final Object? defaultValue;

  @override
  final String? valueHelp;

  @override
  String get usage => '$name:  $help';
}

abstract class Command<T> extends Argument {
  @override
  String get name;

  String get description;

  bool get requiresArgument => false;

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

  /// A flag is an [Option] that's treated as a boolean.
  /// All flags have a default value of false, and are
  /// considered true if the flag is passed into the
  /// command at all.
  void addFlag(String name, {String? help, String? abbr, String? valueHelp}) {
    final option = Option(
      name,
      help: help,
      abbr: abbr,
      defaultValue: false,
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
  Map<Option, Object?> options = {};
  List<Option> flags = [];

  // Returns true if the flag exists
  bool flag(String name) {
    // Only check flags, because we're sure that flags are booleans
    for (var option in options.keys.where(
      (option) => option.type == OptionType.flag,
    )) {
      if (option.name == name) {
        return options[option] as bool;
      }
    }
    return false;
  }

  bool option(String name) {
    return options.containsKey(name);
  }
}
