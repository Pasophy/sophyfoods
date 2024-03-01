import 'package:flutter/material.dart';

class Editfoodshop extends StatefulWidget {
  const Editfoodshop({super.key});

  @override
  State<Editfoodshop> createState() => _EditfoodshopState();
}

class _EditfoodshopState extends State<Editfoodshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left,
            size: 45.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
