import 'package:flutter/material.dart';
import 'package:flutter_client/destinations.dart';
import 'package:flutter_client/features/feed/feed_view.dart';
import 'package:flutter_client/features/feed/feed_view_model.dart';
import 'package:flutter_client/features/on_this_day/timeline_page_view.dart';
import 'package:flutter_client/features/on_this_day/timeline_view_model.dart';
import 'package:flutter_client/features/saved_articles/saved_articles_view.dart';
import 'package:flutter_client/features/saved_articles/saved_articles_view_model.dart';
import 'package:flutter_client/providers/repository_provider.dart';
import 'package:flutter_client/ui/app_localization.dart';
import 'package:flutter_client/ui/build_context_util.dart';
import 'package:flutter_client/ui/shared_widgets/adaptive_navigation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigation(
      title: Text(AppStrings.wikipediaDart, style: context.titleLarge),
      navigationItems: {
        for (final d in Destinations.values)
          d.label: context.isCupertino ? d.cupertinoIcon : d.materialIcon,
      },
      tabs: <Widget>[
        FeedView(
          viewModel: FeedViewModel(
            repository: RepositoryProvider.of(context).feedRepository,
          ),
        ),
        TimelinePageView(
          viewModel: TimelineViewModel(
            repository: RepositoryProvider.of(context).timelineRepository,
          ),
        ),
        SavedArticlesView(
          viewModel: SavedArticlesViewModel(
            repository: RepositoryProvider.of(context).savedArticlesRepository,
          ),
        ),
      ],
    );
  }
}
