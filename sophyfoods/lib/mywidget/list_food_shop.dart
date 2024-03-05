import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mymodel/food_model.dart';
import 'package:sophyfoods/myscreen/add_food_information.dart';
import 'package:sophyfoods/myscreen/edit_food_shop.dart';
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
    fooddata.clear();
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

        for (var map in result) {
          Foodmodel foodmodel = Foodmodel.fromJson(map);
          setState(() {
            fooddata.add(foodmodel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

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
        itemBuilder: (context, index) => Card(
          color: Colors.white30,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white70,
                            width: 5.01,
                            strokeAlign: 0.3)),
                    margin: const EdgeInsets.all(8.0),
                    width: heights * 0.17,
                    height: heights * 0.17,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${Myconstant().domain}${fooddata[index].picturefood}"),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                width: widths * 0.52,
                height: heights * 0.17,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Mystyle().showfoodname("${fooddata[index].namefood}",
                          Color(Myconstant().greencokor)),
                      Mystyle().showfooddetail(
                          "${fooddata[index].pricefood} ៛", Colors.red),
                      Mystyle().showfooddetail(
                          "${fooddata[index].detailfood}", Colors.blue),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white30, shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: () {
                                MaterialPageRoute pageRoute = MaterialPageRoute(
                                    builder: (context) => Editfoodshop(
                                        foodmodel: fooddata[index]));
                                Navigator.push(context, pageRoute)
                                    .then((value) => getfoodmodel());
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Color(Myconstant().greencokor),
                                size: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 35.0),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white30, shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: () =>
                                  confirmdeletefood(fooddata[index]),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Future<void> confirmdeletefood(Foodmodel foodmodel) async {
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showtitle3(
            "តើអ្នកចង់លុបមុខម្ហូប<${foodmodel.namefood}>នេះមែនទេ..?",
            Color(Myconstant().blues)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {
                  String urldelet =
                      "${Myconstant().domain}/projectflutterfoods/deleteFoodWhereFoodid.php?isAdd=true&idfood=${foodmodel.idfood}";
                  try {
                    Navigator.pop(context);
                    await Dio().get(urldelet).then((value) => getfoodmodel());
                  } catch (e) {}
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(Myconstant().greencokor),
                  ),
                ),
                child:
                    Mystyle().showtitle3("យល់ព្រម", Color(Myconstant().reds)),
              ),
              const SizedBox(width: 10.0),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(Myconstant().greencokor),
                  ),
                ),
                child: Mystyle()
                    .showtitle3("មិនយល់ព្រម", Color(Myconstant().reds)),
              )
            ],
          )
        ],
      ),
    );
  }

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
