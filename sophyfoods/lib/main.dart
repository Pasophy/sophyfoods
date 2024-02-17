import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/mystate/buyers.dart';
import 'package:sophyfoods/mystate/myhome.dart';
import 'package:sophyfoods/mystate/riders.dart';
import 'package:sophyfoods/mystate/selers.dart';
import 'package:sophyfoods/mystate/signin.dart';
import 'package:sophyfoods/mystate/signup.dart';

  final  Map<String, WidgetBuilder> routes = {
  "/myhome": (BuildContext context) => const Myhome(),
  "/signin": (BuildContext context) => const Mysignin(),
  "/signout": (BuildContext context) => const Mysignup(),
  "/riders": (BuildContext context) => const Myriders(),
  "/selers": (BuildContext context) => const Myselers(),
  "/buyers": (BuildContext context) => const Mybuyers(),
};

 String? initialroute;
void main() {
  initialroute = Myconstant().myhome;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(color: Color(Myconstant().appbarcolor))),
      routes: routes,
      initialRoute: Myconstant().myhome,
      
    );
  }
}
