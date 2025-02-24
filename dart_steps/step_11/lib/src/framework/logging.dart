/*
 * // Copyright 2025 The Dart and Flutter teams. All rights reserved.
 * // Use of this source code is governed by a BSD-style license that can be
 * // found in the LICENSE file.
 */

part of 'command_runner.dart';

final _frameworkLogger = Logger.detached("Framework internal logger");
final _uuid = Uuid();

// ADDED step_11
void _initLogger() {
  final sessionId = _uuid.v1();
  final now = DateTime.now();

  final segments = Platform.script.path.split('/');
  final projectDir = segments.sublist(0, segments.length - 2).join('/');

  // input log tracks user journeys.
  final frameworkLog = File(
    '$projectDir/logs/${now.year}_${now.month}_${now.day}_input_log.txt',
  );
  frameworkLog.writeAsStringSync('--- New Session $sessionId ---');

  _frameworkLogger.level = Level.ALL;
  _frameworkLogger.onRecord.listen((record) {
    final msg =
        '[$sessionId - ${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
    frameworkLog.writeAsStringSync('$msg \n', mode: FileMode.append);
  });
}
