/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:app/ui/build_context_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

import 'article_view.dart';

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
