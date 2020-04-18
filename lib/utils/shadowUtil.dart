import 'package:flutter/material.dart';

class ShadowUtil {
  static List<BoxShadow> neumorphShadow = [
    BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: -5,
        offset: Offset(-5, -5),
        blurRadius: 20),
    BoxShadow(
        color: Colors.black.withOpacity(.2),
        spreadRadius: 2,
        offset: Offset(7, 7),
        blurRadius: 10)
  ];
}
