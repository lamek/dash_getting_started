/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

import 'package:cli/src/console.dart';

import 'model/summary.dart';

final String dartTitle =
    '''
██████╗  █████╗ ██████╗ ████████╗
██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
██║  ██║███████║██████╔╝   ██║   
██║  ██║██╔══██║██╔══██╗   ██║   
██████╔╝██║  ██║██║  ██║   ██║   
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   '''.titleText;

final String wikipediaTitle = '''
██╗    ██╗██╗██╗  ██╗██╗██████╗ ███████╗██████╗ ██╗ █████╗ 
██║    ██║██║██║ ██╔╝██║██╔══██╗██╔════╝██╔══██╗██║██╔══██╗
██║ █╗ ██║██║█████╔╝ ██║██████╔╝█████╗  ██║  ██║██║███████║
██║███╗██║██║██╔═██╗ ██║██╔═══╝ ██╔══╝  ██║  ██║██║██╔══██║
╚███╔███╔╝██║██║  ██╗██║██║     ███████╗██████╔╝██║██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝''';

String renderSummary(Summary summary) {
  var buffer = StringBuffer('${summary.titles.normalized.titleText}\n');
  buffer.writeln(summary.description);
  buffer.writeln();
  buffer.writeln(summary.extract);
  return buffer.toString();
}
