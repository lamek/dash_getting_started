/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isNotEmpty && arguments.first == 'version') {
    print('Dart Wikipedia version $version');
  } else if (arguments.isNotEmpty && arguments.first == 'help') {
    printUsage();
  } else if (arguments.isNotEmpty && arguments.first == 'wikipedia') {
    // contrived
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    runApp(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}

void runApp(List<String>? arguments) {
  late String? articleTitle;
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    articleTitle = stdin.readLineSync();
    return;
  } else {
    articleTitle = arguments.join(', ');
  }

  print('Looking up articles about $articleTitle. Please wait.');
  for (var arg in arguments) {
    print('Here ya go!');
    print('(Pretend this an article about $arg)');
  }
}
