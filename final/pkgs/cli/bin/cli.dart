import 'package:cli/src/commands/get_article.dart';
import 'package:cli/src/commands/search.dart';
import 'package:command_runner/command_runner.dart';

void main(List<String> arguments) async {
  final app =
      CommandRunner<String>(
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
        ..addCommand(GetArticleCommand());

  app.run(arguments);
}
