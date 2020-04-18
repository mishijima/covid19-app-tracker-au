import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/utils/sizeUtil.dart';
import 'package:flutter/material.dart';

import '../charts/age_distribution.dart';

class AgeDistribution extends StatelessWidget {
  final List<AgeDistributionModel> ageDistribution;

  AgeDistribution({Key key, this.ageDistribution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = SizeUtil.getHeight(context);

    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          'Age distribution',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Container(
            height: height * 0.30,
            child: AgeDistributionChart.withData(ageDistribution)),
      ],
    );
  }
}
