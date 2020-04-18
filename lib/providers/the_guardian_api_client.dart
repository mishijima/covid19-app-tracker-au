import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:covid19_app/models/the_guardian.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/strings.dart';

/// The Guardian API provider, the constructor takes a http client which can be IOClient, BrowserClient or MockClient
class TheGuardianProvider {
  final http.Client client;

  TheGuardianProvider(this.client);

  /// Fetches the data from the Guardian API and converts the response to the GuardianModel
  Future<TheGuardianModel> fetchTheGuardianModel() async {
    final response = await client.get(
        'https://interactive.guim.co.uk/docsdata/1q5gdePANXci8enuiS4oHUJxcxC13d6bjMRSicakychE.json',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 && !isEmpty(response.body)) {
      return TheGuardianModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the data');
    }
  }

  /// Fetches the data from the Guardian API and converts the response to the
  /// LocationModel map
  Future<Map<String, List<LocationModel>>> fetchTheLocationModel() async {
    final Map<String, List<LocationModel>> map = new LinkedHashMap();

    final response = await http.get(
        'https://interactive.guim.co.uk/docsdata/1q5gdePANXci8enuiS4oHUJxcxC13d6bjMRSicakychE.json',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 && !isEmpty(response.body)) {
      TheGuardianModel theGuardianModel =
          TheGuardianModel.fromJson(json.decode(response.body));
      if (theGuardianModel != null) {
        for (LocationMetadataModel locationMetadataModel
            in theGuardianModel.locations) {
          final locationResponse = await http.get(
              locationMetadataModel.jsonFeed,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'});

          if (locationResponse.statusCode == 200 &&
              !isEmpty(locationResponse.body)) {
            List<LocationModel> locations = (json.decode(locationResponse.body)
                    as List)
                .map((item) =>
                    LocationModel(item['date'], item['place'], item['count']))
                .where((item) => (!item.place.contains('Total') &&
                    !item.count.contains(
                        'Total'))) // The data is quite dirty, it can contain Total
                .toList();
            // Sort it by place
            locations.sort((a, b) => a.place.compareTo(b.place));

            map.putIfAbsent(locationMetadataModel.state, () => locations);
          } else {
            throw Exception('Failed to load the data');
          }
        }
        return map;
      }
      return map;
    } else {
      throw Exception('Failed to load the data');
    }
  }
}
