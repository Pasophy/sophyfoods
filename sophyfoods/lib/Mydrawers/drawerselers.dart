import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/mystate/signin.dart';
import 'package:sophyfoods/mystate/signup.dart';
import 'package:sophyfoods/utility/mystyle.dart';

Widget drawerselers(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        drawerheader(),
        menulistorder(context),
        menulistfood(context),
        shopinformation(context),
        signout(context),
      ],
    ),
  );
}

Widget menulistorder(BuildContext context) {
  return ListTile(
    leading: Icon(Icons.list_alt,size: 35.0,color: Color(Myconstant().reds),),
    title: Mystyle().showtitle3('List Order',Color(Myconstant().reds)),
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

Widget menulistfood(BuildContext context) {
  return ListTile(
    leading: Icon(Icons.lunch_dining,size: 35.0,color: Color(Myconstant().reds),),
    title: Mystyle().showtitle3("List Food", Color(Myconstant().reds)),
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

Widget shopinformation(BuildContext context) {
  return ListTile(
    leading:Icon(Icons.info,size: 35.0,color: Color(Myconstant().reds),),
    title: Mystyle().showtitle3("Shop Detail",Color(Myconstant().reds)),
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

Widget signout(BuildContext context) {
  return ListTile(
    leading:Icon(Icons.logout,size: 35.0,color: Color(Myconstant().reds),),
    title: Mystyle().showtitle3("Sign up", Color(Myconstant().reds)),
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
        accountName: const Text('Pa Sophy',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        accountEmail: const Text('pasophy18@gmail.com',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
      ),
    ],
  );
}
