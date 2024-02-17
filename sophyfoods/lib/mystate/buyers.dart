import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Mybuyers extends StatefulWidget {
  const Mybuyers({super.key});

  @override
  State<Mybuyers> createState() => _MybuyersState();
}

class _MybuyersState extends State<Mybuyers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Buyser', Colors.white),
      ),
    );
  }
}
