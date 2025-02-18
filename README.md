# Dart + Flutter Onboarding tutorial code - step-by-step

Googler's see: go/dash-onboarding-experience

## Dart

Requirements:
- [ ] setup, anatomy
- [ ] variables
- [ ] functions
- [ ] sound typing
- [ ] null safety checks
- [ ] classes, fields, methods
- [ ] control flow: looping
- [ ] control flow: branches
- [ ] patterns
- [ ] error handling
- [ ] tests
- [ ] logging
- [ ] libraries and packages
- [ ] OOP and class architecture
  - [ ] inheritance
  - [ ] class modifiers
  - [ ] mixins
  - [ ] extension types
- [ ] enums
- [ ] Working with JSON
- [ ] Working with YAML
- [ ] http
- [ ] Compile app

### Part 1 - Intro to Dart
This section is designed to give immediate feedback to the user at every step. 
The steps are short, and the topics aren't covered deeply. Its intentionally not overwhelming
and leaves out all extraneous context.  For example, the 'async' step only introduces the `async` and `await` keywords, and ignores theory talk (event loop) and ignores all other 
async APIs.

1. Create a Dart project
   * Run `dart create wikipedia_dart`
2. Fundamentals
   * Introduces
      * Control flow - if/else and switch/case
      * variables
      * functions
      * i/o
   * App functionality
     * Reads user input via program arguments
     * prints usage and version
     * When the user enters `wikipedia` it prints an error and exits
3. Async basics / HTTP 
   * Introduces:
     * async / await
     * Future
     * package:http
     * import statements
   * App functionality
     * Now, when the user enters `wikipedia` as an argument, the app will get a wikipedia page via it's public API. It will print the response as a JSON object.

### Part 2 - "Real Development"

In this section, the user will start to write "real code" that is well-architected and 
written with the future in mind. Topics are covered more in-depth (if necessary) and 
code quality alone is one of the payoffs. Not every lessons needs to end with a 
dopamine hit payoff (but it should if possible without forcing.)

1. Libraries and packages
   * "Set's up" the app by properly organizing code and doing a bit of quick prep so remaining lessons can stay focused. This lesson might make more sense in part 1.
   * Introduces
     * Dart libraries
     * export statements
     * utf8 from dart:convert (Probably gloss over)
     * Streams via stdin.listen (Probably gloss over)
     * imports the shared lib, which contains test data for development
   * App functionality
     * App code is moved into the `lib` folder.
     * The app runs continuously (until exit)
1. Object Oriented Dart
   * Command pattern 
   * Introduces
   * App functionality
     * When the user fetches a Wikipedia article, it's printed out in a sane way.

Note -- First, use 'Dart' Summary to put something on the screen. 
Second, use JSON files
Third, use HtTP