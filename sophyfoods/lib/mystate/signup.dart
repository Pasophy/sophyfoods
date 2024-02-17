import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';
import 'package:dio/dio.dart';

class Mysignup extends StatefulWidget {
  const Mysignup({super.key});

  @override
  State<Mysignup> createState() => _MysignoutState();
}

class _MysignoutState extends State<Mysignup> {
  late double hieghts;
  late double widths;
  bool eyes = true;
  String? name, username, password, usertype;

  @override
  Widget build(BuildContext context) {
    hieghts = MediaQuery.sizeOf(context).height;
    widths = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(Myconstant().appbarcolor),
        title: Mystyle().showtitle2("Sign Up", Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: ListView(
          children: [
            buildlogo(),
            buildappname(),
            textfieldname(),
            textfieldusername(),
            textfieldpassword(),
            buildgender(),
            showbuttom(),
          ],
        ),
      ),
    );
  }

  Widget buildlogo() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: hieghts * 0.03),
        //height: hieghts * 0.25,
        width: widths * 0.5,
        child: Mystyle().showlogo(),
      ),
    );
  }

  Widget buildappname() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: Mystyle().showtitle1(
              Myconstant().appname,
              Color(Myconstant().reds),
            ),
          ),
        ],
      );

  Widget textfieldname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white54,
          ),
          height: 50.0,
          width: widths * 0.7,
          child: TextField(
            onChanged: (value) => name = value.trim(),
            decoration: InputDecoration(
              labelText: 'Name:',
              labelStyle: TextStyle(
                height: -0.5,
                color: Color(Myconstant().reds),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: Icon(
                Icons.person_3_outlined,
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
        ),
      ],
    );
  }

  Widget textfieldusername() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white54,
          ),
          height: 50.0,
          width: widths * 0.7,
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
                Icons.account_circle_outlined,
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
        ),
      ],
    );
  }

  Widget textfieldpassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white54,
          ),
          height: 50.0,
          width: widths * 0.7,
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
              prefixIcon:
                  Icon(Icons.lock_open, color: Color(Myconstant().reds)),
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
        ),
      ],
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
          if (name == null ||
              name == "" ||
              username == null ||
              username == "" ||
              password == null ||
              password == "") {
            mydialog(context, 'pleasinputdata...!');
          } else if (usertype == null) {
            mydialog(context, 'pleascheckusertype..!');
          } else {
            checkuser();
            //insertuser();
          }
        },
        child: const Text(
          'Register',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkuser() async {
    String url =
        '${Myconstant().domain}/projectflutterfoods/getUserWhereUser.php?isAdd=true&username=$username';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        insertuser();
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'plaese chang username...!');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'error==>$e');
    }
  }

  Future<Null> insertuser() async {
    String url =
        '${Myconstant().domain}/projectflutterfoods/insertData.php?isAdd=true&name=$name&username=$username&password=$password&usertype=$usertype';
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);//chang unicode8
      if (result.toString() == 'true') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'insert user fail');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, "error==>$e");
    }
  }

  Widget showbuttom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15.0, bottom: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              signinbutton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildgender() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.only(left: widths * 0.25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          builuertype(),
          radioselers(),
          radiobuyer(),
          radiorider(),
        ],
      ),
    );
  }

  Widget builuertype() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 35.0,
        ),
        Text(
          "Usertype:",
          style: TextStyle(
            color: Color(Myconstant().reds),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row radioselers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 25.0,
        ),
        Radio(
          value: 'selers',
          groupValue: usertype,
          onChanged: (value) {
            setState(() {
              usertype = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().reds)),
        ),
        Text(
          'seler',
          style: TextStyle(
            color: Color(Myconstant().reds),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }

  Row radiobuyer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 25.0,
        ),
        Radio(
          value: 'buyers',
          groupValue: usertype,
          onChanged: (value) {
            setState(() {
              usertype = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().reds)),
        ),
        Text(
          'buyer',
          style: TextStyle(
            color: Color(Myconstant().reds),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }

  Row radiorider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 25.0,
        ),
        Radio(
          value: 'riders',
          groupValue: usertype,
          onChanged: (value) {
            setState(() {
              usertype = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().reds)),
        ),
        Text(
          'rider',
          style: TextStyle(
            color: Color(Myconstant().reds),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }
}
