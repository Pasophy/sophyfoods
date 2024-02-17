


import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Myriders extends StatefulWidget {
  const Myriders({super.key});

  @override
  State<Myriders> createState() => _MyridersState();
}

class _MyridersState extends State<Myriders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Rider', Colors.white),)
    );
  }
}