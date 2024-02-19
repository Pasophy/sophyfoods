import 'package:flutter/material.dart';
import 'package:sophyfoods/mydrawers/drawer_buyers.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/usersingnout.dart';

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
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Buyser', Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: () => usersignout(context),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      drawer: drawerbuyers(context),
    );
  }
}
