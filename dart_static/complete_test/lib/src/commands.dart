/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'dart:async';

import 'package:logging/logging.dart';

import 'framework/framework.dart';

// TODO THis actually shouldn't be a Command
class HelpCommand extends Command<String?> {
  HelpCommand({Logger? logger}) : logger = logger ?? Logger('HelpCommand') {
    addFlag('verbose', abbr: 'v');
  }

  @override
  String? get abbr => 'h';

  @override
  String get description => 'Prints usage information to the command line.';

  @override
  String? get help => 'Prints this usage information';

  @override
  String get name => 'help';

  @override
  final Logger logger;

  @override
  FutureOr<String?> run(ArgResults results) async {
    final buffer = StringBuffer();
    for (var command in runner.commands) {
      buffer.writeln(command.usage);
    }

    return buffer.toString();
  }
}

//
// class ExitCommand extends Command<String?> {
//   @override
//   final String name = 'quit';
//
//   @override
//   final String description = 'Exit the program';
//
//   @override
//   List<String> get aliases => ['q'];
//
//   @override
//   Stream<String?> run() async* {
//     runner.quit();
//   }
// }
//
// // ADDED step_6
// class VersionCommand extends Command<String?> {
//   @override
//   final String name = 'version';
//
//   @override
//   final String description = 'Print current version.';
//
//   @override
//   List<String> get aliases => ['v'];
//
//   @override
//   Stream<String?> run() async* {
//     // Absolute path to the script entry point (/bin/wikipedia_cli.dart, in this case)
//     final segments = Platform.script.path.split('/');
//     final projectDir = segments.sublist(0, segments.length - 2).join('/');
//     final file = File('$projectDir/pubspec.yaml');
//
//     final YamlMap contents = loadYaml(file.readAsStringSync());
//     yield 'Version ${contents['version']}';
//   }
// }

// // ADDED step_8
// class GetArticleByTitleCommand extends CommandWithArgs<String?> {
//   GetArticleByTitleCommand() {
//     // Added step_12 to make output nicer
//     logger.level = Level.WARNING;
//     logger.onRecord.listen((LogRecord record) {
//       print(record);
//     });
//   }
//
//   @override
//   final String name = 'article';
//
//   @override
//   List<Arg> arguments = [Arg('title', help: 'STRING', required: true)];
//
//   @override
//   final String description = 'Print the summary of an article from Wikipedia.';
//
//   @override
//   List<String> get aliases => ['a'];
//
//   final logger = Logger('getArticleSummary tracer');
//
//   @override
//   Stream<String?> run({Map<Arg, String?>? args}) async* {
//     // ADDED step_10
//     logger.info('Command.run with args $args');
//     if (args == null || !validateArgs(args)) {
//       logger.info('Command.run ArgumentException');
//       throw ArgumentException(
//         'Invalid argument! This command requires one argument. Example: article title="dart (programming language)"',
//       );
//     }
//     final articleTitle =
//         args.entries.firstWhere((entry) => entry.key.name == 'title').value;
//
//     // ADDED step_10
//     try {
//       final summary = await getArticleSummary(articleTitle!, logger);
//       yield _renderSummary(summary);
//     } on HttpException {
//       yield "Failed to connect to Wikipedia API. Please wait a moment and try again.";
//     } on FormatException catch (e) {
//       throw FormatException('[GetArticleByTitleCommand.run] ${e.message}');
//     }
//   }
//
//   String _renderSummary(Summary summary) {
//     // ADDED step_12 (added .titleText formatting)
//     var buffer = StringBuffer('${summary.titles.normalized.titleText}\n');
//     buffer.writeln(summary.description);
//     buffer.writeln();
//     buffer.writeln(summary.extract);
//     return buffer.toString();
//   }
// }

// class OnThisDayTimelineCommand extends Command<String?> {
//   @override
//   final String name = 'timeline';
//
//   @override
//   final String description =
//       'Print a list of events that happened on todays date throughout history.';
//
//   @override
//   List<String> get aliases => ['t'];
//
//   @override
//   Stream<String?> run() async* {
//     try {
//       final timeline = await getTimelineForToday();
//       int i = 0;
//       while (i < timeline.length) {
//         final event = timeline.selected[i];
//         yield _renderEvent(event);
//         // Figure out what to do next
//         final next = stdin.readLineSync();
//         if (next == 'n') {
//           if (i == timeline.length - 1) {
//             yield 'At end of list. Starting over'.instructionText;
//             i = 0;
//           } else {
//             i++;
//             continue;
//           }
//         } else if (next == 'q') {
//           return;
//         }
//       }
//     } finally {
//       runner.onInput('help');
//     }
//   }
//
//   String _renderEvent(OnThisDayEvent event) {
//     var eventText = event.text.splitLinesByLength(50).join('\n');
//
//     final StringBuffer strBuffer =
//         StringBuffer('\n')
//           ..writeln('* ${event.year}'.titleText)
//           ..writeln(eventText)
//           ..writeln()
//           ..writeln("'n' for next, 'q' to return to main menu".instructionText);
//     return strBuffer.toString();
//   }
// }
