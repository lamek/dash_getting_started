import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/features/feed/feed_repository.dart';
import 'package:flutter_client/features/on_this_day/timeline_repository.dart';
import 'package:flutter_client/features/saved_articles/saved_articles_repository.dart';
import 'package:flutter_client/home.dart';
import 'package:flutter_client/providers/breakpoint_provider.dart';
import 'package:flutter_client/providers/repository_provider.dart';
import 'package:flutter_client/ui/breakpoint.dart';
import 'package:flutter_client/ui/build_context_util.dart';
import 'package:flutter_client/ui/theme/theme.dart';

void main() async {
  runApp(
    RepositoryProvider(
      feedRepository: FeedRepository(),
      timelineRepository: TimelineRepository(),
      savedArticlesRepository: SavedArticlesRepository(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BreakpointProvider(
      breakpoint: Breakpoint.currentDevice(context),
      child: Builder(
        builder: (context) {
          return context.isCupertino
              ? CupertinoApp(
                theme: CupertinoAppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                home: const HomeView(),
              )
              : MaterialApp(
                theme: MaterialAppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                home: const HomeView(),
              );
        },
      ),
    );
  }
}
