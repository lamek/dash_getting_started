import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wikipedia_shared/src/model/search_results.dart';

const String openSearchResponse = './test/test_data/open_search_response.json';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('deserialize Open Search results example data from json file '
        'into an SearchResults object', () async {
      final String resultsString =
          await File(openSearchResponse).readAsString();
      final List<Object?> resultsAsList =
          jsonDecode(resultsString) as List<Object?>;
      final SearchResults results = SearchResults.fromJson(resultsAsList);
      expect(results.results.length, greaterThan(1));
    });
  });
}
