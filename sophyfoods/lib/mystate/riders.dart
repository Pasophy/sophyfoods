import 'package:flutter/material.dart';
import 'package:sophyfoods/utility/mydrawer.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/usersingnout.dart';

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
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Rider', Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: () => usersignout(context),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      drawer: showdrawer(context),
    );
  }
}
