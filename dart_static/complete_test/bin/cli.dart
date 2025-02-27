/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:dart_complete/src/framework/command_runner.dart';
import 'package:dart_complete/wikipedia_cli.dart';
import 'package:logging/logging.dart';

// print an article
// Command needs to handle positional arguments
// dart bin/wikipedia.dart article cat
// dart bin/wikipedia.dart article --random

// search for an article
// Command needs to have an option
// dart bin/wikipedia.dart search cat

// Command needs to have an option and a flag
// dart bin/wikipedia.dart timeline --date 12/12
// dart bin/wikipedia.dart timeline --today

void main(List<String> arguments) async {
  // hierarchicalLoggingEnabled = true;
  final app = CommandRunner<String?>(
    onOutput: (String output) async {
      await write(output);
    },
    onExit: (int exitCode) async {
      if (exitCode != 0) {
        // log or something
      }
    },
  )..addCommand(HelpCommand(logger: Logger('HelpCommand')));

  print(app.commands.length);
  app.run(arguments);
  app.onError.listen((error) {
    if (error is Error) {
      throw error;
    }
    if (error is ArgumentException) {
      // error text is red
      print(error.message?.errorText ?? '');
    } else if (error is Exception) {
      throw error;
    }
  });
}
