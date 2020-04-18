import 'package:flutter/material.dart';

/// A simple widget to show the loading indicator when the http connection
/// status is waiting.
class HttpLoadingIndicator extends StatelessWidget {
  HttpLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Retrieving data...'),
          )
        ],
      ),
    );
  }
}
