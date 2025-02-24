# Dart + Flutter Onboarding tutorial code

**Very much a WIP and subject to change**.

This repository exists almost entirely so that the code writer (me) and the
tutorial authors (me and tech writers) could collaborate effectively and craft
the tutorial story together.

Googler's
see: [go/dash-onboarding-experience](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.0)

---

This project contains all code for the forthcoming Flutter and Dart onboarding
experience (DOE). DOE will be a "learning pathway" of sorts designed to guide a
Dart or Flutter-curious developer from "landed on the home page" to "knows
enough to pass a Jr level technical interview".

## Table of contents:

* [Packages](#packages) - A list of code is included in this repo.
* [Topic requirements](#topic-requirements) - Checklists that track whether each
  critical topic is currently included in the _end state_ of the code.
* [Step-by-step code](#step-by-step-outline) - A list that outlines what new
  code is introduced in any given step.

**NOTES! IMPORTANT!**

* This is not the source-of-truth for the conversation and feedback about the
  DOE _project_.
    * **External developers:** Feel free to file issues for any
      questions/comments/concerns. I welcome and appreciate feedback.
      Eventually, issues will be better suited for the flutter/website
      repository. I'll update this README when that time comes.
    * **Googlers:** If you aren't reviewing the code or referencing the code
      while writing the tutorial, the source of truth for conversation,
      questions, concerns, etc is the Google Doc at
      [go/dash-onboarding-experience](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.0) (
      internal only).
* (If you're reading this after DOE has launched) This is no longer the source
  of truth for the DOE code! The code lives in dart-lang/website and
  flutter/website (probably).

## Packages

* `/complete` - This dir contains full(er) featured apps. They're built-out
  beyond the initial requirements of the getting stated experiences. Use them as
  a guide that we're building toward.
* `dart_steps` - This dir contains a dart project for every step of Dart's
  getting started experience. See the **Dart** section below for a description
  of the code that's added at each step.
* `flutter_steps` - The same as above, but for Flutter.
* `end` - This dir contains the code as it will be _at the end of the tutorial_.
  It (ideally)
  contains the least possible amount of code while still covering every
  necessary topic and finishing with an interesting, working application.

## Step by step outline

Code that's added in each step of the tutorial. Probably/maybe/hopefully
translates 1:1 to docs pages in the tutorial.

### Dart

#### Part 1 - Intro to Dart

This section is designed to give immediate feedback to the user at every step.
The steps are short, and the topics aren't covered deeply. Its intentionally not
overwhelming and leaves out all extraneous context. For example, the 'async'
step only introduces the `async` and `await` keywords, and ignores theory talk (
event loop) and ignores all other async APIs.

1. Create a Dart project
    * Run `dart create wikipedia_dart`
2. Fundamentals
    * Introduces
        * control flow - if/else
        * Collections (lists, isEmpty, first, for-in loops)
        * variables, const
        * null checks
        * functions
        * String interpolation
        * stdin
    * App functionality
        * Reads user input via program arguments
        * prints usage and version
        * When the user enters `wikipedia` and
3. Async basics / HTTP
    * Introduces:
        * async / await
        * Future
        * package:http
        * import statements
    * App functionality
        * Now, when the user enters `wikipedia` as an argument, the app will get
          a wikipedia page via it's public API. It will print the response as a
          JSON object. (which is still bad, but progress)
4. End of section mini-lesson (code organization tips)
    * Introduces
        * The `class` keyword
        * Streams via `await for` loops (fine to gloss over, there will be more
          in depth Stream lessons later)
        * Libraries and `export` statements
    * App functionality
        * A regression, technically. Now, all it does is echo the provided
          input.
        * But, it is "long-lived" in that it just keeps listening for input.

#### Part 2 - "Real Development"

In this section, the user will start to write "real code" that is
well-architected and written with the future in mind. Topics are covered more
in-depth (if necessary) and code quality alone is one of the payoffs. Not every
lessons needs to end with a dopamine hit payoff (but it should if possible
without forcing.)

5. Object Oriented Dart
    * Introduces
        * abstract class
        * generics
        * inheritance (extends)
        * overrides
        * part/part of directives
    * App functionality
        * Mostly completes 'CommandRunner' class
        * Adds Command class, Arg class, and CommandArgs
        * Adds HelpCommand class and ExitCommand
        * Adds Command our app (bin/cli.dart)
        * Doesn't really add any new functionality. Kind of a regression. The
          only inputs that won't give you an error are 'exit' and 'help'.
6. YAML
    * Introduces:
        * Parsing yaml - pkg:yaml
        * Reading files with dart:io - File and Platform APIs
    * App functionality
        * Adds pkg:yaml
        * Adds VersionCommand, which parses the pubspec.yaml file and then
          returns the version.
        * Adds that command to the app in the bin
7. Testing
    * Introduces
        * TDD
        * package:test
        * group
        * test
        * expect
        * Some matchers
    * App functionality
        * Adds many “blank” tests to be filled out over time.
        * Adds a few tests that are implemented
8. Data and JSON
    * Introduces
        * Data models
        * JSON deserialization
        * (reintroduces) HTTP
        * pattern matching
    * App functionality
        * User can now query for Wikipedia articles. For example, to get the Cat
          wikipedia article printed to the page, use 'article title=cat'
10. Async part 2 - Streams
    * Introduces
        * await for
        * async*
        * StreamController
        * Stream
        * .listen
    * App functionality
        * The Command.run method now returns a Stream rather than a FutureOr.
          Now we can print a series of outputs to the console in response to a
          single user input. This matters because…
        * The final command has been added, which fetches OnThisDay timeline
          information from Wikipedia. It prints a single timeline event and
          waits for the user to indicate when they’re ready for the next one.
10. Error handling
    * Introduces:
        * Adds first Command that extends "CommandWithArgs"
        * Implemented an Exception class
        * try/catch
        * Exceptions
        * Errors
        * Swallowing exceptions
    * App functionality:
        * Properly handles errors
        * `onError` is implemented in `cli` class
11. Logging
    * Introduces
        * pkg:logging
        * Log levels
        * Logger class
        * .listen (stream method)
        * Writing to files
    * App functionality:
      * Adds two loggers - the ‘framework logger’ and the ‘getArticleSummary’ logger.
      * The framework logger creates a logfile in the project dir and then writes to it. Its a general purpose logger that just follows a user journey.
      * The getArticleSummary is specific to the getArticleSummary function and tracks HTTP calls.
12. Make it pretty
    * Introduces
      * enums
      * extensions
      * ASCII
      * string buffers
      * 
    * App functionality
      * The app now has a user experience. It prints things in a more pleasing, organized matter.
      * It welcomes the user to the app
      * It prints with color
      * It prints line by line, rather than just appearing

### Flutter [WIP]

#### Part 1 - TODO


## Topic requirements

The agreed upon topics that must appear in the code. In no particular order. (
Googlers: A more detailed list and the source of truth is
at  [go/dash-onboarding-experience](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.0))

### Dart

- [x] setup, anatomy
- [x] variables
- [x] functions
- [x] sound typing
- [x] null safety checks
- [x] classes, fields, methods
- [x] control flow: looping
- [x] control flow: branches
- [x] patterns
- [x] error handling
- [x] tests
- [x] logging
- [x] libraries and packages
- [x] OOP and class architecture
    - [x] inheritance
    - [x] class modifiers
    - ~~[ ] mixins~~
    - [x] extension types
- [x] enums
- [x] Working with JSON
- [x] Working with YAML
- [x] http
- [x] compile app

### Flutter

- [x] setup, anatomy
- [x] Create a `StatelessWidget`
    - [x] `build()`, `setState()`, etc
- [ ] Layout
    - [x] Common layout widgets: Col/Row, `Stack`, `Size`, `Center`, `Scaffold`,
      etc
    - [x] `ListView` (and `ListTile`/`CupertinoListTile`)
    - [x] `Flexible` and `Expanded`
- [x] Composition
    - [x] Build a simple, reusable widget (`RoundedImage`)
- [x] Adaptive design (screen size and platform design system)
    - [x] `MediaQuery`
    - [ ] `LayoutBuilder`
    - [x] `MaterialApp` vs `CupertinoApp`
    - [ ] Create a widget that styles itself based on platform
    - [x] Conditionally show navigation elements that are appropriate for screen
      size (i.e. `NavigationRail` vs `NavigationBar`)
- [x] Theme
    - [x] `TextTheme` and `CupertinoTextTheme`
    - [x] Design consideration when building for Cupertino and Material
- [x] User input
    - [x] Buttons
    - [x] `GestureDetector`
    - [x] `StatefulWidget`
- [x] State management and architecture
    - [x] MVVM
    - [x] Dep Injection (`InheritedWidget`)
    - [x] `ChangeNotifier`, `ListenableBuilder`
- [x] Data and caching
    - [x] In mem data caching (repository classes)
    - [ ] On device persistent caching
- [x] Routing and navigation
    - [x] `Navigator.of(context)`
    - [x] push / pop
    - [x] page routes and default platform transitions
- [ ] Testing and app health
    - [ ] Widget testing
    - [ ] Integration testing?
    - [ ] Logging
    - [ ] IDE and Debugging features
    - [ ] performance measuring
- [ ] Animations
    - [ ] ??? **TODO**
- [ ] Packages and plugins
    - [x] HTTP
    - [x] A local package
    -

Topics to maybe include:

- [x] CustomPainter
- [ ] Scrolling and slivers
    - [ ] `NestedScrollView`
    - [ ] Sliver app bars
- [ ] Concurrency
    - [ ] Isolate.run
    - [ ] Whatever the web equivalent is
- [ ] Platform capabilities
    - [ ] "Direct Platform Interop" ??
- [ ] Publishing Apps
    - [ ] Web (Firebase Hosting?)
        - [ ] Docker or some simple container system?
        - [ ] Mobile ??
