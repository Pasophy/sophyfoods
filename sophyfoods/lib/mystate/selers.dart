import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/Mydrawers/drawerselers.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/usersingnout.dart';

class Myselers extends StatefulWidget {
  const Myselers({super.key});

  @override
  State<Myselers> createState() => _MyselersState();
}

class _MyselersState extends State<Myselers> {
  String? username;

  @override
  void initState() {
    super.initState();
    finduser();
  }

  Future<Null> finduser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('MainShop',
             Colors.white),    
        actions: <Widget>[
          IconButton(
            onPressed: () =>usersignout(context),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      drawer: drawerselers(context),
    );
  }
}
