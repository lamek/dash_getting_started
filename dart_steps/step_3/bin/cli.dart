/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

import 'package:http/http.dart' as http;

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

void runApp(List<String>? arguments) async {
  late String? articleTitle;
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    articleTitle = stdin.readLineSync();
    return;
  } else {
    articleTitle = arguments.join(', ');
  }

  print('Looking up articles about $articleTitle. Please wait.');

  // Code from here to end of file is different
  var article = await getWikipediaArticle(articleTitle);
  print(article);
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final http.Client client = http.Client();
  final Uri url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );
  final http.Response response = await client.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Error: failed to fetch article $articleTitle';
}
