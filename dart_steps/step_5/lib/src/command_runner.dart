/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

/// Establishes a protocol for the app to communicate continuously with I/O.
/// When [run] is called, the app will start waiting for input from stdin.
/// Input can also be added programatically via the [onInput] method.
class CommandRunner {
  Future<void> run() async {
    await for (final List<int> data in stdin) {
      // Convert byte data into a string, and trim whitespace so that it's
      // easier to handle user input.
      final String input = String.fromCharCodes(data).trim();
      await onInput(input);
    }
  }

  Future<void> onInput(String input) async {
    // TODO: handle user input
    if (input == 'exit') {
      quit();
    } else {
      print('Got input: $input');
    }
  }

  void quit([int code = 0]) => _quit(code);

  void _quit(int code) {
    // TODO: add any teardown code here.
    exit(code);
  }
}
