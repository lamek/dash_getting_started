import 'dart:async';

import 'package:command_runner/command_runner.dart';

class PrettyEcho extends Command<String> {
  @override
  String get name => 'pretty';

  @override
  String get description => 'Print input, but colorful.';

  @override
  FutureOr<String> run(ArgResults results) {
    List<String> prettyWords = [];
    var words = results.commandArg.split(' ');
    for (var i = 0; i < words.length; i++) {
      var word = words[i];
      switch (i % 3) {
        case 0:
          prettyWords.add(word.titleText);
        case 1:
          prettyWords.add(word.instructionText);
        case 2:
          prettyWords.add(word.errorText);
      }
    }

    return prettyWords.join(' ');
  }
}

void main(List<String> arguments) {
  final runner = CommandRunner<String>()..addCommand(PrettyEcho());

  runner.run(arguments);
}
