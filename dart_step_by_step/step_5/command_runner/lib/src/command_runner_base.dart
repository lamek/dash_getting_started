import 'dart:collection';
import 'dart:io';

import 'arguments.dart';

// [Step 5 updates] Entire file

class CommandRunner<T> {
  final Map<String, Command<T>> _commands = <String, Command<T>>{};

  UnmodifiableSetView<Command<T>> get commands =>
      UnmodifiableSetView<Command<T>>(<Command<T>>{..._commands.values});

  Future<void> run(List<String> input) async {
    final ArgResults results = parse(input);
    if (results.command != null) {
      T? output = await results.command!.run(results);
      print(output.toString());
    }
  }

  void addCommand(Command<T> command) {
    // TODO: handle error (Command's can't have names that conflict)
    _commands[command.name] = command;
    command.runner = this;
  }

  ArgResults parse(List<String> input) {
    var results = ArgResults();
    results.command = _commands[input.first];
    return results;
  }

  /// Returns usage for the executable only.
  /// Should be overridden if you aren't using [HelpCommand]
  /// or another means of printing usage.
  String get usage {
    final exeFile = Platform.script.path.split('/').last;
    return 'Usage: dart bin/$exeFile <command> [commandArg?] [...options?]';
  }
}
