import 'package:cli/cli.dart' as cli;
import 'package:cli/src/console.dart' as console;

void main(List<String> arguments) async {
  final app =
      cli.CommandRunner<String>()
        ..addCommand(cli.GetArticleByTitleCommand())
        ..addCommand(cli.RandomArticleCommand())
        ..addCommand(cli.OnThisDayTimelineCommand())
        ..addCommand(cli.HelpCommand())
        ..addCommand(cli.VersionCommand())
        ..addCommand(cli.ExitCommand());

  await console.write('');
  await console.write(cli.dartTitle);
  await console.write(cli.wikipediaTitle);
  await console.write('');

  await app.run();
}
