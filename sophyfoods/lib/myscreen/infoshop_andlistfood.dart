import 'package:flutter/material.dart';
import 'package:sophyfoods/mymodel/user_model.dart';
import 'package:sophyfoods/mywidget/show_mycart_order.dart';
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

  int pageindex = 0;
  List<Widget> listmywidget = [];
  List<Widget> listtitleappbar = [
    Mystyle().showtitle2("ព័ត៌មានលម្អិតហាង", Colors.white),
    Mystyle().showtitle2("រាយនាមមុខម្ហូប", Colors.white),
    Mystyle().showtitle2("អាហារដែលបានកម៉្មង់", Colors.white),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = widget.usermodel;
    setState(() {
      listmywidget.add(ShowAboutShop(usermodel: usermodel!));
      listmywidget.add(ShowFoodMenushop(usermodel: usermodel!));
      listmywidget.add( const Cartorderfood());
      listmywidget[pageindex];
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
      body: listmywidget[pageindex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 16.0,
        selectedFontSize: 16.0,
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.red.shade500,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: Colors.amber.shade500,
        currentIndex: pageindex,
        onTap: (value) {
          setState(() {
            pageindex = value;
            listmywidget[pageindex];
            listtitleappbar[pageindex];
          });
        },
        items: <BottomNavigationBarItem>[
          showaboutshop(),
          showlistmenu(),
          showaboutcard()
        ],
      ),
    );
  }

  BottomNavigationBarItem showaboutshop() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.food_bank,
          color: Color(Myconstant().appbarcolor),
          size: 26.0,
        ),
        tooltip: "Aboutshop",
        label: "ព័ត៌មានហាង");
  }

  BottomNavigationBarItem showlistmenu() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.restaurant_menu,
          color: Color(Myconstant().appbarcolor),
          size: 26.0,
        ),
        tooltip: "Listfood",
        label: "រាយមុខម្ហូប");
  }

  BottomNavigationBarItem showaboutcard() {
    return BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
          color: Color(Myconstant().appbarcolor),
          size: 20.0,
        ),
        tooltip: "Cart",
        label: "កម៉្មង់");
  }
}
