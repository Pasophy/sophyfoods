import 'package:flutter/material.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Editshopinformation extends StatefulWidget {
  const Editshopinformation({super.key});

  @override
  State<Editshopinformation> createState() => _EditshopinformationState();
}

class _EditshopinformationState extends State<Editshopinformation> {
  late double widths, heights;
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
        title: Mystyle().showtitle2("Edit Information", Colors.white),
      ),
      body: GestureDetector(
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
                editlocatinshop(),
                editbuttomshop(),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editshopname() => SizedBox(
        width: widths * 0.75,
        child: TextFormField(
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
              onPressed: () {},
              icon: Image.asset("images/image3.png"),
            ),
          ),
          SizedBox(
              width: widths * 0.4,
              height: heights * 0.3,
              child: Image.asset("images/image1.png")),
          SizedBox(
            width: widths * 0.15,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("images/image2.png"),
            ),
          ),
        ],
      ),
    );
  }

  Container editlocatinshop() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      color: Colors.brown,
      height: heights * 0.4,
      width: double.infinity,
    );
  }

  SizedBox editbuttomshop() {
    return SizedBox(
      height: 45.0,
      width: widths * 0.6,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
        ),
        onPressed: () {},
        child: Mystyle().showtitle3("Edit Information", Colors.white),
      ),
    );
  }
}
