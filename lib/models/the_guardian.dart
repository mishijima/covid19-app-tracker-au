import 'package:quiver/strings.dart';

class TheGuardianModel {
  final List<StateOrTerritoryModel> states;
  final StateOrTerritoryModel national;
  final List<LocationMetadataModel> locations;

  TheGuardianModel(
      this.states, this.national, this.locations);

  factory TheGuardianModel.fromJson(Map<String, dynamic> json) {
    List<StateOrTerritoryModel> states =
        (json['sheets']['latest totals'] as List)
            .map((item) => StateOrTerritoryModel.fromJson(item))
            .toList();

    StateOrTerritoryModel national;
    for (var item in states) {
      if (item.shortName == 'National') {
        national = item;
        break;
      }
    }
    states.remove(national);

    List<LocationMetadataModel> locations =
        (json['sheets']['locations'] as List)
            .map((item) => LocationMetadataModel.fromJson(item))
            .toList();

    return TheGuardianModel(states, national, locations);
  }
}

class StateOrTerritoryModel {
  final String shortName;
  final String longName;
  final int confirmedCases;
  final int deaths;
  final int testConducted;
  final int inHospital;
  final int inIcu;
  final int recovered;

  String lastUpdated;

  StateOrTerritoryModel(
      this.shortName,
      this.longName,
      this.confirmedCases,
      this.deaths,
      this.testConducted,
      this.inHospital,
      this.inIcu,
      this.recovered,
      this.lastUpdated);

  factory StateOrTerritoryModel.fromJson(Map<String, dynamic> json) {
    final int confirmedCases = !isEmpty(json['Confirmed cases (cumulative)'])
        ? int.parse(json['Confirmed cases (cumulative)'])
        : 0;
    final int deaths = !isEmpty(json['Deaths']) ? int.parse(json['Deaths']) : 0;
    final int testConducted = !isEmpty(json['Tests conducted'])
        ? int.parse(json['Tests conducted'])
        : 0;
    final int recovered =
        !isEmpty(json['Recovered']) ? int.parse(json['Recovered']) : 0;
    final int inHospital = !isEmpty(json['Current hospitalisation'])
        ? int.parse(json['Current hospitalisation'])
        : 0;
    final int inIcu =
        !isEmpty(json['Current ICU']) ? int.parse(json['Current ICU']) : 0;

    return StateOrTerritoryModel(
        json['State or territory'],
        json['Long name'],
        confirmedCases,
        deaths,
        testConducted,
        inHospital,
        inIcu,
        recovered,
        json['Last updated']);
  }
}

class LocationMetadataModel {
  final String state;
  final String jsonFeed;
  final String areas;
  final String notes;

  LocationMetadataModel(this.state, this.jsonFeed, this.areas, this.notes);

  factory LocationMetadataModel.fromJson(Map<String, dynamic> json) {
    return LocationMetadataModel(
        json['state'], json['json_feed'], json['areas'], json['notes']);
  }
}

class LocationModel {
  final String date;
  final String place;
  final String count;

  LocationModel._(this.date, this.place, this.count);

  factory LocationModel(String date, String place, dynamic count) {
    String countStr;
    if (count is int) {
      countStr = count.toString();
    } else {
      countStr = count;
    }
    return LocationModel._(date, place, countStr);
  }
}
