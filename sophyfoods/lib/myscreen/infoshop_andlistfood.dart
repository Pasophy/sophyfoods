import 'package:flutter/material.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/mywidget/show_about_shop.dart';
import 'package:sophyfoods/mywidget/show_foodmenu_shop.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Showinfoshopandfood extends StatefulWidget {
  final Usermodel usermodel;
  const Showinfoshopandfood({
    super.key,
    required this.usermodel,
  });

  @override
  State<Showinfoshopandfood> createState() => _ShowinfoshopandfoodState();
}

class _ShowinfoshopandfoodState extends State<Showinfoshopandfood> {
  Usermodel? usermodel;
  Widget? currentwidget;
  int pageindex = 0;
  List<Widget> listmywidget = [const ShowAboutShop(), const ShowFoodMenushop()];
  List<Widget> listtitleappbar = [
    Mystyle().showtitle2("ព័ត៌លម្អិតមានហាង", Colors.white),
    Mystyle().showtitle2("រាយនាមមុខម្ហូប", Colors.white)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = widget.usermodel;
    setState(() {
      currentwidget = listmywidget[pageindex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: listtitleappbar[pageindex],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 45.0,
            color: Colors.white,
          ),
        ),
      ),
      body: currentwidget,
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 18.0,
          selectedFontSize: 16.0,
          selectedItemColor: Colors.red.shade900,
          unselectedItemColor: Colors.red.shade500,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.amber,
          currentIndex: pageindex,
          onTap: (value) {
            setState(() {
              pageindex = value;
              currentwidget = listmywidget[pageindex];
              listtitleappbar[pageindex];
            });
          },
          items: <BottomNavigationBarItem>[showaboutshop(), showlistmenu()]),
    );
  }

  BottomNavigationBarItem showaboutshop() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.food_bank,
          color: Color(Myconstant().appbarcolor),
          size: 30.0,
        ),
        tooltip: "Aboutshop",
        label: "ព័ត៌មានហាង");
  }

  BottomNavigationBarItem showlistmenu() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.restaurant_menu,
          color: Color(Myconstant().appbarcolor),
          size: 30.0,
        ),
        tooltip: "Listfood",
        label: "រាយមុខម្ហូម");
  }
}
