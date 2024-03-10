import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class ShowAboutShop extends StatefulWidget {
  final Usermodel usermodel;
  const ShowAboutShop({
    super.key,
    required this.usermodel,
  });

  @override
  State<ShowAboutShop> createState() => _ShowAboutShopState();
}

class _ShowAboutShopState extends State<ShowAboutShop> {
  Usermodel? usermodel;
  late double widths, heights;
  double? distancess, lat1, lng1, lat2, lng2, mydistance;
  Location location = Location();
  int? mytransport;
  CameraPosition? position;

  @override
  void initState() {
    super.initState();
    usermodel = widget.usermodel;
    //របៀបទី១ស្វែងរលlat and lng rial time
    // Location().onLocationChanged.listen((event) {
    //   lat1 = event.latitude;
    //   lng1 = event.longitude;
    // });
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

  //របៀបគណនាចម្ងាយលើផែនទី
  // double calculateDistance(lat1, lng1, lat2, lng2) {
  //   double distance = 0;
  //   var p = 0.017453292519943295;
  //   // var c = cos;
  //   // var s = sin;
  //   // var a = pow(s((lat2 - lat1) / 2), 2) +
  //   //     c(lat1) * c(lat2) * pow(s((lng2 - lng1) / 2), 2);
  //   // distance =asin(sqrt(a));
  //   double a, b, c;
  //   a = (cos(lat1 * p) * cos(lat2 * p) * cos(lng1 * p) * cos(lng2 * p));
  //   b = (cos(lat1 * p) * sin(lng1 * p) * cos(lat2 * p) * sin(lng2 * p));
  //   c = sin(lat1 * p) * sin(lat2 * p);
  //   distance = acos(a + b + c) * 6370;

  //   double mydistance = acos(sin(lat1 * p) * sin(lat2 * p) +
  //           cos(lat1 * p) * cos(lat2 * p) * cos((lng2 - lng1) * p)) *
  //       6371;

  //   print("================>c====>$mydistance");
  //   // print("================>c$distance");
  //   print("================>e$distance");
  //   return distance;
  // }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   double distan = 0;
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   distan = 12742 * asin(sqrt(a));
  //   return distan;
  // }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            showpicetureshop(),
            const SizedBox(height: 10.0),
            showtitleshopname(),
            showaddressshop(),
            showphoneshop(),
            showdistanceshop(),
            showpricerider(),
            showmapshop()
          ],
        ),
      ),
    );
  }

  Marker buyerMarker() {
    return Marker(
      markerId: const MarkerId("Buyermarker"),
      position: LatLng(lat1!, lng1!),
      icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
      infoWindow: const InfoWindow(title: "កន្លែងអ្នក"),
    );
  }

  Marker shopMarker() {
    return Marker(
      markerId: const MarkerId("Shopmarker"),
      position: LatLng(lat2!, lng2!),
      //icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
      infoWindow: InfoWindow(title: usermodel!.shopname),
    );
  }

  Set<Marker> mysetmarker() {
    return <Marker>{buyerMarker(), shopMarker()};
  }

  Container showmapshop() {
    if (lat1 != null) {
      LatLng latLng = LatLng(lat1!, lng1!);
      position = CameraPosition(
        target: latLng,
        zoom: 16,
      );
    } else {}
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.brown,
      height: heights * 0.35,
      child: lat1 == null
          ? Mystyle().showprogress()
          : GoogleMap(
              initialCameraPosition: position!,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mysetmarker(),
            ),
    );
  }

  ListTile showpricerider() {
    return ListTile(
      leading: const Icon(
        Icons.transfer_within_a_station,
        size: 30.0,
        color: Colors.green,
      ),
      title: mytransport == null
          ? Mystyle().showprogress()
          : Mystyle()
              .showtitle3("$mytransport រៀល (ថ្លៃដឹក).", Colors.blue.shade800),
    );
  }

  ListTile showdistanceshop() {
    return ListTile(
      leading: const Icon(
        Icons.directions_bike,
        size: 30.0,
        color: Colors.green,
      ),
      title: mydistance == null
          ? Mystyle().showprogress()
          : Mystyle()
              .showtitle3("$mydistance គីឡូម៉ែត្រ.", Colors.blue.shade800),
    );
  }

  ListTile showphoneshop() {
    return ListTile(
      leading: const Icon(
        Icons.phone,
        size: 30.0,
        color: Colors.green,
      ),
      title: Mystyle().showtitle3("${usermodel!.phone}.", Colors.blue.shade800),
    );
  }

  ListTile showaddressshop() {
    return ListTile(
      leading: const Icon(
        Icons.home,
        size: 30.0,
        color: Colors.green,
      ),
      title:
          Mystyle().showtitle3("${usermodel!.address}. ", Colors.blue.shade800),
    );
  }

  Widget showtitleshopname() =>
      Mystyle().showtitle2("${usermodel!.shopname}", Colors.red.shade800);

  SizedBox showpicetureshop() {
    return SizedBox(
      height: heights * 0.25,
      child: Image.network("${Myconstant().domain}${usermodel!.picture}"),
    );
  }
}
