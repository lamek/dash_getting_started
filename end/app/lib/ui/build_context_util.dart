/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'breakpoint.dart';

extension Adaptive on BuildContext {
  Breakpoint get breakpoint => Breakpoint.current(this);

  bool get isCupertino {
    return [
      TargetPlatform.iOS,
      TargetPlatform.macOS,
    ].contains(Theme.of(this).platform);
  }

  TextStyle get headlineLarge {
    if (isCupertino) return CupertinoAppTheme.largeTitle;
    return MaterialAppTheme.lightTextTheme.headlineLarge!;
  }

  TextStyle get titleLarge {
    if (isCupertino) return CupertinoAppTheme.headline;
    return MaterialAppTheme.lightTextTheme.titleLarge!;
  }

  TextStyle get titleMedium {
    if (isCupertino) return CupertinoAppTheme.subhead;
    return MaterialAppTheme.lightTextTheme.titleMedium!;
  }

  TextStyle get bodyMedium {
    if (isCupertino) return CupertinoAppTheme.body;
    return MaterialAppTheme.lightTextTheme.bodyMedium!;
  }

  TextStyle get labelSmall {
    if (isCupertino) return CupertinoAppTheme.caption;
    return MaterialAppTheme.lightTextTheme.labelSmall!;
  }

  PageRoute<Object> adaptivePageRoute({
    required WidgetBuilder builder,
    String? title,
  }) {
    if (isCupertino) {
      return CupertinoPageRoute(builder: builder, title: title);
    } else {
      return MaterialPageRoute(builder: builder);
    }
  }
}
