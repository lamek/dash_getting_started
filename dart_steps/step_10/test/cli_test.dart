import 'package:step_10/cli.dart';
import 'package:test/test.dart';

// ADDED step_7
void main() {
  group('CommandRunner', () {
    test('_commands isn\'t empty after addCommand is called.', () {
      final app = CommandRunner<String?>();
      expect(app.commands, isEmpty);
      app.addCommand(HelpCommand());
      expect(app.commands.length, 1);
      app.addCommand(ExitCommand());
      expect(app.commands.length, 2);
    });
    test('parse returns a HelpCommand when the input is "help"', () {
      final app = CommandRunner<String?>()..addCommand(HelpCommand());
      final cmd = app.parse('help');
      expect(cmd, isA<HelpCommand>());
    });

    test('parseArgs returns a map of Args', () {
      fail("Unimplemented");
    });
    test('parseArgs throws an ArgumentError when argument is malformed', () {
      fail("Unimplemented");
    });
  });

  group('Models', () {
    test('Deserialized Wikipedia data into Summary object', () {
      fail("Unimplemented");
    });
    test('Deserialized Wikipedia data into TitleSet object', () {
      fail("Unimplemented");
    });
    test('Deserialized Wikipedia data into OnThisDay object', () {
      fail("Unimplemented");
    });
  });

  group('Wikipedia API', () {
    test('fetches random article summary from API', () async {
      fail("Unimplemented");
    });

    test('fetches Dart article summary from API', () async {
      fail("Unimplemented");
    });

    test('fetches OnThisDay timeline feed from API', () async {
      fail("Unimplemented");
    });
  });
}
