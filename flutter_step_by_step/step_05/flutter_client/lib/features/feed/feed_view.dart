/*
 Copyright 2025 The Dart and Flutter teams. All rights reserved.
 Use of this source code is governed by a BSD-style license that can be
 found in the LICENSE file.
 */
import 'package:flutter/material.dart';
import 'package:wikipedia/wikipedia.dart';

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
                child: Placeholder(child: SizedBox(height: 300, width: 300)),
              ),
              FeedItemContainer(
                title: 'On this day',
                child: Placeholder(child: SizedBox(height: 300, width: 300)),
              ),
              FeedItemContainer(
                title: 'Top read',
                child: Placeholder(child: SizedBox(height: 300, width: 300)),
              ),
              FeedItemContainer(
                title: 'Featured image',
                child: Placeholder(child: SizedBox(height: 300, width: 300)),
              ),
              FeedItemContainer(
                title: 'Random article',
                child: Placeholder(child: SizedBox(height: 300, width: 300)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: child,
          ),
        ],
      ),
    );
  }
}
