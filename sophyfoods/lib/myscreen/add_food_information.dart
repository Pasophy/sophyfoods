import 'dart:io';

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Addfoodinformation extends StatefulWidget {
  const Addfoodinformation({super.key});

  @override
  State<Addfoodinformation> createState() => _AddfoodinformationState();
}

class _AddfoodinformationState extends State<Addfoodinformation> {
  late double widths, hieghts;
  String? foodname, fooddetail, foodprice, shopid;
  File? file;

  @override
  void initState() {
    super.initState();
    setState(() {
      finduseridorshopid();
    });
  }

  Future<Null> finduseridorshopid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    shopid = preferences.getString("id");
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    hieghts = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 45.0,
          ),
        ),
        title: Mystyle().showtitle2("សូមបញ្ចូលមុខម្ហូប", Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10.0),
              showtitlefoodpicture(),
              const SizedBox(height: 15.0),
              file == null ? showaddpicturefood() : Image.file(file!),
              const SizedBox(height: 10.0),
              showtitlefooddetail(),
              const SizedBox(height: 15.0),
              showfoodname(),
              const SizedBox(height: 15.0),
              showfoodprice(),
              const SizedBox(height: 15.0),
              showfooddetail(),
              const SizedBox(height: 30.0),
              showsavefoodbuttom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showsavefoodbuttom() {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          if (foodname == null ||
              foodname == "" ||
              foodprice == null ||
              foodprice == "" ||
              fooddetail == null ||
              fooddetail == "") {
            mydialog(context, "សូមបញ្ចូលទិន្នន័យឱ្យគ្រប់...!");
          } else if (file == null) {
            mydialog(context, "សូមបញ្ចូលរូបភាព...!");
          } else {
            uploadimageandinserdata();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(Myconstant().greencokor),
            elevation: 10.0,
            minimumSize: const Size(200.0, 45.0)),
        child: Mystyle().showtitle2(
          "រក្សាទុក",
          Colors.white,
        ),
      ),
    );
  }

  Widget showtitlefooddetail() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Mystyle().showtitle3("  សូមបញ្ចូលព័ត៌មានលំអិត:", Colors.blue),
        ],
      );

  Widget showtitlefoodpicture() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Mystyle().showtitle3("  សូមបញ្ចូលរូបភាពម្ហូប:", Colors.blue),
        ],
      );

  SizedBox showfoodname() {
    return SizedBox(
      width: widths * 0.75,
      child: TextField(
        onChanged: (value) => foodname = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.food_bank,
            size: 30.0,
            color: Color(Myconstant().greencokor),
          ),
          label: Mystyle().showtitle3("ឈ្មោះមុខម្ហូប", Colors.blue),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox showfoodprice() {
    return SizedBox(
      width: widths * 0.75,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => foodprice = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.paid,
            size: 30.0,
            color: Color(Myconstant().greencokor),
          ),
          label: Mystyle().showtitle3("តម្លៃមុខម្ហូប(៛)", Colors.blue),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox showfooddetail() {
    return SizedBox(
      width: widths * 0.75,
      child: TextField(
        onChanged: (value) => fooddetail = value.trim(),
        maxLines: 3,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.details,
            size: 30.0,
            color: Color(Myconstant().greencokor),
          ),
          label: Mystyle().showtitle3("អធិប្បាយម្ហូប", Colors.blue),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Color(Myconstant().reds),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> chooseimage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
        maxWidth: 400.0,
        maxHeight: 270.0,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Future<Null> uploadimageandinserdata() async {
    Random random = Random();
    int i = random.nextInt(1000000000);
    String picturename = "food$i.jpg";
    String urlpicture =
        '${Myconstant().domain}/projectflutterfoods/saveFoodPhoto.php';
    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: picturename);
      FormData formData = FormData.fromMap(map);
      await Dio().post(urlpicture, data: formData).then(
        (value) async {
          try {
            urlpicture = "/projectflutterfoods/PictureFoods/$picturename";
            String urlinsertdata =
                "${Myconstant().domain}/projectflutterfoods/insertFoodData.php?isAdd=true&idshop=$shopid&picturefood=$urlpicture&namefood=$foodname&pricefood=$foodprice&detailfood=$fooddetail";
            Response response = await Dio().get(urlinsertdata);
            print("=======================>$response");
            if (response.toString() == "true") {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            } else {
              // ignore: use_build_context_synchronously
              mydialog(context, "insertfail");
            }
          } catch (e) {}
        },
      );
    } catch (e) {}
  }

  Widget showaddpicturefood() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widths * 0.14,
          child: IconButton(
            onPressed: () => chooseimage(ImageSource.camera),
            icon: Image.asset("images/image3.png"),
          ),
        ),
        SizedBox(
          height: hieghts * 0.45,
          width: widths * 0.45,
          child: Image.asset("images/image1.png"),
        ),
        SizedBox(
          width: widths * 0.14,
          child: IconButton(
            onPressed: () => chooseimage(ImageSource.gallery),
            icon: Image.asset("images/image2.png"),
          ),
        ),
      ],
    );
  }
}
