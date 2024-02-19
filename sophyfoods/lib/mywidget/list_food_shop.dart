


import 'package:flutter/material.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Shopfood extends StatefulWidget {
  const Shopfood({super.key});

  @override
  State<Shopfood> createState() => _ShopfoodState();
}

class _ShopfoodState extends State<Shopfood> {
  @override
  Widget build(BuildContext context) {
    return Mystyle().showtitle2("List Food", Colors.red);
  }
}