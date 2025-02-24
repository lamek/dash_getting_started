/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/timeline.dart';

Future<OnThisDayTimeline> getTimelineForToday() async {
  final today = DateTime.now();
  final month = today.month;
  final day = today.day;

  final String padMonth = month < 10 ? '0$month' : '$month';
  final String padDay = day < 10 ? '0$day' : '$day';

  final http.Client client = http.Client();
  final Uri url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/feed/onthisday/all/$padMonth/$padDay',
  );

  final http.Response response = await client.get(url);
  final Map<String, Object?> jsonData =
      jsonDecode(response.body) as Map<String, Object?>;
  return OnThisDayTimeline.fromJson(jsonData);
}
