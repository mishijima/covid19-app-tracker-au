import 'package:covid19_app/utils/sizeUtil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  AboutView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeUtil.getWidth(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Acknowledgments',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '\n\n',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextSpan(
                  text:
                      'This application utilises the Guardian Australia API where the data gets updated hourly. For more information about it, please ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                TextSpan(
                  text: 'tap here',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://www.arcgis.com/home/item.html?id=35b077523be94f7288b21db815e6e6e6');
                    },
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
