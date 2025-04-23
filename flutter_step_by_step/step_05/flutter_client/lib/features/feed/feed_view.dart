/*
 Copyright 2025 The Dart and Flutter teams. All rights reserved.
 Use of this source code is governed by a BSD-style license that can be
 found in the LICENSE file.
 */
import 'package:flutter/material.dart';
import 'package:wikipedia/wikipedia.dart';

import './feed_item_widget.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    // Explain the following widgets: SingleChildScrollView, SizedBox, Wrap
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Human readable comes from pkg:wikipedia library
          Text(DateTime.now().humanReadable),
          SizedBox(height: 30),
          Wrap(
            children: [
              FeedItemContainer(
                title: 'Featured Article',
                child: Placeholder(),
              ),
              Text('On this day'),
              Placeholder(child: SizedBox(height: 300, width: 300)),
              Text('Top read'),
              Placeholder(child: SizedBox(height: 300, width: 300)),
              Text('Feature image'),
              Placeholder(child: SizedBox(height: 300, width: 300)),
              Text('Random article'),
              Placeholder(child: SizedBox(height: 300, width: 300)),
            ],
          ),
        ],
      ),
    );
  }
}
