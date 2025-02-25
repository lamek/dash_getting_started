## Flutter getting started experience

Code for the Flutter portion of the forthcoming Getting Started Experience.


### Topics

This list tracks the critical topics for the tutorial, and whether they're implemented in the application. This is for me own organization purposes and doesn't really mean anything.

For the canonical list of topics, see the [project design doc.](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.th5nalmmctyr)

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
