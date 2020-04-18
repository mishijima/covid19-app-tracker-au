import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/providers/the_guardian_api_client.dart';
import 'package:covid19_app/views/dashboard.dart';
import 'package:covid19_app/widgets/http_error_text.dart';
import 'package:covid19_app/widgets/http_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements http.Client {}

/// Just some basic tests.
/// There are 2 groups in this test class
/// Async the guardian provider
/// Dashboard FutureBuilder
void main() {
  group('Async the guardian provider', () {
    testWidgets('Successful api call that returns TheGuardianModel',
        (tester) async {
      final Map<String, dynamic> rootMap = HashMap();
      final Map<String, dynamic> sheetMap = HashMap();
      final Map<String, dynamic> latestTotalMap = HashMap();
      final Map<String, dynamic> ageDistributionMap = HashMap();
      final Map<String, dynamic> locationsMap = HashMap();

      rootMap.putIfAbsent("sheets", () => sheetMap);
      sheetMap.putIfAbsent(
          "latest totals", () => List.unmodifiable([latestTotalMap]));
      sheetMap.putIfAbsent(
          "age distribution", () => List.unmodifiable([ageDistributionMap]));
      sheetMap.putIfAbsent(
          "locations", () => List.unmodifiable([locationsMap]));

      final jsonStr = json.encode(rootMap);

      final client = MockApiClient();
      final provider = TheGuardianProvider(client);
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
          'https://interactive.guim.co.uk/docsdata/1q5gdePANXci8enuiS4oHUJxcxC13d6bjMRSicakychE.json',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          })).thenAnswer((_) async => http.Response(jsonStr, 200));

      var result = await provider.fetchTheGuardianModel();

      expect(result, isInstanceOf<TheGuardianModel>());
      expect(
          result.ageDistribution, isInstanceOf<List<AgeDistributionModel>>());
      expect(result.locations, isInstanceOf<List<LocationMetadataModel>>());
      // There shouldn't be a national data in this test
      expect(result.national, null);
      expect(result.states, isInstanceOf<List<StateOrTerritoryModel>>());
    });
  });

  group('Dashboard FutureBuilder', () {
    testWidgets('starts with loading spinner', (tester) async {
      final widget = TestWidget();

      await tester.pumpWidget(widget);
      expect(find.byType(HttpLoadingIndicator), findsOneWidget);
    });
    testWidgets('shows http_error_text when the http call throws an exception',
        (tester) async {
      final client = MockApiClient();
      final widget = TestWidget();
      final provider = TheGuardianProvider(client);

      when(client.get(
          'https://interactive.guim.co.uk/docsdata/1q5gdePANXci8enuiS4oHUJxcxC13d6bjMRSicakychE.json',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          })).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(provider.fetchTheGuardianModel(), throwsException);

      // First render the widget with the future in waiting state
      await tester.pumpWidget(widget);
      expect(find.byType(HttpLoadingIndicator), findsOneWidget);

      // Second render the widget with the future in error state
      await tester.pumpWidget(widget);
      expect(find.byType(HttpErrorText), findsOneWidget);
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(home: DashboardView()),
    );
  }
}
