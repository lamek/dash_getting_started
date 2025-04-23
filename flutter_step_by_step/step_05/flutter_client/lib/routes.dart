import 'package:flutter/material.dart';

import 'features/feed/feed_view.dart';

typedef Destination =
    ({String title, String label, IconData icon, WidgetBuilder view});

final destinations = <Destination>[
  (
    title: 'Wikipedia Dart',
    label: 'Explore',
    icon: Icons.home,
    view: (context) => FeedView(),
  ),
  (
    title: 'On this day',
    label: 'Timeline',
    icon: Icons.calendar_today_outlined,
    view: (context) => Placeholder(),
  ),
  (
    title: 'Saved articles',
    label: 'Saved',
    icon: Icons.bookmark_border,
    view: (context) => Placeholder(),
  ),
];
