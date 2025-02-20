/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:step_5/src/command_runner.dart';
import 'package:step_5/src/commands.dart';

void main(List<String> arguments) async {
  final app = CommandRunner<String>()..addCommand(HelpCommand());
  // TODO: add commands
  await app.run();
}
