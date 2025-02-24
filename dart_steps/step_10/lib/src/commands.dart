/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

import 'package:yaml/yaml.dart';

import 'command_runner/command_runner.dart';
import 'command_runner/exceptions.dart';
import 'models/summary.dart';
import 'wikipedia_api/article.dart';
import 'wikipedia_api/timeline.dart';

class HelpCommand extends Command<String?> {
  @override
  final String name = 'help';

  @override
  final String description = 'Print this usage information.';

  @override
  List<String> get aliases => ['h'];

  @override
  Stream<String?> run() async* {
    final buffer = StringBuffer();
    for (var command in runner.commands) {
      buffer.writeln(command.usage);
    }

    yield buffer.toString();
  }
}

class ExitCommand extends Command<String?> {
  @override
  final String name = 'quit';

  @override
  final String description = 'Exit the program';

  @override
  List<String> get aliases => ['q'];

  @override
  Stream<String?> run() async* {
    runner.quit();
  }
}

// ADDED step_6
class VersionCommand extends Command<String?> {
  @override
  final String name = 'version';

  @override
  final String description = 'Print current version';

  @override
  List<String> get aliases => ['v'];

  @override
  Stream<String?> run() async* {
    // Absolute path to the script entry point (/bin/cli.dart, in this case)
    final segments = Platform.script.path.split('/');
    final projectDir = segments.sublist(0, segments.length - 2).join('/');
    final file = File('$projectDir/pubspec.yaml');

    final YamlMap contents = loadYaml(file.readAsStringSync());
    yield 'Version ${contents['version']}';
  }
}

// ADDED step_8
class GetArticleByTitleCommand extends CommandWithArgs<String?> {
  @override
  final String name = 'article';

  @override
  List<Arg> arguments = [Arg('title', help: 'STRING', required: true)];

  @override
  final String description = 'Print the summary of an article from Wikipedia.';

  @override
  List<String> get aliases => ['a'];

  @override
  Stream<String?> run({Map<Arg, String?>? args}) async* {
    // ADDED step_10
    if (args == null || !validateArgs(args)) {
      throw ArgumentException(
        'Invalid argument! This command requires one argument. Example: article title="dart (programming language)"',
      );
    }
    final articleTitle =
        args.entries.firstWhere((entry) => entry.key.name == 'title').value;
    final summary = await getArticleSummary(articleTitle!);
    yield renderSummary(summary);

    // ADDED step_10
    try {
      final summary = await getArticleSummary(articleTitle!);
      yield renderSummary(summary);
    } on HttpException {
      yield "Failed to connect to Wikipedia API. Please wait a moment and try again.";
    } on FormatException catch (e) {
      throw FormatException('[GetArticleByTitleCommand.run] ${e.message}');
    }
  }

  String renderSummary(Summary summary) {
    var buffer = StringBuffer('${summary.titles.normalized}\n');
    buffer.writeln(summary.description);
    buffer.writeln();
    buffer.writeln(summary.extract);
    return buffer.toString();
  }
}

class OnThisDayTimelineCommand extends Command<String> {
  @override
  final String name = 'timeline';

  @override
  final String description =
      'Print a list of events that happened on todays date throughout history.';

  @override
  List<String> get aliases => ['t'];

  @override
  Stream<String> run() async* {
    try {
      final timeline = await getTimelineForToday();
      int i = 0;
      while (i < timeline.length) {
        final event = timeline.selected[i];
        yield event.toString();
        // Figure out what to do next
        final next = stdin.readLineSync();
        if (next == 'n') {
          if (i == timeline.length - 1) {
            yield 'At end of list. Starting over';
            i = 0;
          } else {
            i++;
            continue;
          }
        } else if (next == 'q') {
          return;
        }
      }
    } finally {
      runner.onInput('help');
    }
  }
}
