import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/showdailog.dart';

class Addshopinformation extends StatefulWidget {
  const Addshopinformation({super.key});

  @override
  State<Addshopinformation> createState() => _AddshopinformstionState();
}

class _AddshopinformstionState extends State<Addshopinformation> {
  late double heights, widths;
  double? lat, lng;
  File? file;
  String? shopname, phone, address, userid, urlimage;

  @override
  void initState() {
    super.initState();
    findlatlng();
  }

  @override
  Widget build(BuildContext context) {
    heights = MediaQuery.sizeOf(context).height;
    widths = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Mystyle().showtitle2("បញ្ចូលព័ត៌មានហាង", Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              showshopname(),
              showshopphone(),
              showshopaddress(),
              showpicture(),
              lat == null ? Mystyle().showprogress() : showgooglemap(),
              showaddbuttom(),
              const SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox showaddbuttom() {
    return SizedBox(
      height: 45.0,
      width: widths * 0.6,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color(Myconstant().greencokor)),
        ),
        onPressed: () {
          if (shopname == null ||
              shopname == "" ||
              phone == null ||
              phone == "" ||
              address == null ||
              address == "") {
            mydialog(context, "សូមបញ្ចូលព័ត៌មាន..!");
          } else if (file == null) {
            mydialog(context, "សូមបញ្ចូលរូបភាព..!");
          } else {
            uploadphoto();
          }
        },
        child: Mystyle().showtitle3("Save Information", Colors.white),
      ),
    );
  }

  Future<LocationData> findlocationdat() async {
    Location location = Location();
    return location.getLocation();
  }

  Future<Null> findlatlng() async {
    try {
      LocationData locationData = await findlocationdat();
      setState(() {
        lat = locationData.latitude;
        lng = locationData.longitude;
      });
    } catch (e) {
      rethrow;
    }
  }

  Container showgooglemap() {
    LatLng latLng = LatLng(lat!, lng!);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14.0,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      color: Colors.brown,
      height: heights * 0.4,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>{
      Marker(
        markerId: const MarkerId("myShop"),
        position: LatLng(lat!, lng!),
        infoWindow: const InfoWindow(title: "NIE"),
      ),
    };
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

  Future<Null> saveinformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("id");
    String url =
        "${Myconstant().domain}/projectflutterfoods/editUserWhereid.php?isAdd=true&id=$userid&shopname=$shopname&phone=$phone&address=$address&picture=$urlimage&lat=$lat&lng=$lng";
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, "insert false");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Null> uploadphoto() async {
    Random random = Random();
    int i = random.nextInt(100000000);
    String imagename = 'shop$i.jpg';
    String url = '${Myconstant().domain}/projectflutterfoods/savePhoto.php';
    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: imagename);
      FormData formData = FormData.fromMap(map);
      //how 1
      //Response response=  await Dio().post(url, data: formData);
      //print('===============>$response');
      //how2
      await Dio().post(url, data: formData).then((value) {
        print("==============>$value");
        urlimage = '/projectflutterfoods/StorePhoto/$imagename';
        saveinformation();
      });
    } catch (e) {
      rethrow;
    }
  }

  Widget showpicture() {
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
                  ? Image.asset("images/image1.png")
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

  Widget showshopname() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            width: widths * 0.75,
            child: TextField(
              onChanged: (value) => shopname = value.trim(),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.shop,
                  color: Color(Myconstant().reds),
                ),
                labelText: 'Shopname:',
                labelStyle: TextStyle(
                    color: Color(Myconstant().reds),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(Myconstant().reds),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                        Myconstant().reds,
                      ),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
              ),
            ),
          ),
        ],
      );

  Widget showshopphone() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            width: widths * 0.75,
            child: TextField(
              onChanged: (value) => phone = value.trim(),
              keyboardType: TextInputType.phone,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(Myconstant().reds),
                ),
                labelText: 'phone:',
                labelStyle: TextStyle(
                    color: Color(Myconstant().reds),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(Myconstant().reds),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                        Myconstant().reds,
                      ),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
              ),
            ),
          ),
        ],
      );

  Widget showshopaddress() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            width: widths * 0.75,
            child: TextField(
              onChanged: (value) => address = value.trim(),
              maxLines: 2,
              keyboardAppearance: Brightness.light,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Color(Myconstant().reds),
                ),
                labelText: 'Address:',
                labelStyle: TextStyle(
                    color: Color(Myconstant().reds),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(Myconstant().reds),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                        Myconstant().reds,
                      ),
                      style: BorderStyle.solid,
                      width: 1.5),
                ),
              ),
            ),
          ),
        ],
      );
}
