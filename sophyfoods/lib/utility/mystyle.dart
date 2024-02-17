import 'package:flutter/material.dart';

class Mystyle {
  Widget showlogo() {
    return Image.asset("images/logo3.png");
  }

  Widget showtitle1(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 34.0, fontWeight: FontWeight.bold, color: color),
      );

  Widget showtitle2(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: color),
      );

        Widget showtitle3(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: color),
      );

  Mystyle();
}
