import 'dart:collection';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_app/models/the_guardian.dart';
import 'package:flutter/material.dart';

class AgeDistributionChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  AgeDistributionChart(this.seriesList, {this.animate});

  factory AgeDistributionChart.withData(List<AgeDistributionModel> data) {
    return new AgeDistributionChart(
      _createChartData(data),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      behaviors: [
        new charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
        )
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<ChartItem, String>> _createChartData(
      List<AgeDistributionModel> data) {
    LinkedHashMap<String, List> map = new LinkedHashMap<String, List>();

    for (var item in data) {
      String stateCode = item.state;
      int total = item.total;

      map.putIfAbsent(stateCode, () => new List());

      // If item has more than 8 items, pop everything after 8 and total it
      // because Vic and NSW data are not the same when the age range is above 80
      if (map[stateCode].length > 8) {
        int lastItem = map[stateCode].removeLast();
        total += lastItem;
      }
      map[stateCode].add(total);
    }

    List<charts.Series<ChartItem, String>> chartSeries = new List();

    map.forEach((key, value) {
      List<ChartItem> data = new List();

      data.add(new ChartItem('0-9', value[0]));
      data.add(new ChartItem('10-19', value[1]));
      data.add(new ChartItem('20-29', value[2]));
      data.add(new ChartItem('30-39', value[3]));
      data.add(new ChartItem('40-49', value[4]));
      data.add(new ChartItem('50-59', value[5]));
      data.add(new ChartItem('60-69', value[6]));
      data.add(new ChartItem('70-79', value[7]));
      data.add(new ChartItem('80+', value[8]));

      chartSeries.add(new charts.Series<ChartItem, String>(
        id: key,
        seriesCategory: key,
        domainFn: (ChartItem chartItem, _) => chartItem.ageRange,
        measureFn: (ChartItem chartItem, _) => chartItem.total,
        data: data,
      ));
    });

    return chartSeries;
  }
}

class ChartItem {
  final String ageRange;
  final int total;

  ChartItem(this.ageRange, this.total);
}
