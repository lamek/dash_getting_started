import 'package:flutter/material.dart';
import 'package:wikipedia/wikipedia.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: TitleText(text: 'Wikipedia Dart')),
        body: FeedView(),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text(text));
  }
}

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
              Text('Featured article'),
              Placeholder(child: SizedBox(height: 300, width: 300)),
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
