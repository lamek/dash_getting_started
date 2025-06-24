import 'package:flutter/material.dart';

import 'features/feed/feed_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Lesson 4
      home: Scaffold(
        appBar: AppBar(title: Text('Wikipedia Dart'), centerTitle: false),
        body: SafeArea(child: FeedView()),
      ),
    );
  }
}
