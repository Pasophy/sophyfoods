import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/mywidget/my_shop_information.dart';
import 'package:sophyfoods/mywidget/list_food_order.dart';
import 'package:sophyfoods/mywidget/list_food_shop.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/opendrawer.dart';
import 'package:sophyfoods/utility/usersingnout.dart';

class Myselers extends StatefulWidget {
  const Myselers({super.key});

  @override
  State<Myselers> createState() => _MyselersState();
}

class _MyselersState extends State<Myselers> {
  String? username;
  Widget currentwidget = const Orderfood();

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
        leading: opendrawer(),
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('MainShop', Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: () => usersignout(context),
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      drawer: showdrawer(),
      body: currentwidget,
    );
  }

  Widget showdrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            drawerheader(),
            menulistorder(),
            menulistfood(),
            shopinformation(),
            signout(),
          ],
        ),
      );

  Widget menulistorder() {
    return ListTile(
      leading: Icon(
        Icons.list_alt,
        size: 35.0,
        color: Color(Myconstant().reds),
      ),
      title: Mystyle().showtitle3('List Order', Color(Myconstant().reds)),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          currentwidget = const Orderfood();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget menulistfood() {
    return ListTile(
      leading: Icon(
        Icons.lunch_dining,
        size: 35.0,
        color: Color(Myconstant().reds),
      ),
      title: Mystyle().showtitle3("List Food", Color(Myconstant().reds)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {
          currentwidget = const Shopfood();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget shopinformation() {
    return ListTile(
      leading: Icon(
        Icons.info,
        size: 35.0,
        color: Color(Myconstant().reds),
      ),
      title: Mystyle().showtitle3("Shop Detail", Color(Myconstant().reds)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {
          currentwidget = const Shopinformation();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget signout() {
    return ListTile(
      leading: Icon(
        Icons.logout,
        size: 35.0,
        color: Color(Myconstant().reds),
      ),
      title: Mystyle().showtitle3("Sign up", Color(Myconstant().reds)),
      hoverColor: Colors.black54,
      onTap: () {
        usersignout(context);
      },
    );
  }

  Widget drawerheader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(Myconstant().appbarcolor),
        // image: const DecorationImage(
        //   image: AssetImage('images/logo1.png'),
        //   fit: BoxFit.fill,
        // ),
        gradient: RadialGradient(colors: [
          Colors.white,
          Color(Myconstant().appbarcolor),
        ], radius: 1.3, center: const Alignment(-0.6, -0.1)),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: const AssetImage('images/logo3.png'),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.red,
                  width: 3.0,
                  style: BorderStyle.solid,
                  strokeAlign: 0.9),
              shape: BoxShape.circle),
        ),
      ),
      accountName: const Text(
        'Pa Sophy',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      accountEmail: const Text(
        'pasophy18@gmail.com',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
