import 'package:covid19_app/utils/sizeUtil.dart';
import 'package:flutter/material.dart';

/// A simple widget to show when http error is thrown.
class HttpErrorText extends StatelessWidget {
  HttpErrorText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = SizeUtil.getHeight(context);

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child:
                      Text('Whoops, failed get the data from the server. \n\n'
                          'Please try again later'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
