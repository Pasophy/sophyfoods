import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mymodel/food_model.dart';
import 'package:sophyfoods/myscreen/add_food_information.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Shopfood extends StatefulWidget {
  const Shopfood({super.key});

  @override
  State<Shopfood> createState() => _ShopfoodState();
}

class _ShopfoodState extends State<Shopfood> {
  bool status = true;
  bool loadstatus = true;
  String? id;
  List<Foodmodel> fooddata = [];
  late double widths, heights;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfoodmodel();
  }

  Future<Null> getfoodmodel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");

    String ulr =
        "${Myconstant().domain}/projectflutterfoods/getFoodWhereUserid.php?isAdd=true&idshop=$id";
    await Dio().get(ulr).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != "null") {
        var result = json.decode(value.data);
        int count = 0;
        for (var map in result) {
          count += 0;
          Foodmodel foodmodel = Foodmodel.fromJson(map);
          setState(() {
            fooddata.add(foodmodel);
            print("=================>${fooddata[count]}");
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<Null> getfooddata() async {}

  void routetoaddfood() {
    setState(() {
      fooddata.clear();
    });
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (context) => const Addfoodinformation());
    Navigator.push(context, pageRoute).then((value) {
      getfoodmodel();
    });
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          loadstatus ? Mystyle().showprogress() : showmycontent(),
          showbuttomlistfood(),
        ],
      ),
    );
  }

  Widget showmycontent() {
    return status
        ? showlistfood()
        : Mystyle().showinformation("សូមបញ្ចូលមុខម្ហូបរបស់អ្នក...!");
  }

  Widget showlistfood() => ListView.builder(
        itemCount: fooddata.length,
        itemBuilder: (context, index) => Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: heights * 0.17,
                  height: heights * 0.15,
                  child: Image.network(
                    "${Myconstant().domain}${fooddata[index].picturefood}",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              width: widths * 0.5,
              height: heights * 0.17,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Mystyle().showfoodname("${fooddata[index].namefood}",
                      Color(Myconstant().greencokor)),
                  Mystyle().showfooddetail(
                      "${fooddata[index].pricefood} ៛", Colors.red),
                  Mystyle().showfooddetail(
                      "${fooddata[index].detailfood}", Colors.blue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Color(Myconstant().greencokor),
                        ),
                      ),
                      const SizedBox(width: 35.0),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

  Container showbuttomlistfood() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () => routetoaddfood(),
                backgroundColor: Color(Myconstant().appbarcolor),
                shape: CircleBorder(
                    side: BorderSide(color: Color(Myconstant().greencokor))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
