# Dart + Flutter Onboarding tutorial code

**Very much a WIP and subject to change**.

This repository exists almost entirely so that the code writer (me) and the
tutorial authors (me and tech writers) can collaborate effectively and craft
the tutorial story together.


Googlers see also:

* Design doc: [go/dash-onboarding-experience](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.0)
* [Dart step-by-step outline](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.rkbpdp9bxsdu)
* [Flutter step-by-step outline](https://docs.google.com/document/d/1SOQywApeqLyPKEdIDI5xvTea6RmgyFBgAYqQe73j6_Q/edit?resourcekey=0-VYlgPFgP62-F3pw0OjQOFw&tab=t.th5nalmmctyr)

---

This project contains all code for the forthcoming Flutter and Dart onboarding
experience (DOE). DOE will be a "learning pathway" of sorts designed to guide a
Dart or Flutter-curious developer from "landed on the home page" to "knows
enough to pass a Jr level technical interview".

## Packages

* `/complete` - The complete project as it'll be at the end of the Getting Started Experience. It's a monorepo that contains 5 packages, many of which import other packages in the monorepo.
* `/dart_steps` - This dir contains a dart project for every step of Dart's
  getting started experience. See the **Dart** section below for a description
  of the code that's added at each step.
* `/flutter_steps` - The same as above, but for Flutter.

Bonus: 

* `/demos` - This dir contains full(er) featured apps. They're built-out
  beyond the initial requirements of the getting stated experiences. These were the initial apps I built without considering what would be included in a tutorial
* 

## NOTES! IMPORTANT!

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