import 'package:covid19_app/models/the_guardian.dart';
import 'package:covid19_app/providers/the_guardian_api_client.dart';
import 'package:covid19_app/widgets/http_error_text.dart';
import 'package:covid19_app/widgets/http_loading_indicator.dart';
import 'package:covid19_app/widgets/states_summary.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

import '../widgets/age_distribution.dart';
import '../widgets/national_summary.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Future<dynamic> _data;
  TheGuardianProvider _provider;

  @override
  initState() {
    super.initState();
    _provider = TheGuardianProvider(IOClient());
    // Fetch the initial data, when this future is complete the FutureBuild#builder will be called
    _data = _provider.fetchTheGuardianModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TheGuardianModel>(
      future: _data,
      // A previously-obtained Future<TheGuardianModel> or null
      builder:
          (BuildContext context, AsyncSnapshot<TheGuardianModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          TheGuardianModel theGuardianModel = snapshot.data;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _provider.fetchTheGuardianModel();
              });
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    NationalSummary(data: theGuardianModel.national),
                    SizedBox(height: 10),
                    StatesSummary(data: theGuardianModel.states),
                    SizedBox(height: 10),
                    AgeDistribution(
                        ageDistribution: theGuardianModel.ageDistribution),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Show error
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _provider.fetchTheGuardianModel();
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
