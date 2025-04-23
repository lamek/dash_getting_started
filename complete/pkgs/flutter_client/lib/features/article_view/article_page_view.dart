import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/features/article_view/article_view.dart';
import 'package:flutter_client/ui/build_context_util.dart';
import 'package:wikipedia/wikipedia.dart';

class ArticlePageView extends StatelessWidget {
  const ArticlePageView({required this.summary, super.key});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isCupertino ? const CupertinoNavigationBar() : AppBar(),
      body: ArticleView(summary: summary),
    );
  }
}
