/*
 Copyright 2025 The Dart and Flutter teams. All rights reserved.
 Use of this source code is governed by a BSD-style license that can be
 found in the LICENSE file.
 */

import 'package:flutter/material.dart';

class FeedItemContainer extends StatelessWidget {
  const FeedItemContainer({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          // We explicitly want to include the title as a FeedItem, so that Wrap works correctly
          Text(title),
          if (subtitle != null) Text(subtitle!),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Placeholder(child: SizedBox(height: 300, width: 300)),
          ),
        ],
      ),
    );
  }
}
