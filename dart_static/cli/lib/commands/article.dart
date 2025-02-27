/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';

import 'package:args/command_runner.dart';

class ArticleCommand extends Command<String> {
  @override
  String get description => 'Fetches an article from the Wikipedia API.';

  @override
  String get name => 'article';

  @override
  FutureOr<String>? run() async {
    return 'article';
  }
}
