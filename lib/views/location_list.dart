import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

/// Shows the list of cities/suburbs/towns/shires in the selected state
class LocationListView extends StatelessWidget {
  final String state;
  final List<LocationModel> locations;

  LocationListView({Key key, @required this.state, @required this.locations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: state,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          String place = locations[index].place;
          String cases = locations[index].count;
          String date = locations[index].date;
          return Card(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(place,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: <Widget>[
                          Text(cases),
                          Text(' cases'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
