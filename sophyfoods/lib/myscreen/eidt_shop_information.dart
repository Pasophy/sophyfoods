import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Editshopinformation extends StatefulWidget {
  const Editshopinformation({super.key});

  @override
  State<Editshopinformation> createState() => _EditshopinformationState();
}

class _EditshopinformationState extends State<Editshopinformation> {
  late double widths, heights;
  double? lat, lng;
  String? userid, shopname, phone, address, urlpicture;
  Usermodel? usermodel;
  File? file;

  @override
  void initState() {
    super.initState();
    finduserinfomation();
    Location().onLocationChanged.listen((event) {
      lat = event.latitude;
      lng = event.longitude;
    });
  }

  Future<void> finduserinfomation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("id");

    String url =
        "${Myconstant().domain}/projectflutterfoods/getUserWhereUserid.php?isAdd=true&id=$userid";
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    for (var map in result) {
      setState(() {
        usermodel = Usermodel.fromJson(map);
        shopname = usermodel!.shopname;
        phone = usermodel!.phone;
        address = usermodel!.address;
        urlpicture = usermodel!.picture;
      });
    }
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Null> editinformationshop() async {
    Random random = Random();
    int i = random.nextInt(100000000);
    String imagename = 'shop$i.jpg';
    String url = '${Myconstant().domain}/projectflutterfoods/savePhoto.php';
    try {
      if (file == null) {
        urlpicture = usermodel!.picture;
        String? userid = usermodel!.id;
        String url =
            "${Myconstant().domain}/projectflutterfoods/editUserWhereid.php?isAdd=true&id=$userid&shopname=$shopname&phone=$phone&address=$address&picture=$urlpicture&lat=$lat&lng=$lng";
        await Dio().get(url).then((value) {
          if (value.toString() == "true") {
            Navigator.pop(context);
          } else {
            // ignore: use_build_context_synchronously
            mydialog(context, "edit fail");
          }
        });
      } else {
        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: imagename);
        FormData formData = FormData.fromMap(map);
        await Dio().post(url, data: formData).then((value) async {
          print("======================>$value");
          urlpicture = '/projectflutterfoods/StorePhoto/$imagename';
          String? userid = usermodel!.id;
          String url =
              "${Myconstant().domain}/projectflutterfoods/editUserWhereid.php?isAdd=true&id=$userid&shopname=$shopname&phone=$phone&address=$address&picture=$urlpicture&lat=$lat&lng=$lng";
          await Dio().get(url).then((value) {
            if (value.toString() == "true") {
              Navigator.pop(context);
            } else {
              // ignore: use_build_context_synchronously
              mydialog(context, "edit fail");
            }
          });
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left_sharp),
          color: Colors.white,
          iconSize: 45.0,
        ),
        title: Mystyle().showtitle2("កែប្រែព័ត៌មានហាង", Colors.white),
      ),
      body:
          usermodel == null ? Mystyle().showprogress() : showmycontent(context),
    );
  }

  Widget showmycontent(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(
        FocusScopeNode(),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              editshopname(),
              const SizedBox(height: 15.0),
              editphoneshop(),
              const SizedBox(height: 15.0),
              editshopaddress(),
              editpictureshop(),
              lat == null ? Mystyle().showprogress() : editlocatinshop(),
              editbuttomshop(),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget editshopname() => SizedBox(
        width: widths * 0.75,
        child: TextFormField(
          initialValue: shopname,
          onChanged: (value) => shopname = value.toString(),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              labelText: "Editshopname:",
              prefixIcon:
                  Icon(Icons.shop, color: Color(Myconstant().reds), size: 30.0),
              labelStyle: TextStyle(
                  color: Color(Myconstant().reds),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          style: const TextStyle(
              color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      );

  Widget editphoneshop() => SizedBox(
        width: widths * 0.75,
        child: TextFormField(
          initialValue: phone,
          onChanged: (value) => phone = value.toString(),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              labelText: "Editshopphone:",
              prefixIcon: Icon(Icons.phone,
                  color: Color(Myconstant().reds), size: 30.0),
              labelStyle: TextStyle(
                  color: Color(Myconstant().reds),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          style: const TextStyle(
              color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      );

  Widget editshopaddress() => SizedBox(
        width: widths * 0.75,
        child: TextFormField(
          initialValue: address,
          onChanged: (value) => address = value.toString(),
          maxLines: 2,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(Myconstant().reds), width: 1.5)),
              labelText: "Editshopadress:",
              prefixIcon:
                  Icon(Icons.home, color: Color(Myconstant().reds), size: 30.0),
              labelStyle: TextStyle(
                  color: Color(Myconstant().reds),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          style: const TextStyle(
              color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      );

  Widget editpictureshop() {
    return SizedBox(
      width: widths * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widths * 0.15,
            child: IconButton(
              onPressed: () => chooseImage(ImageSource.camera),
              icon: Image.asset("images/image3.png"),
            ),
          ),
          SizedBox(
              width: widths * 0.4,
              height: heights * 0.3,
              child: file == null
                  ? Image.network("${Myconstant().domain}$urlpicture")
                  : Image.file(file!)),
          SizedBox(
            width: widths * 0.15,
            child: IconButton(
              onPressed: () => chooseImage(ImageSource.gallery),
              icon: Image.asset("images/image2.png"),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> mymarker() {
    return <Marker>{
      Marker(
        markerId: const MarkerId("NIE"),
        position: LatLng(lat!, lng!),
        infoWindow: InfoWindow(onTap: () {}, title: "NIE", snippet: "ok"),
      ),
    };
  }

  Container editlocatinshop() {
    LatLng latLng = LatLng(lat!, lng!);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      color: Colors.brown,
      height: heights * 0.4,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        markers: mymarker(),
      ),
    );
  }

  SizedBox editbuttomshop() {
    return SizedBox(
      height: 45.0,
      width: widths * 0.6,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color(Myconstant().greencokor)),
        ),
        onPressed: () => confirmmydailog(),
        child: Mystyle().showtitle3("កែប្រែព័ត៌ហាង", Colors.white),
      ),
    );
  }

  Future<void> confirmmydailog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showtitle3(
            "តើអ្នកចង់កែប្រែព័ត៌មានមែនទេ..?", Color(Myconstant().blues)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  editinformationshop();
                  Navigator.pop(context);
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
}
