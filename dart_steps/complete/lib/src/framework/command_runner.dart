/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:step_12/src/framework/framework.dart';
import 'package:uuid/uuid.dart';

part 'command.dart';

/// Establishes a protocol for the app to communicate continuously with I/O.
/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
///
// TODO: rename so it isn't confused with pkg:args CommandRunner
class CommandRunner<T> {
  CommandRunner({this.onOutput, this.onExit});

  /// Called (and awaited) in the [quit] method before [exit] is called.
  /// The exit code is passed into the callback.
  FutureOr<void> Function(int)? onExit;

  /// If not null, this method is used to handle output. Useful if you want to
  /// execute code before the output is printed to the console, or if you
  /// want to do something other than print output the console.
  /// If null, the onInput method will [print] the output.
  FutureOr<void> Function(String)? onOutput;

  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  final StreamController<Object> _onErrorController = StreamController();
  Stream get onError => _onErrorController.stream;

  Future<void> run() async {
    _initLogger();
    _frameworkLogger.info('App startup'); // ADDED step_11
    // TODO: don't use streams
    await for (final List<int> data in stdin) {
      // Convert byte data into a string, and trim whitespace so that it's
      // easier to handle user input.
      final String input = String.fromCharCodes(data).trim();
      _frameworkLogger.log(
        Level.INFO,
        "Raw user input: $input",
      ); // ADDED step_11
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    // ADDED step_10 (try/catch)
    try {
      final String base = input.split(' ').first;
      // ADDED step_8
      final String inputArgs = input.split(' ').sublist(1).join(' ');
      final Command<T> cmd = parse(base);
      _frameworkLogger.info("CMD parsed=${cmd.name}"); // ADDED step_11
      if (cmd is CommandWithArgs) {
        final Map<Arg, String?> args = parseArgs(
          cmd as CommandWithArgs,
          inputArgs,
        );
        // ADDED step_11
        _frameworkLogger.info(
          "ARGS: ${args.entries.map((entry) => '${entry.key.name}=${entry.value}').join(', ')}",
        );
        await for (final T message in (cmd as CommandWithArgs).run(
          args: args,
        )) {
          if (onOutput != null) {
            await onOutput!(message.toString());
          } else {
            print(message.toString());
          }
        }
      } else {
        await for (final T message in cmd.run()) {
          if (onOutput != null) {
            await onOutput!(message.toString());
          } else {
            print(message.toString());
          }
        }
      }
      // ADDED step_10 (catch statements)
      // For any exception, the program should give feedback and continue running.
      // The program will terminate on Error.
    } on FormatException catch (e) {
      _frameworkLogger.warning(
        'FormatException: ${e.message}',
      ); // ADDED step_11
      _onErrorController.add(e);
    } on HttpException catch (e) {
      _frameworkLogger.warning('HttpException: ${e.message}'); // ADDED step_11
      _onErrorController.add(e);
    } on ArgumentException catch (e) {
      _frameworkLogger.warning(
        'ArgumentException: ${e.message}',
      ); // ADDED step_11
      _onErrorController.add(e);
    } on Exception catch (e) {
      _frameworkLogger.warning('UnknownException'); // ADDED step_11
      _onErrorController.add(e);
    }
  }

  void addCommand(Command<T> command) {
    for (final String name in <String>[command.name, ...command.aliases]) {
      // ADDED step_10
      if (_commands.containsKey(name)) {
        _frameworkLogger.info('User input invalid. Duplicate command names');
        // This indicates a bug in the code of the consumer of this API that
        // needs to be caught at runtime. The program should terminate
        // at build time.
        throw ArgumentError('[addCommand] - Input $name already exists.');
      } else {
        _commands[name] = command;
        command.runner = this;
      }
    }
  }

  // ADDED step_10 (updated)
  Command<T> parse(String input) {
    if (_commands.containsKey(input)) {
      // has options
      return _commands[input]!;
    }
    // Indicates a problem with *usage* at runtime, not a bug in the code.
    // The program shouldn't crash.
    throw ArgumentException('Invalid input. $input is not a known command.');
  }

  Map<Arg, String?> parseArgs(CommandWithArgs cmd, String inputArgs) {
    final argMap = <Arg, String?>{};
    final List<String> allArgs = inputArgs.split(',');
    for (var inputArg in allArgs) {
      var equalSignIndex = inputArg.indexOf('=');
      if (equalSignIndex == -1) {
        // Indicates a problem with *usage* at runtime, not a bug in the code.
        // The program shouldn't crash.
        throw ArgumentException(
          'Arguments must be formatted as name=value, got $inputArg',
        );
      }

      var argName = inputArg.substring(0, equalSignIndex).trim();
      var argValue = inputArg.substring(equalSignIndex + 1);

      // ADDED step_10 (updated to add orElse)
      // If it didn't split, that means it didn't contain an '=' sign and is formatted incorrectly.
      var arg = cmd.arguments.firstWhere(
        (Arg a) => a.name == argName,
        orElse: () {
          throw ArgumentException(
            "Argument $argName doesn't exist on command ${cmd.name}",
          );
        },
      );

      // ADDED step_10
      // Indicates a problem with *usage* at runtime, not a bug in the code.
      // The program shouldn't crash.
      if (argMap.keys.any((existingArg) => existingArg.name == arg.name)) {
        throw ArgumentException(
          'Arguments must have unique names. There are multiple arguments.dart called $argName',
        );
      }
      argMap[arg] = argValue;
    }

    return argMap;
  }

  void quit([int code = 0]) async {
    _frameworkLogger.info('Application terminating with exit code $code');
    if (onExit != null) {
      await onExit!(code);
    }
    await _onErrorController.close();
    exit(code);
  }

  // ADDED step_11 (rest of file)
  final _frameworkLogger = Logger.detached("Framework internal logger");
  final _uuid = Uuid();

  void _initLogger() {
    final sessionId = _uuid.v1();
    final now = DateTime.now();

    final segments = Platform.script.path.split('/');
    final projectDir = segments.sublist(0, segments.length - 2).join('/');

    // input log tracks user journeys.
    final dir = Directory('$projectDir/logs');
    if (!dir.existsSync()) dir.createSync();
    final frameworkLog = File(
      '${dir.path}/${now.year}_${now.month}_${now.day}_input_log.txt',
    );
    frameworkLog.writeAsStringSync('--- New Session $sessionId ---');

    _frameworkLogger.level = Level.ALL;
    _frameworkLogger.onRecord.listen((record) {
      final msg =
          '[$sessionId - ${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
      frameworkLog.writeAsStringSync('$msg \n', mode: FileMode.append);
    });
  }
}
