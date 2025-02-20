/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:step_6/cli.dart';

void main(List<String> arguments) async {
  final app = CommandRunner<String>()..addCommand(HelpCommand());
  // TODO: add commands
  await app.run();
}
