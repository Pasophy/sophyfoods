import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sophyfoods/mymodel/food_model.dart';
import 'package:sophyfoods/mymodel/order_food_model.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mysql_lite_helper.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class ShowFoodMenushop extends StatefulWidget {
  final Usermodel usermodel;
  const ShowFoodMenushop({
    super.key,
    required this.usermodel,
  });
  @override
  State<ShowFoodMenushop> createState() => _ShowFoodMenushopState();
}

class _ShowFoodMenushopState extends State<ShowFoodMenushop> {
  Usermodel? usermodel;
  List<Foodmodel> fooddata = [];
  late double widths, heights;
  int amount = 1;
  double? distancess, lat1, lng1, lat2, lng2, mydistance;
  int? mytransport;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = widget.usermodel;
    getfoodmodel();
    findlatlng1lng1();
  }

  //របៀបទី2ស្វែងរលlat and lng
  Future<Null> findlatlng1lng1() async {
    LocationData? locationData = await findlocationdata();
    lat1 = locationData!.latitude;
    lng1 = locationData.longitude;
    lat2 = double.parse(usermodel!.lat.toString());
    lng2 = double.parse(usermodel!.lng.toString());
    //how to rwite 1
    // setState(() {
    //   distancess = calculateDistance(lat1, lng1, lat2, lng2);
    // });
    setState(() {
      double distance = Geolocator.distanceBetween(
              double.parse(lat1.toString()),
              double.parse(lng1.toString()),
              double.parse(lat2.toString()),
              double.parse(lng2.toString())) /
          1000;
      var myformat = NumberFormat('##0.###', 'en_US');
      mydistance = double.parse(myformat.format(distance));
      mytransport = calculateTransport(distance);
    });
  }

  int calculateTransport(double distance) {
    int transport;
    if (distance < 1.0) {
      transport = 2500;
      return transport;
    } else {
      transport = 2500 + (distance - 1).round() * 2000;
      return transport;
    }
  }

  Future<LocationData?> findlocationdata() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<Null> getfoodmodel() async {
    fooddata.clear();
    String ulr =
        "${Myconstant().domain}/projectflutterfoods/getFoodWhereUserid.php?isAdd=true&idshop=${usermodel!.id}";
    try {
      await Dio().get(ulr).then((value) {
        if (value.toString() != "null") {
          var result = json.decode(value.data);
          for (var map in result) {
            Foodmodel foodmodel = Foodmodel.fromJson(map);
            setState(() {
              fooddata.add(foodmodel);
            });
          }
        } else {
          mydialog(context, "ហាងនេះមិនទាន់មានអាហារលក់ទេសូមអរគុណ។");
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          usermodel == null ? Mystyle().showprogress() : showmycontent(),
        ],
      ),
    );
  }

  Widget showmycontent() {
    return showlistfood();
  }

  Widget showlistfood() => ListView.builder(
        itemCount: fooddata.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print('==============>$index');
            confirmOrder(index);
            amount = 1;
          },
          child: Card(
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
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Mystyle().showtitle2("${fooddata[index].namefood}",
                              Color(Myconstant().greencokor)),
                          const SizedBox(height: 8.0),
                          Mystyle().showtitle3(
                              "${fooddata[index].pricefood} ៛", Colors.red),
                          const SizedBox(height: 8.0),
                          Mystyle().showfooddetail(
                              "${fooddata[index].detailfood}", Colors.blue),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future<Null> confirmOrder(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          titlePadding: const EdgeInsets.only(top: 10.0),
          actionsPadding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Mystyle().showfoodname(
                  "${fooddata[index].namefood}", Colors.green.shade500),
            ],
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "${Myconstant().domain}${fooddata[index].picturefood}"),
                        fit: BoxFit.fill),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  width: heights * 0.23,
                  height: heights * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          amount++;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 36.0,
                        color: Colors.green.shade500,
                      ),
                    ),
                    Mystyle()
                        .showtitle2(amount.toString(), Colors.blue.shade700),
                    IconButton(
                      onPressed: () {
                        if (amount > 1) {
                          setState(() {
                            amount--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 36.0,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade500),
                      child: Mystyle().showfooddetail("លើកលែង", Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        adorderTomycart(index);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade500),
                      child:
                          Mystyle().showfooddetail("កម៉្មង់ឥឡូវ", Colors.white),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> adorderTomycart(int index) async {
    String? idshop = usermodel!.id;
    String? nameshop = usermodel!.shopname;
    String? idfood = fooddata[index].idfood;
    String? namefoode = fooddata[index].namefood;
    String? price = fooddata[index].pricefood;
    int priceInt = int.parse(price.toString());
    int amounts = amount;
    int totalamount = priceInt * amounts;
    Map<String, dynamic> datamap = {};
    datamap['idshop'] = idshop;
    datamap['nameshop'] = nameshop;
    datamap['idfood'] = idfood;
    datamap['namefood'] = namefoode;
    datamap['price'] = price;
    datamap['amount'] = amounts.toString();
    datamap['sumamount'] = totalamount.toString();
    datamap['distance'] = mydistance.toString();
    datamap['transport'] = mytransport.toString();

    var object = await SqliteHelper().gateAllOrderdata();
    Ordermodel ordermodel = Ordermodel.fromJson(datamap);
    if (object.isEmpty) {
      await SqliteHelper().insertdataOrder(ordermodel).then((value) {
        showtoast("បានសម្រេច");
      });
    } else {
      String idshopsqlite = object[0].idshop.toString();
      if (idshop == idshopsqlite) {
        await SqliteHelper().insertdataOrder(ordermodel).then((value) {
          showtoast("បានសម្រេច");
        });
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, "សូមកម៉្មង់ហាងនេះ <${object[0].nameshop}> ឱ្យចប់សិន");
      }
    }
  }

  void showtoast(String string) => Fluttertoast.showToast(
        msg: string,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red.shade800,
        textColor: Colors.white,
        fontSize: 18.0,
      );
}
