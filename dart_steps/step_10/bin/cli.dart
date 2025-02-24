/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:step_10/cli.dart';

void main(List<String> arguments) async {
  final app =
      CommandRunner<String?>(
          onOutput: (String output) async {
            print(output);
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
        ..addCommand(ExitCommand());

  await app.run();

  app.onError.listen((error) {
    if (error is Error) {
      throw error;
    }

    // Swallow exceptions
    if (error is Exception) {
      print(error);
    }
  });
}
