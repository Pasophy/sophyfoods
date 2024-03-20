import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/myscreen/infoshop_andlistfood.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Showalllistshop extends StatefulWidget {
  const Showalllistshop({super.key});

  @override
  State<Showalllistshop> createState() => _ShowalllistshopState();
}

class _ShowalllistshopState extends State<Showalllistshop> {
  Usermodel? usermodel;
  List<Usermodel> listuser = <Usermodel>[];
  List<Widget> myshopcard = <Widget>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getusertype();
    });
  }

  Future<void> getusertype() async {
    String urlgetuser =
        "${Myconstant().domain}/projectflutterfoods/getUserWhereSeller.php?isAdd=true&usertype=sellers";

    try {
      await Dio().get(urlgetuser).then((value) {
        var result = json.decode(value.data);
        int index = 0;
        for (var map in result) {
          usermodel = Usermodel.fromJson(map);
          String? shopname = usermodel!.shopname;
          if (shopname!.isNotEmpty) {
            setState(() {
              listuser.add(usermodel!);
              myshopcard.add(mycreatecard(usermodel!, index));
              index++;
            });
          }
        }
      });
    } catch (e) {}
  }

  Widget mycreatecard(Usermodel usermodel, int index) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) =>
                Showinfoshopandfood(usermodel: listuser[index]));
        Navigator.push(context, route);
      },
      child: Card(
        color: Colors.white60,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                height: 110.0,
                width: 110.0,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      "${Myconstant().domain}${usermodel.picture}"),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Mystyle().showtitle3("${usermodel.shopname}", Colors.red.shade900)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return myshopcard.isEmpty
        ? Mystyle().showprogress()
        : Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 280.0,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              children: myshopcard,
            ),
          );
  }
}
