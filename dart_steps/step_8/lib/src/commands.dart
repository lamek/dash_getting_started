/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:io';

import 'package:yaml/yaml.dart';

import 'command_runner/command_runner.dart';
import 'models/summary.dart';
import 'wikipedia_api/article.dart';

class HelpCommand extends Command<String?> {
  @override
  final String name = 'help';

  @override
  final String description = 'Print this usage information.';

  @override
  List<String> get aliases => ['h'];

  @override
  String run() {
    final buffer = StringBuffer();
    for (var command in runner.commands) {
      buffer.writeln(command.usage);
    }

    return buffer.toString();
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
  String? run() {
    runner.quit();
    return null;
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
  String? run() {
    // Absolute path to the script entry point (/bin/cli.dart, in this case)
    final segments = Platform.script.path.split('/');
    final projectDir = segments.sublist(0, segments.length - 2).join('/');
    final file = File('$projectDir/pubspec.yaml');

    final YamlMap contents = loadYaml(file.readAsStringSync());
    return 'Version ${contents['version']}';
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
  Future<String?> run({Map<Arg, String?>? args}) async {
    // TODO: handle error (runtime, validate args).
    final articleTitle =
        args?.entries.firstWhere((entry) => entry.key.name == 'title').value;
    final summary = await getArticleSummary(articleTitle!);
    return renderSummary(summary);
  }

  String renderSummary(Summary summary) {
    var buffer = StringBuffer('${summary.titles.normalized}\n');
    buffer.writeln(summary.description);
    buffer.writeln();
    buffer.writeln(summary.extract);
    return buffer.toString();
  }
}
