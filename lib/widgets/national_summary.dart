import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/utils/shadowUtil.dart';
import 'package:covid19_app/widgets/summary_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Shows the national summary data.
class NationalSummary extends StatelessWidget {
  final StateOrTerritoryModel data;
  final numberFormat = new NumberFormat("#,###", "en_AU");

  NationalSummary({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowUtil.neumorphShadow,
          borderRadius: BorderRadius.circular(5)),
      child:
          SummaryBoxView(data: data, showColorIndicator: true, showFlag: false),
    );
  }
}
