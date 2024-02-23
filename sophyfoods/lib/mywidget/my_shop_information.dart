import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';
import 'package:sophyfoods/myscreen/add_shop_information.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Shopinformation extends StatefulWidget {
  const Shopinformation({super.key});

  @override
  State<Shopinformation> createState() => _ShopinformationState();
}

class _ShopinformationState extends State<Shopinformation> {
  void addinformationshop() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => const Addshopinformstion());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Mystyle().showinformation("សូមមេត្តាបញ្ចូលព័ត៌មានហាង..!"),
      showctionbutton()
    ]);
  }

  Container showctionbutton() {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    addinformationshop();
                  },
                  child: Icon(Icons.edit,
                      color: Color(
                        Myconstant().reds,
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
