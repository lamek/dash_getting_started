/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    var input = arguments.first;
    switch (input) {
      case 'help':
        _printUsage();
      case 'version':
        print('0.0.1');
      case 'wikipedia':
        print('Please enter the title of a wikipedia page');
        String? input = stdin.readLineSync();
        if (input != null) {
          input = input.trim().toLowerCase();
          final output = getWikipediaArticle(input);
          print(output);
        }

      default:
        print('unknown command!');
    }
  } else {
    print('unknown command!');
    _printUsage();
  }
}

void _printUsage() {
  print("The following commands are valid: 'help', 'version', 'wikipedia'");
}

String getWikipediaArticle(String title) {
  print('getting wikipedia article...');
  return 'failed to get wikipedia article.';
}
