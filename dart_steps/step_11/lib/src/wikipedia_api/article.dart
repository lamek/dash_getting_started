/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../models/summary.dart';

final getArticleLogger = Logger('getArticleSummary logger');

// ADDED step_8
Future<Summary> getArticleSummary(String articleTitle) async {
  final http.Client client = http.Client();
  try {
    final Uri url = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/summary/$articleTitle',
    );
    getArticleLogger.info('url: ${url.toString()}');
    final http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      getArticleLogger.info('status code: 200');
      final Map<String, Object?> jsonData =
          jsonDecode(response.body) as Map<String, Object?>;
      final Summary summary = Summary.fromJson(jsonData);
      getArticleLogger.info('Summary deserialized. ${summary.toString()}');
      return Summary.fromJson(jsonData);
    } else {
      getArticleLogger.warning(
        'HttpException. Status code: ${response.statusCode}, body: ${response.body}',
      );
      // Indicates a runtime error, but not a bug in the code.
      throw HttpException(
        '[WikipediaDart.getArticleSummary] '
        'statusCode=${response.statusCode}, body=${response.body}',
      );
    }
    // A FormatException is thrown when the response body isn't valid JSON.
    // This would come from the Wikipedia API. It should be indicated to the
    // end user, but it shouldn't terminate the program.
  } on FormatException catch (e) {
    getArticleLogger.warning(
      'FormatException. Error message: ${e.message}, source: ${e.source}, offset: ${e.offset ?? 'N/A'}',
    );
    rethrow;
  } finally {
    client.close();
  }
}
