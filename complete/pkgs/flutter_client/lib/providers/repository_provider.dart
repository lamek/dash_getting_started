import 'package:flutter/material.dart';
import 'package:flutter_client/features/feed/feed_repository.dart';
import 'package:flutter_client/features/on_this_day/timeline_repository.dart';
import 'package:flutter_client/features/saved_articles/saved_articles_repository.dart';

class RepositoryProvider extends InheritedWidget {
  const RepositoryProvider({
    required super.child,
    required this.feedRepository,
    required this.timelineRepository,
    required this.savedArticlesRepository,
    super.key,
  });

  final FeedRepository feedRepository;
  final TimelineRepository timelineRepository;
  final SavedArticlesRepository savedArticlesRepository;

  static RepositoryProvider of(BuildContext context) {
    final RepositoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();
    assert(result != null, 'No RepositoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(RepositoryProvider old) {
    return false;
  }
}
