/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isNotEmpty && arguments.first == 'version') {
    print('Dart Wikipedia version $version');
  } else if (arguments.isNotEmpty && arguments.first == 'help') {
    printUsage();
  } else if (arguments.isNotEmpty && arguments.first == 'wikipedia') {
    // Note to Tech Writer (Not sure if this comment should be included for reader)
    //
    // Contrived to make a place to talk about null safety
    // In reality arguments.sublist(1) would never return null.
    // Therefor it's already null-safe and the `runApp` function
    // could just take a non-nullable type as an argument.
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    runApp(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}

void runApp(List<String>? arguments) {
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    printUsage();
    return;
  }

  print('Looking up articles about ${arguments.join(', ')}. Please wait.');
  for (var arg in arguments) {
    Future.delayed(Duration(seconds: 3), () {
      print('Here ya go!');
      print('(Pretend this an article about $arg)');
    });
  }
}
