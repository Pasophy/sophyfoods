import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sophyfoods/mymodel/food_model.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Editfoodshop extends StatefulWidget {
  final Foodmodel foodmodel;
  const Editfoodshop({super.key, required this.foodmodel});

  @override
  State<Editfoodshop> createState() => _EditfoodshopState();
}

class _EditfoodshopState extends State<Editfoodshop> {
  Foodmodel? foodmodel;
  late double widths, heights;
  String? idfood, namefood, pricefood, detailfood, urlpicture;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodmodel = widget.foodmodel;
    namefood = foodmodel!.namefood;
    pricefood = foodmodel!.pricefood;
    detailfood = foodmodel!.detailfood;
    urlpicture = foodmodel!.picturefood;
    idfood = foodmodel!.idfood;
  }

  @override
  Widget build(BuildContext context) {
    heights = MediaQuery.sizeOf(context).height;
    widths = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Mystyle().showtitle2("កែប្រែបញ្ជីមុខម្ហូប", Colors.white),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 45.0,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15.0),
              showtitleditpicture(),
              showeditpicturefood(),
              showtitleditdetail(),
              const SizedBox(height: 15.0),
              showeditnamefood(),
              showeditpricefood(),
              showeditdetailfood(),
              const SizedBox(height: 30.0),
              editfoodbuttom(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> choosefoodimage(ImageSource source) async {
    var object = await ImagePicker().pickImage(
      source: source,
      maxHeight: 750.0,
      maxWidth: 750.0,
    );

    setState(() {
      file = File(object!.path);
    });
  }

  Future<void> editfooddata() async {
    int i = Random().nextInt(100000000);
    String imagename = "food$i.jpg";
    String urluploadimage =
        "${Myconstant().domain}/projectflutterfoods/saveFoodPhoto.php";
    if (file == null) {
      try {
        String urleditfood =
            "${Myconstant().domain}/projectflutterfoods/editFoodWhereFoodid.php?isAdd=true&idfood=$idfood&picturefood=$urlpicture&namefood=$namefood&pricefood=$pricefood&detailfood=$detailfood";
        await Dio().get(urleditfood).then((value) {
          if (value.toString() == "true") {
            Navigator.pop(context);
          } else {
            mydialog(context, "editfail");
          }
        });
      } catch (e) {}
    } else {
      Map<String, dynamic> map = {};
      map["file"] =
          await MultipartFile.fromFile(file!.path, filename: imagename);
      FormData formData = FormData.fromMap(map);
      try {
        await Dio().post(urluploadimage, data: formData).then(
          (value) async {
            try {
              setState(() async {
                urlpicture = "/projectflutterfoods/PictureFoods/$imagename";
                String urlinsertdata =
                    "${Myconstant().domain}/projectflutterfoods/editFoodWhereFoodid.php?isAdd=true&idfood=$idfood&picturefood=$urlpicture&namefood=$namefood&pricefood=$pricefood&detailfood=$detailfood";
                await Dio().get(urlinsertdata).then((value) {
                  if (value.toString() == "true") {
                    Navigator.pop(context);
                  } else {
                    mydialog(context, "editfail");
                  }
                });
              });
            } catch (e) {}
          },
        );
      } catch (e) {}
    }
  }

  Widget showeditpicturefood() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widths * 0.14,
          child: IconButton(
            onPressed: () => choosefoodimage(ImageSource.camera),
            icon: Image.asset("images/image3.png"),
          ),
        ),
        SizedBox(
          height: heights * 0.3,
          width: widths * 0.5,
          child: file == null
              ? Image.network("${Myconstant().domain}$urlpicture",
                  fit: BoxFit.contain)
              : Image.file(
                  file!,
                  fit: BoxFit.contain,
                ),
        ),
        SizedBox(
          width: widths * 0.14,
          child: IconButton(
            onPressed: () => choosefoodimage(ImageSource.gallery),
            icon: Image.asset("images/image2.png"),
          ),
        ),
      ],
    );
  }

  Widget showtitleditdetail() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Mystyle().showtitle3("  សូមកែប្រែព័ត៌មានលំអិត:", Colors.blue),
        ],
      );

  Widget showtitleditpicture() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Mystyle().showtitle3("  សូមកែប្រែរូបភាពម្ហូប:", Colors.blue),
        ],
      );

  Widget showeditnamefood() {
    return Container(
      width: widths * .75,
      child: TextFormField(
        initialValue: foodmodel!.namefood,
        onChanged: (value) => namefood = value.toString(),
        style: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 18.0),
        decoration: InputDecoration(
          label: Mystyle().showtitle3("ឈ្មោះមុខម្ហូប:", Colors.red.shade900),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          prefixIcon: Icon(
            Icons.food_bank,
            color: Colors.green.shade700,
            size: 35.0,
          ),
        ),
      ),
    );
  }

  Widget showeditpricefood() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: widths * .75,
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: foodmodel!.pricefood,
        onChanged: (value) => pricefood = value.trim(),
        style: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 18.0),
        decoration: InputDecoration(
          label:
              Mystyle().showtitle3("តម្លៃមុខម្ហូប(៛)​:", Colors.red.shade900),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          prefixIcon: Icon(
            Icons.money,
            color: Colors.green.shade700,
            size: 35.0,
          ),
        ),
      ),
    );
  }

  Widget showeditdetailfood() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: widths * .75,
      child: TextFormField(
        initialValue: foodmodel!.detailfood,
        onChanged: (value) => detailfood = value.toString(),
        maxLines: 3,
        style: TextStyle(
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 18.0),
        decoration: InputDecoration(
          label:
              Mystyle().showtitle3("អធិប្បាយមុខម្ហូប​:", Colors.red.shade900),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0)),
          prefixIcon: Icon(
            Icons.details,
            color: Colors.green.shade700,
            size: 35.0,
          ),
        ),
      ),
    );
  }

  Widget editfoodbuttom() {
    return SizedBox(
      height: 45.0,
      width: widths * 0.45,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color(Myconstant().greencokor)),
        ),
        onPressed: () => confirmeditfood(),
        child: Mystyle().showtitle3("កែប្រែព័ត៌មាន", Colors.white),
      ),
    );
  }

  Future<void> confirmeditfood() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showtitle3(
            "តើអ្នកចង់កែប្រែទិន្នន័យមែនទេ..?", Color(Myconstant().blues)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  editfooddata();
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
}
