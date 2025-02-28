import 'package:cli/cli.dart';
import 'package:command_runner/command_runner.dart';

void main(List<String> arguments) async {
  final errorLogger = initFileLogger('errors');
  final app =
      CommandRunner<String>(
          onOutput: (String output) async {
            await write(output);
          },
          onExit: (int exitCode) async {
            if (exitCode != 0) {
              errorLogger.severe('Application exited with exit code $exitCode');
            }
          },
          onError: (Object error) {
            if (error is Error) {
              errorLogger.severe(
                '[Error!] ${error.toString()}\n${error.stackTrace}',
              );
              throw error;
            }
            // todo: handle exceptions
          },
        )
        ..addCommand(HelpCommand())
        ..addCommand(SearchCommand())
        ..addCommand(GetArticleCommand());

  app.run(arguments);
}
