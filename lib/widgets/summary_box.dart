import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/utils/sizeUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A reusable widget for national, states and territory.
class SummaryBoxView extends StatelessWidget {
  final StateOrTerritoryModel data;
  final numberFormat = new NumberFormat("#,###", "en_AU");
  final bool showColorIndicator;
  final bool showFlag;
  final bool showLocationLabel;

  SummaryBoxView(
      {Key key,
      @required this.data,
      this.showColorIndicator = false,
      this.showFlag = false,
      this.showLocationLabel = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = SizeUtil.getWidth(context);

    var imgLocation = 'assets/' + data.shortName + '_Flag.png';
    final String confirmedCases = numberFormat.format(data.confirmedCases);
    final String deaths = numberFormat.format(data.deaths);
    final String testsConducted = numberFormat.format(data.testConducted);
    final String inHospital = numberFormat.format(data.inHospital);
    final String inIcu = numberFormat.format(data.inIcu);
    final String recovered = numberFormat.format(data.recovered);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: showLocationLabel,
              child: Text(
                data.longName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: showFlag,
              child: Container(
                  alignment: Alignment.topLeft,
                  width: width * 0.125,
                  child: Image.asset(
                    imgLocation,
                    fit: BoxFit.fill,
                  )),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1, color: Colors.yellow, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('Confirmed cases'),
              ],
            ),
            Text(
              confirmedCases,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          color: Colors.deepPurple, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('Deaths'),
              ],
            ),
            Text(
              deaths,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          color: Colors.blueAccent, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('Tests conducted'),
              ],
            ),
            Text(
              testsConducted,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          color: Colors.blueGrey, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('In Hospital'),
              ],
            ),
            Text(
              inHospital,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          color: Colors.deepOrange, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('In ICU'),
              ],
            ),
            Text(
              inIcu,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Visibility(
                  visible: showColorIndicator,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1, color: Colors.green, size: 16),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                    ],
                  ),
                ),
                Text('Recovered'),
              ],
            ),
            Text(
              recovered,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Last updated on ',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              data.lastUpdated,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
