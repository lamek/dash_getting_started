import 'package:app/features/on_this_day_timeline/page_view.dart';
import 'package:app/features/on_this_day_timeline/view_model.dart';
import 'package:app/features/saved_articles/saved_articles_view.dart';
import 'package:app/features/saved_articles/saved_articles_view_model.dart';
import 'package:app/ui/app_theme.dart';
import 'package:app/ui/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'repository_provider.dart';
import 'ui/build_context_util.dart';

void main() async {
  runApp(RepositoryProvider(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
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
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onSelectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = context.breakpoint;
    return Scaffold(
      appBar: AppBar(),
      drawer: breakpoint.width != BreakpointWidth.small ? Drawer() : null,
      body:
          [
            TimelinePageView(
              viewModel: TimelineViewModel(
                repository: RepositoryProvider.of(context).timelineRepository,
              ),
            ),
            SavedArticlesView(
              viewModel: SavedArticlesViewModel(
                repository:
                    RepositoryProvider.of(context).savedArticlesRepository,
              ),
            ),
          ][_selectedIndex],
      bottomNavigationBar: switch ((breakpoint.width, context.isCupertino)) {
        (BreakpointWidth.small, true) => CupertinoTabBar(
          currentIndex: _selectedIndex,
          onTap: _onSelectTab,
          items: [],
        ),
        (BreakpointWidth.small, false) => TabBar(onTap: _onSelectTab, tabs: []),
        _ => null,
      },
    );
  }
}
