import 'package:test/test.dart';
import 'package:wikipedia_cli/src/outputs.dart';
import 'package:wikipedia_cli/wikipedia_cli.dart';

void main() async {
  // This is not a thorough test
  test('HelpCommand.run', () async* {
    final HelpCommand help = HelpCommand();
    await for (final String str in help.run()) {
      expect(str, isNotNull, reason: "commands shouldn't yield null");
      emitsThrough(Outputs.enterACommand);
    }
  });
}
