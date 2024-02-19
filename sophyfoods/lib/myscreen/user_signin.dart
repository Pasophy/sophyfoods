import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/mymodel/usermodel.dart';
import 'package:sophyfoods/myscreen/main_buyers.dart';
import 'package:sophyfoods/myscreen/main_riders.dart';
import 'package:sophyfoods/myscreen/main_selers.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Mysignin extends StatefulWidget {
  const Mysignin({super.key});

  @override
  State<Mysignin> createState() => _MysigninState();
}

class _MysigninState extends State<Mysignin> {
  bool eyes = true;
  String? username, password;

  @override
  Widget build(BuildContext context) {
    double hieghts = MediaQuery.sizeOf(context).height;
    //double widths = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2('Sign In', Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildlogo(hieghts),
                buildappname(),
                textfieldusername(),
                textfieldpassword(),
                showbuttom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildappname() => Mystyle().showtitle1(
        Myconstant().appname,
        Color(Myconstant().reds),
      );

  Widget buildlogo(double hieghts) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: hieghts * 0.02),
        height: hieghts * 0.25,
        child: Mystyle().showlogo(),
      ),
    );
  }

  Widget textfieldusername() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white54,
      ),
      height: 50.0,
      width: 250.0,
      child: TextField(
        onChanged: (value) => username = value.trim(),
        decoration: InputDecoration(
          labelText: 'Usename:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color(Myconstant().reds),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      ),
    );
  }

  Widget textfieldpassword() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white54,
      ),
      height: 50.0,
      width: 250.0,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: eyes,
        decoration: InputDecoration(
          labelText: 'Password:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.lock_open, color: Color(Myconstant().reds)),
          suffixIcon: IconButton(
            icon: eyes
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                eyes = !eyes;
              });
            },
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color(Myconstant().reds),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      ),
    );
  }

  Widget signinbutton() {
    return SizedBox(
      width: 200.0,
      height: 45.0,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(Myconstant().blues),
          foregroundColor: Color(Myconstant().blues),
          side: BorderSide(
            width: 1.0,
            color: Color(Myconstant().blues),
            strokeAlign: 0.2,
          ),
        ),
        onPressed: () {
          if (username == null ||
              username == "" ||
              password == null ||
              password == "") {
            mydialog(context, 'pleascheckdata...!');
          } else {
            //print('username=$username password=$password');
            gatuserwhere();
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> gatuserwhere() async {
    String url =
        '${Myconstant().domain}/projectflutterfoods/getUserWhereUser.php?isAdd=true&username=$username';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    if (result.toString() == 'null') {
      // ignore: use_build_context_synchronously
      mydialog(context, 'Check username and password..!');
    } else {
      for (var map in result) {
        Usermodel usermodel = Usermodel.fromJson(map);
        if (password == usermodel.password) {
          String? usertype = usermodel.usertype;
          if (usertype == 'selers') {
            routetoservice(const Myselers(),usermodel);
          } else if (usertype == 'buyers') {
            routetoservice(const Mybuyers(),usermodel);
          } else if (usertype == 'riders') {
            routetoservice(const Myriders(),usermodel);
          } else {
            // ignore: use_build_context_synchronously
            mydialog(context, 'error login');
          }
        } else {
          // ignore: use_build_context_synchronously
          mydialog(context, 'please check password...!');
        }
      }
    }
  }

  Future<Null> checkpreferences(Usermodel usermodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', usermodel.id.toString());
    preferences.setString('usertype', usermodel.usertype.toString());
    preferences.setString('name', usermodel.name.toString());
  }

  void routetoservice(Widget mywidget, Usermodel usermodel) {
    checkpreferences(usermodel);
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => mywidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget showbuttom() {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          signinbutton(),
        ],
      ),
    );
  }
}
