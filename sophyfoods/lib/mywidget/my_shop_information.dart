import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/myscreen/eidt_shop_information.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/myscreen/add_shop_information.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Shopinformation extends StatefulWidget {
  const Shopinformation({super.key});

  @override
  State<Shopinformation> createState() => _ShopinformationState();
}

class _ShopinformationState extends State<Shopinformation> {
  Usermodel? usermodel;
  String? shopname, urlimage;
  late double widths, hieghts;

  @override
  void initState() {
    super.initState();
    setState(() {
      getshopinformation();
    });
  }

  void addinformationshop(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    Navigator.push(context, route).then((value) => getshopinformation());
  }

  Future<Null> getshopinformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');

    String url =
        '${Myconstant().domain}/projectflutterfoods/getUserWhereUserid.php?isAdd=true&id=$id';

    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      for (var map in result) {
        setState(() {
          usermodel = Usermodel.fromJson(map);
          urlimage = usermodel!.picture;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    hieghts = MediaQuery.sizeOf(context).height;
    return Stack(children: <Widget>[
      usermodel == null
          ? Mystyle().showprogress()
          : usermodel!.shopname == ''
              ? Mystyle().showinformation("សូមមេត្តាបញ្ចូលព័ត៌មានហាង..!")
              : showshopinformation(),
      showctionbutton()
    ]);
  }

  Widget showshopinformation() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showtitleshop(),
            showpictureshop(),
            const SizedBox(height: 10.0),
            showshopname(),
            showaddressshop(),
            showtitlelocation(),
            const SizedBox(height: 10.0),
            showlocationshop(),
          ],
        ),
      ),
    );
  }

  Row showtitlelocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Mystyle().showtitle3("Lacation:", Color(Myconstant().reds)),
      ],
    );
  }

  Widget showlocationshop() {
    LatLng latLng = LatLng(
      double.parse(usermodel!.lat.toString()),
      double.parse(usermodel!.lng.toString()),
    );
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: hieghts * 0.5,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: createmarker(),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> createmarker() {
    return <Marker>{
      Marker(
        markerId: const MarkerId("Myshop"),
        position: LatLng(
          double.parse(usermodel!.lat.toString()),
          double.parse(usermodel!.lng.toString()),
        ),
        infoWindow: const InfoWindow(title: "NIE"),
      ),
    };
  }

  Widget showshopname() =>
      Mystyle().showtitle2("${usermodel!.shopname}", Color(Myconstant().reds));

  Widget showaddressshop() => Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Mystyle().showtitle3(
                    "Address:${usermodel!.address} ,Phone:${usermodel!.phone}.",
                    Color(Myconstant().reds)),
              )
            ],
          ),
        ),
      );

  Widget showpictureshop() {
    return SizedBox(
        width: widths * 0.6,
        height: hieghts * 0.3,
        child: Image.network('${Myconstant().domain}$urlimage'));
  }

  Widget showtitleshop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Mystyle().showtitle2(
          "ព័ត៌មានហាងរបស់អ្នក",
          Color(Myconstant().reds),
        ),
      ],
    );
  }

  Widget showctionbutton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                shape: CircleBorder(
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(Myconstant().greencokor),
                  ),
                ),
                backgroundColor: Color(Myconstant().greencokor),
                onPressed: () {
                  if (usermodel!.shopname != "") {
                    addinformationshop(const Editshopinformation());
                  } else {
                    addinformationshop(const Addshopinformation());
                  }
                },
                child: const Icon(
                  Icons.edit,
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
