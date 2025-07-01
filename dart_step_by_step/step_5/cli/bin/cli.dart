/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:command_runner/command_runner.dart';

const version = '0.0.1';

// [Step 5 updates] Added <String> generic. Added ..addCommand call
void main(List<String> arguments) {
  var commandRunner = CommandRunner()..addCommand(HelpCommand());
  commandRunner.run(arguments);
}
