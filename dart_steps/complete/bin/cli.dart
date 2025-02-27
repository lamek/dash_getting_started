/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:dart_complete_test/wikipedia_cli.dart';
import 'package:logging/logging.dart';

void main(List<String> arguments) async {
  hierarchicalLoggingEnabled = true;
  final app =
      CommandRunner<String?>(
          onOutput: (String output) async {
            await write(output);
          },
          onExit: (int exitCode) async {
            if (exitCode != 0) {
              // log or something
            }
          },
        )
        ..addCommand(HelpCommand())
        ..addCommand(VersionCommand()) // ADDED step_6
        ..addCommand(GetArticleByTitleCommand()) // ADDED step_8
        ..addCommand(OnThisDayTimelineCommand()) // ADDED step_9
        ..addCommand(ExitCommand());

  // ADDED step_12
  // Must be before app.run, or the app thinks its input
  await write('');
  await write(dartTitle);
  await write(wikipediaTitle);
  await write('');

  app.run();
  app.onError.listen((error) {
    if (error is Error) {
      throw error;
    }
    if (error is ArgumentException) {
      // error text is red
      print(error.message?.errorText ?? '');
    } else if (error is Exception) {
      // TODO: log exceptions in file
    }
  });

  // ADDED step_12
  // To start, print the menu
  app.onInput('help');
}
