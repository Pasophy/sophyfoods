import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';

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
            fontSize: 28.0, fontWeight: FontWeight.bold, color: color),
      );

  Widget showtitle3(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: color),
      );

  Widget showinformation(String text) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(Myconstant().reds),
                )),
          ],
        ),
      );

  Widget showprogress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Mystyle();
}
