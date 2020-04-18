import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/utils/shadowUtil.dart';
import 'package:covid19_app/utils/sizeUtil.dart';
import 'package:covid19_app/widgets/summary_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Shows each state summary
class StatesSummary extends StatelessWidget {
  final List<StateOrTerritoryModel> data;
  final numberFormat = new NumberFormat("#,###", "en_AU");

  StatesSummary({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = SizeUtil.getHeight(context);
    var width = SizeUtil.getWidth(context);

    return Container(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: width * 0.8,
            margin: EdgeInsets.symmetric(
                horizontal: width / 100, vertical: height / 40),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: ShadowUtil.neumorphShadow,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: SummaryBoxView(
                data: data[index],
                showColorIndicator: false,
                showFlag: true,
                showLocationLabel: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
