

import 'package:flutter/material.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Shopinformation extends StatefulWidget {
  const Shopinformation({super.key});

  @override
  State<Shopinformation> createState() => _ShopinformationState();
}

class _ShopinformationState extends State<Shopinformation> {
  @override
  Widget build(BuildContext context) {
    return Mystyle().showtitle2("Add Shop Information", Colors.red);
  }
}