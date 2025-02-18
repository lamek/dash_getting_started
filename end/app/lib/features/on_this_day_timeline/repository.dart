/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wikipedia_api/wikipedia_api.dart';

class TimelineRepository {
  OnThisDayTimeline? _cachedTimeline;

  Future<OnThisDayTimeline> getTimelineForDate(int month, int day) async {
    if (_cachedTimeline != null) return _cachedTimeline!;
    final http.Client client = http.Client();

    try {
      final Uri url = Uri.http('localhost:8080', '/timeline/$month/$day');
      final http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final Map<String, Object?> jsonData = jsonDecode(response.body);
        _cachedTimeline = OnThisDayTimeline.fromJson(jsonData);
        return _cachedTimeline!;
      } else {
        throw Exception(
          '[TimelineRepository.getTimelineForDate] '
          'statusCode=${response.statusCode}, '
          'body=${response.body}',
        );
      }
    } finally {
      client.close();
    }
  }
}
