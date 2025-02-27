/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:command_runner/command_runner.dart';
import 'package:wikipedia/wikipedia.dart';

class SearchCommand extends Command<String> {
  @override
  String get description => 'Search for Wikipedia articles.';

  @override
  String get name => 'search';

  @override
  String get abbr => 's';

  @override
  String get valueHelp => 'STRING';

  @override
  String get help =>
      'Prints a list of links to Wikipedia articles that match the given term.';

  @override
  FutureOr<String> run(ArgResults args) async {
    if (args.commandArg == null) {
      return 'Please include a search term';
    }

    try {
      final SearchResults results = await search(args.commandArg!);
      final buffer = StringBuffer('Matching articles:\n');
      for (var result in results.results) {
        buffer.writeln(result.title);
      }
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
