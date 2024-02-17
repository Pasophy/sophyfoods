import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/mystate/signin.dart';
import 'package:sophyfoods/mystate/signup.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbarcolor),
      ),
      drawer: showdrawer(),
    );
  }

  Widget showdrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          drawerheader(),
          menusignin(),
          menusignup(),
        ],
      ),
    );
  }

  Widget menusignin() {
    return ListTile(
      leading: const Icon(Icons.android_sharp),
      title: const Text("Sign in"),
      hoverColor: Colors.red,
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (values) => const Mysignin(),
        );
        Navigator.push(context, route);
      },
    );
  }

  Widget menusignup() {
    return ListTile(
      leading: const Icon(Icons.android_sharp),
      title: const Text("Sign up"),
      hoverColor: Colors.black54,
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (values) => const Mysignup(),
        );
        Navigator.push(context, route);
      },
    );
  }

  Widget drawerheader() {
    return Column(
      children: [
        UserAccountsDrawerHeader(
        decoration: BoxDecoration(color:Color(Myconstant().appbarcolor)),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: AssetImage('images/logo3.png'),
          ),
          accountName: const Text('Profile'),
          accountEmail: const Text('pasophy18@gmail.com'),
        ),
      ],
    );
  }
}
