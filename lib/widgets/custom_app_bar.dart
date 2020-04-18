import 'package:flutter/material.dart';

/// Our custom app bar that can have transparent background and no text
/// (to make it as if it's hidden) when the 'currentViewIndex' is in the
/// 'hideOnViewIndices' collection.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final int currentViewIndex;
  final List<int> hideOnViewIndices;
  final Color bgColor = Colors.white;

  CustomAppBar(
      {Key key, this.title, this.currentViewIndex, this.hideOnViewIndices})
      : appBar = AppBar(
          title: Text(
            // Hack to make it looks hidden
            hideOnViewIndices != null &&
                    hideOnViewIndices.contains(currentViewIndex)
                ? ''
                : title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: hideOnViewIndices != null &&
                  hideOnViewIndices.contains(currentViewIndex)
              ? Colors.transparent
              : Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
