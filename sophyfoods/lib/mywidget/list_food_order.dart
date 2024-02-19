


import 'package:flutter/material.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Orderfood extends StatefulWidget {
  const Orderfood({super.key});

  @override
  State<Orderfood> createState() => _OrderfoodState();
}

class _OrderfoodState extends State<Orderfood> {
  @override
  Widget build(BuildContext context) {
    return Mystyle().showtitle2("Order List Food", Colors.red);
  }
}