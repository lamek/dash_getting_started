/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:logging/logging.dart';
import 'package:step_11/cli.dart';
import 'package:step_11/src/framework/framework.dart';

void main(List<String> arguments) async {
  final app =
      CommandRunner<String?>()
        ..addCommand(HelpCommand())
        ..addCommand(VersionCommand()) // ADDED step_6
        ..addCommand(GetArticleByTitleCommand()) // ADDED step_8
        ..addCommand(ExitCommand());

  app.run();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print(
      '[${record.time}] ${record.loggerName}.${record.level.name}: ${record.message}',
    );
  });
}
