import 'package:covid19_app/views/about.dart';
import 'package:covid19_app/views/dashboard.dart';
import 'package:covid19_app/views/location_by_states.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

/// This home view, in here we have the custom bar and a list of views where
/// the user can navigate between views by using the bottom navigation bar.
/// The custom app bar text and background can be made invisible by having
/// the view index in the 'hideOnViewIndices'. This is useful for a view
/// that doesn't need the app bar, such as 'About'
class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        currentViewIndex: _currentIndex,
        hideOnViewIndices: [2],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    DashboardView(),
                    LocationByStatesView(),
                    AboutView()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            title: Text('Suburbs/Shires'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
