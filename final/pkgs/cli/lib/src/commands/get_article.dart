/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:command_runner/command_runner.dart';
import 'package:wikipedia/wikipedia.dart';

class GetArticleCommand extends Command<String> {
  @override
  String get description => 'Read an article from Wikipedia';

  @override
  String get name => 'article';

  @override
  String get help => 'Gets an article by exact canonical wikipedia title.';

  @override
  String get defaultValue => 'cat';

  @override
  String get valueHelp => 'STRING';

  @override
  FutureOr<String> run(ArgResults args) async {
    try {
      var title = args.commandArg ?? defaultValue;
      final List<Article> articles = await getArticleByTitle(title);
      // API returns a list of articles, but we only care about the closest hit.
      final article = articles.first;
      final buffer = StringBuffer('${article.title.titleText}\n');
      buffer.write(article.extract);
      return buffer.toString();
    } on HttpException catch (e) {
      // todo log
      rethrow;
    } on FormatException catch (e) {
      // todo log
      rethrow;
    }
  }
}
