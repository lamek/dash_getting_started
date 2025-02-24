/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */
import 'summary.dart';

class OnThisDayEvent {
  /// Returns a new [OnThisDayEvent] instance.
  OnThisDayEvent({
    required this.text,
    this.pages = const <Summary>[],
    this.year,
  });

  /// Short description of the event
  String text;

  /// List of pages related to the event
  List<Summary> pages;

  /// Year of the event
  final int? year;

  /// Returns -1 if [year] is null
  int get yearsAgo => year != null ? DateTime.now().year - year! : -1;

  static OnThisDayEvent fromJson(Map<String, Object?> json) {
    return switch (json) {
      {
        'text': final String text,
        'year': final int year,
        'pages': final Iterable pages,
      } =>
        OnThisDayEvent(
          text: text,
          year: year,
          pages: <Summary>[for (final p in pages) Summary.fromJson(p)],
        ),
      // holidays don't have years
      {'text': final String text, 'pages': final Iterable pages} =>
        OnThisDayEvent(
          text: text,
          pages: <Summary>[
            for (final Map<String, Object?> p in pages) Summary.fromJson(p),
          ],
        ),
      _ =>
        throw const FormatException('Invalid json in OnThisDayEvent.fromJson'),
    };
  }
}
