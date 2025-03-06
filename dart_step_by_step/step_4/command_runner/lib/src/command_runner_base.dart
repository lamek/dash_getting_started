const version = '0.0.1';

void run(List<String> arguments) {
  if (arguments.isNotEmpty && arguments.first == 'version') {
    print('Dart Wikipedia version $version');
  } else if (arguments.isNotEmpty && arguments.first == 'help') {
    printUsage();
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}
