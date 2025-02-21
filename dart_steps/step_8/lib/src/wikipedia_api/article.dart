/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/summary.dart';

// ADDED step_8
Future<Summary> getArticleSummary(String articleTitle) async {
  final http.Client client = http.Client();
  final Uri url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );
  final http.Response response = await client.get(url);
  final Map<String, Object?> jsonData =
      jsonDecode(response.body) as Map<String, Object?>;
  return Summary.fromJson(jsonData);
}
