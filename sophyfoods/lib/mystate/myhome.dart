import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mystate/buyers.dart';
import 'package:sophyfoods/mystate/riders.dart';
import 'package:sophyfoods/mystate/selers.dart';
import 'package:sophyfoods/Mydrawers/drawerhomescren.dart';
import 'package:sophyfoods/utility/opendrawer.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  void initState() {
    super.initState();
    checkuserloging();
  }

  Future<Null> checkuserloging() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? usertype = preferences.getString('usertype');
      if (usertype != null && usertype.isNotEmpty) {
        if (usertype == 'selers') {
          routrtoservice(const Myselers());
        } else if (usertype == 'buyers') {
          routrtoservice(const Mybuyers());
        } else if (usertype == 'riders') {
          routrtoservice(const Myriders());
        } 
      } 
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'Error');
    }
  }

  void routrtoservice(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: opendrawer(),
        //backgroundColor: Color(Myconstant().appbarcolor),
      ),
      drawer: drawerhomescrenc(context),
    );
  }

 
}
