import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Myselers extends StatefulWidget {
  const Myselers({super.key});

  @override
  State<Myselers> createState() => _MyselersState();
}

class _MyselersState extends State<Myselers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Seler', Colors.white),
      ),
    );
  }
}
