import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Addshopinformstion extends StatefulWidget {
  const Addshopinformstion({super.key});

  @override
  State<Addshopinformstion> createState() => _AddshopinformstionState();
}

class _AddshopinformstionState extends State<Addshopinformstion> {
  late double heights, widths;
  double? lat, lng;
  File? file;

  @override
  void initState() {
    super.initState();
    findlatlnt();
  }

  Future<Null> findlatlnt() async {
    try {
      LocationData locationData = await findlocationdat();
      setState(() {
        lat = locationData.latitude;
        lng = locationData.longitude;
      });
    } catch (e) {
      return null;
    }
    // ignore: avoid_print
    print("Lat=>$e  lng=>$e");
  }

  Future<LocationData> findlocationdat() async {
    Location location = Location();
    return location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    heights = MediaQuery.sizeOf(context).height;
    widths = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Mystyle().showtitle2("Add Information", Colors.white),
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
      height: 50.0,
      width: widths * 0.8,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(Myconstant().blues),
          ),
        ),
        onPressed: () {},
        child: Mystyle().showtitle3("Save Information", Colors.white),
      ),
    );
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
            width: widths * 0.8,
            child: TextField(
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
            width: widths * 0.8,
            child: TextField(
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
            width: widths * 0.8,
            child: TextField(
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
