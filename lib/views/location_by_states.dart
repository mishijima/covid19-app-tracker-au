import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/providers/the_guardian_api_client.dart';
import 'package:covid19_app/widgets/http_error_text.dart';
import 'package:covid19_app/widgets/http_loading_indicator.dart';
import 'package:covid19_app/widgets/slide_left_route.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

import 'location_list.dart';

/// Shows the list of states in a list view and the user can navigate to view the cities in each state.
class LocationByStatesView extends StatefulWidget {
  LocationByStatesView({Key key}) : super(key: key);

  @override
  _LocationByStatesViewState createState() => _LocationByStatesViewState();
}

class _LocationByStatesViewState extends State<LocationByStatesView> {
  Future<dynamic> _data;
  TheGuardianProvider _provider;

  @override
  initState() {
    super.initState();
    _provider = TheGuardianProvider(IOClient());
    // Fetch the initial data, when this future is complete the FutureBuild#builder will be called
    _data = _provider.fetchTheLocationModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<LocationModel>>>(
      future: _data,
      // A previously-obtained Future<TheGuardianModel> or null
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, List<LocationModel>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Map<String, List<LocationModel>> locationMap = snapshot.data;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _provider.fetchTheLocationModel();
              });
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: locationMap.length,
              itemBuilder: (context, index) {
                String state = locationMap.keys.elementAt(index);
                return Card(
                  child: ListTile(
                    title: Text(state),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    // Pass the data to the next screen
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideLeftRoute(
                          page: LocationListView(
                              state: state,
                              locations: locationMap.values.elementAt(index)),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          // Show error
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _provider.fetchTheLocationModel();
              });
            },
            child: HttpErrorText(),
          );
        } else {
          return HttpLoadingIndicator();
        }
      },
    );
  }
}
