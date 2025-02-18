import 'package:cli/src/model/summary.dart';
import 'package:cli/src/model/timeline.dart';
import 'package:cli/src/wikipedia/article.dart';
import 'package:cli/src/wikipedia/random_article.dart';
import 'package:cli/src/wikipedia/timeline.dart';
import 'package:test/test.dart';

// TODO(ewindmill): write more tests
void main() {
  group('Wikipedia API', () {
    test('fetches random article summary from API', () async {
      final summary = await getRandomArticleSummary();
      expect(summary, isA<Summary>());
    });

    test('fetches Dart article summary from API', () async {
      final summary = await getArticleSummary('Dart_(programming_language)');
      expect(summary, isA<Summary>());
    });

    test('fetches On This Day timeline from API', () async {
      final timeline = await getTimelineForToday();
      expect(timeline, isA<OnThisDayTimeline>());
      expect(timeline.all, isNotEmpty);
      expect(timeline.events, isNotEmpty);
      expect(timeline.selected, isNotEmpty);
    });
  });

  group('Models', () {
    test('Deserialized On This Day feed data from Wikipedia', () {});
  });

  group('Console', () {});
}
