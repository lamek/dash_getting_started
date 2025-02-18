/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    var input = arguments.first;
    switch (input) {
      case 'help':
        _printUsage();
      case 'version':
        print('0.0.1');
      case 'wikipedia':
        print('Please enter the title of a wikipedia page.');
        String? input = stdin.readLineSync();
        if (input != null) {
          input = input.trim().toLowerCase();
          final output = await getWikipediaArticle(input);
          print(output);
          exit(0);
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

Future<String> getWikipediaArticle(String title) async {
  final client = http.Client();
  final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$title');
  final response = await client.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return 'Failed to fetch from Wikipedia';
  }
}
