/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:dart_complete/src/framework/command_runner.dart';
import 'package:dart_complete/wikipedia_cli.dart';
import 'package:logging/logging.dart';

// print an article
// Command needs to handle positional arguments.dart
// dart bin/wikipedia.dart article cat
// dart bin/wikipedia.dart article --random

// search for an article
// Command needs to have an option
// dart bin/wikipedia.dart search cat

// Command needs to have an option and a flag
// dart bin/wikipedia.dart timeline --date 12/12
// dart bin/wikipedia.dart timeline --today

void main(List<String> arguments) async {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  final logger = Logger('onError');

  final app =
      CommandRunner<String?>(
          onOutput: (String output) async {
            await write(output);
          },
          onError: (Object error) async {
            if (error is Exception) {
              logger.severe(error.toString());
              return;
            }

            throw error;
          },
          onExit: (int exitCode) async {
            if (exitCode != 0) {
              // log or something
            }
          },
        )
        ..addFlag('help', abbr: 'h', help: 'Prints this usage information.')
        ..addFlag('version', abbr: 'v', help: 'Prints the current version.')
        ..addCommand(HelpCommand());
  final results = app.parse(arguments);

  if (results.flag('version')) {
    print('0.0.1');
    return;
  }

  if (results.flag('help')) {
    app.printUsage();
    return;
  }

  app.run(arguments);
}
