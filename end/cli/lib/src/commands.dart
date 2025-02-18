/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:cli/src/model/timeline_event.dart';
import 'package:cli/src/wikipedia/article.dart';
import 'package:cli/src/wikipedia/random_article.dart';
import 'package:cli/src/wikipedia/timeline.dart';
import 'package:yaml/yaml.dart';

import '../cli.dart';
import 'model/command.dart';

class HelpCommand extends Command<String> {
  @override
  final String name = 'help';

  @override
  final String description = 'Print this usage information.';

  @override
  List<String> get aliases => ['h'];

  @override
  Stream<String> run() async* {
    final buffer = StringBuffer();
    for (var command in runner.commands) {
      buffer.writeln(command.usage);
    }

    yield buffer.toString();
  }
}

class ExitCommand extends Command<String> {
  @override
  final String name = 'quit';

  @override
  final String description = 'Exit the program';

  @override
  List<String> get aliases => ['q'];

  @override
  Stream<String> run() async* {
    yield 'Exiting program.'.instructionText;
    runner.quit();
  }
}

class VersionCommand extends Command<String> {
  @override
  final String name = 'version';

  @override
  final String description = 'Print current version';

  @override
  List<String> get aliases => ['v'];

  @override
  Stream<String> run() async* {
    // Absolute path to the script entry point (/bin/cli.dart, in this case)
    final segments = Platform.script.path.split('/');
    final projectDir = segments.sublist(0, segments.length - 2).join('/');
    final file = File('$projectDir/pubspec.yaml');

    final YamlMap contents = loadYaml(file.readAsStringSync());
    yield 'Version ${contents['version']}';
  }
}

class RandomArticleCommand extends Command<String> {
  @override
  final String name = 'random article';

  @override
  final String description =
      'Print the summary of a random article from Wikipedia.';

  @override
  List<String> get aliases => ['r'];

  @override
  Stream<String> run() async* {
    final summary = await getRandomArticleSummary();
    yield renderSummary(summary);
  }
}

class GetArticleByTitleCommand extends CommandArgs<String> {
  @override
  final String name = 'article';

  @override
  List<Arg> arguments = [Arg('title', help: 'STRING', required: true)];

  @override
  final String description = 'Print the summary of an article from Wikipedia.';

  @override
  List<String> get aliases => ['a'];

  @override
  Stream<String> run({Map<Arg, String?>? args}) async* {
    if (args == null) {
      return;
    }
    if (!validateArgs(args)) {
      yield 'Invalid argument!';
      yield 'This command requires one argument. Example: article title="dart (programming language)"';
      return;
    }

    final articleTitle =
        args.entries.firstWhere((entry) => entry.key.name == 'title').value;
    final summary = await getArticleSummary(articleTitle!);
    yield renderSummary(summary);
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
        yield _renderEvent(event);
        // Figure out what to do next
        final next = stdin.readLineSync();
        if (next == 'n') {
          if (i == timeline.length - 1) {
            yield 'At end of list. Starting over'.instructionText;
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

  String _renderEvent(OnThisDayEvent event) {
    var eventText = event.text.splitLinesByLength(50).join('\n');

    final StringBuffer strBuffer =
        StringBuffer('\n')
          ..writeln('* ${event.year}'.titleText)
          ..writeln(eventText)
          ..writeln()
          ..writeln("'n' for next, 'q' to return to main menu".instructionText);
    return strBuffer.toString();
  }
}
