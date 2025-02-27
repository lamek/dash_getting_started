import 'package:args/command_runner.dart';
import 'package:static_cli/commands/article.dart';

const String version = '0.0.1';

void main(List<String> args) async {
  final runner = CommandRunner<String>(
    'wiki',
    'Read Wikipedia articles in the terminal',
  )..addCommand(ArticleCommand());
  final output = await runner.run(args);
  print(output);
}

// ArgParser buildParser() {
//   final today = DateTime.now();
//   final parser =
//       ArgParser()
//         ..addFlag(
//           'help',
//           abbr: 'h',
//           negatable: false,
//           help: 'Print this usage information.',
//         )
//         ..addFlag(
//           'verbose',
//           abbr: 'v',
//           negatable: false,
//           help: 'Show additional command output.',
//         )
//         ..addFlag(
//           'version',
//           negatable: false,
//           help: 'Print the version of this program.',
//         );
//
//   var articleCommand = parser.addCommand('article');
//   articleCommand.addOption(
//     'title',
//     abbr: 't',
//     valueHelp: 'STRING',
//     help:
//         'Fetches an article from the Wikipedia API and prints it to the console.',
//   );
//
//   var searchCommand = parser.addCommand('search');
//   searchCommand.addOption(
//     'term',
//     abbr: 't',
//     valueHelp: 'STRING',
//     help: 'Search Wikipedia for articles that match the given term.',
//   );
//
//   var timelineCommand = parser.addCommand('timeline');
//   timelineCommand.addOption(
//     'date',
//     abbr: 'd',
//     valueHelp: 'MM/DD',
//     defaultsTo: '${today.month}/${today.day}',
//     help:
//         'Fetches the "On This Day" timeline feed from Wikipedia and prints it to the console.',
//   );
//   return parser;
// }
//
// void printUsage(ArgParser argParser) {
//   print(
//     [
//       'Usage: dart wikipedia.dart <flags> [arguments.dart]',
//       '',
//       'Global options:',
//       argParser.usage,
//       '',
//       'Available commands:',
//       for (var cmd in argParser.commands.entries)
//         '${cmd.key}  ${cmd.value.usage}',
//     ].join('\n'),
//   );
// }
//
// void main(List<String> arguments.dart) async {
//   final ArgParser argParser = buildParser();
//
//   try {
//     final ArgResults results = argParser.parse(arguments.dart);
//     bool verbose = false;
//
//     // Process the parsed arguments.dart.
//     if (results.flag('help')) {
//       printUsage(argParser);
//       return;
//     }
//     if (results.flag('version')) {
//       print('cli version: $version');
//       return;
//     }
//     if (results.flag('verbose')) {
//       verbose = true;
//     }
//
//     if (results.command != null) {
//       switch (results.command!.name) {
//         case 'article':
//           if (results.command!.option('title') != null) {
//             var articles = await getArticleByTitle(
//               results.command!.option('title')!,
//             );
//             for (var article in articles) {
//               print(article.title);
//             }
//           } else {
//             print('getting random article');
//           }
//         case 'search':
//           if (results.command!.option('term') != null) {
//             var searchResults = await search(results.command!.option('term')!);
//             for (var result in searchResults.results) {
//               print(result.title);
//             }
//           } else {
//             print('Please include a search term');
//           }
//         case 'timeline':
//           if (results.command!.option('date') != null) {
//             print(results.command!.option('date'));
//           } else {
//             print('getting timeline for today\'s date');
//           }
//       }
//     }
//   } on FormatException catch (e) {
//     // Print usage information if an invalid argument was provided.
//     print('Error: ${e.message}');
//     print('');
//     printUsage(argParser);
//   }
// }
