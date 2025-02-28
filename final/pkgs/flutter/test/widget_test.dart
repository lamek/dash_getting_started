// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app/features/saved_articles/saved_articles_repository.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/providers/repository_provider.dart';
import 'package:flutter_app/ui/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes/fake_feed_repository.dart';
import 'fakes/fake_timeline_repository.dart';

testApp(WidgetTester tester, Widget body) async {
  tester.view.devicePixelRatio = 1.0;
  await tester.binding.setSurfaceSize(const Size(1200, 800));
  await tester.pumpWidget(
    RepositoryProvider(
      timelineRepository: FakeTimelineRepository(),
      feedRepository: FakeFeedRepository(),
      savedArticlesRepository: SavedArticlesRepository(),
      child: MaterialApp(
        theme: MaterialAppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
      ),
    ),
  );
}

void main() {
  testWidgets('App runs with fakes', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // The word 'Today' might exist in the article text.
    // We care about finding the title
    expect(find.text('Today'), findsAtLeastNWidgets(1));

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
