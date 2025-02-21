/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:step_9/cli.dart';

void main(List<String> arguments) async {
  final app =
      CommandRunner<String?>()
        ..addCommand(HelpCommand())
        ..addCommand(VersionCommand()) // ADDED step_6
        ..addCommand(GetArticleByTitleCommand()) // ADDED step_8
        ..addCommand(ExitCommand());
  await app.run();
}
