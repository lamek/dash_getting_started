import 'package:cli/cli.dart';
import 'package:cli/src/commands/get_article.dart';
import 'package:cli/src/commands/search.dart';
import 'package:command_runner/command_runner.dart';

void main(List<String> arguments) {
  void main(List<String> arguments) async {
    final app =
        CommandRunner<String?>(
            onOutput: (String output) async {
              await write(output);
            },
            onExit: (int exitCode) async {
              if (exitCode != 0) {
                // log or something
              }
            },
          )
          ..addCommand(HelpCommand())
          ..addCommand(SearchCommand())
          // ..addCommand(OnThisDayTimelineCommand())
          ..addCommand(GetArticleCommand());

    // ADDED step_12
    // Must be before app.run, or the app thinks its input
    await write('');
    await write(dartTitle);
    await write(wikipediaTitle);
    await write('');
  }
}
