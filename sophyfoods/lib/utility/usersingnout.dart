import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mystate/myhome.dart';

Future<Null> usersignout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => const Myhome(),
  );
  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}

