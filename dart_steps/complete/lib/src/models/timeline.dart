/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

// ignore_for_file: always_specify_types

import 'dart:collection';

import 'timeline_event.dart';

class OnThisDayTimeline
    extends IterableMixin<OnThisDayEvent> {
  /// Returns a new [OnThisDayTimeline] instance.
  OnThisDayTimeline({
    this.all = const <OnThisDayEvent>[],
    this.births = const <OnThisDayEvent>[],
    this.events = const <OnThisDayEvent>[],
    this.selected = const <OnThisDayEvent>[],
  });

  final List<OnThisDayEvent> all;

  final List<OnThisDayEvent> births;

  final List<OnThisDayEvent> events;

  final List<OnThisDayEvent> selected;

  @override
  Iterator<OnThisDayEvent> get iterator => all.iterator;

  /// Returns a new [OnThisDayTimeline] instance
  static OnThisDayTimeline fromJson(
    Map<String, Object?> json,
  ) {
    final List<OnThisDayEvent> births =
        json.containsKey('births')
            ? (json['births']! as Iterable)
                .map((e) => OnThisDayEvent.fromJson(e))
                .toList()
            : const <OnThisDayEvent>[];

    final List<OnThisDayEvent> events =
        json.containsKey('events')
            ? (json['events']! as Iterable)
                .map((e) => OnThisDayEvent.fromJson(e))
                .toList()
            : const <OnThisDayEvent>[];

    final List<OnThisDayEvent> selected =
        json.containsKey('selected')
            ? (json['selected']! as Iterable)
                .map((e) => OnThisDayEvent.fromJson(e))
                .toList()
            : const <OnThisDayEvent>[];

    final all = <OnThisDayEvent>[
      ...births,
      ...events,
      ...selected,
    ]..sort((OnThisDayEvent eventA, OnThisDayEvent eventB) {
      return eventB.year!.compareTo(eventA.year!);
    });

    return OnThisDayTimeline(
      all: all,
      births: births,
      events: events,
      selected: selected,
    );
  }

  OnThisDayEvent operator [](int i) {
    return all[i];
  }

  @override
  String toString() =>
      'OnThisDayResponse['
      'births=$births, '
      'events=$events, '
      'selected=$selected'
      ']';
}
