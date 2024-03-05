import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophyfoods/myscreen/user_signin.dart';
import 'package:sophyfoods/myscreen/user_signup.dart';
import 'package:sophyfoods/mywidget/show_list_shopall.dart';
import 'package:sophyfoods/mywidget/show_listfood_order.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mystyle.dart';
import 'package:sophyfoods/utility/opendrawer.dart';
import 'package:sophyfoods/utility/usersingnout.dart';

class Mybuyers extends StatefulWidget {
  const Mybuyers({super.key});

  @override
  State<Mybuyers> createState() => _MybuyersState();
}

class _MybuyersState extends State<Mybuyers> {
  Widget? currentwidget;
  String? usertype;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentwidget = const Showalllistshop();
    findusertype();
  }

  Future<void> findusertype() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usertype = preferences.getString("usertype");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: opendrawer(),
          title: Mystyle().showtitle2('Mainbuyser', Colors.white),
          actions: <Widget>[
            IconButton(
              onPressed: () => usersignout(context),
              icon: const Icon(
                Icons.output,
                size: 30.0,
              ),
              color: Colors.white,
            )
          ],
        ),
        drawer: drawerbuyers(),
        body: currentwidget ?? Mystyle().showprogress());
  }

  Widget drawerbuyers() {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              const SizedBox(height: 15.0),
              drawerheader(),
              showaboutbuyer(),
              showlistshop(),
              showlistorder(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              menusignup(),
            ],
          ),
        ],
      ),
    );
  }

  Widget showaboutbuyer() {
    return ListTile(
      leading: const Icon(
        Icons.info,
        size: 36.0,
        color: Colors.green,
      ),
      title: Mystyle().showtitle3("ព័ត៌មានរបស់អ្នក", Colors.blue.shade800),
      hoverColor: Colors.red,
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (values) => const Mysignin(),
        );
        Navigator.push(context, route);
      },
    );
  }

  Widget showlistshop() {
    return ListTile(
      leading: const Icon(
        Icons.home,
        size: 36.0,
        color: Colors.green,
      ),
      title: Mystyle().showtitle3("ហាងអាហារទាំងអស់", Colors.blue.shade800),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          currentwidget = const Showalllistshop();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget showlistorder() {
    return ListTile(
      leading: const Icon(
        Icons.food_bank,
        size: 36.0,
        color: Colors.green,
      ),
      title: Mystyle().showtitle3("អាហារដែលបានកម្ម៉ង់", Colors.blue.shade800),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          currentwidget = const Showlistfoodorder();
        });
        Navigator.pop(context);
      },
    );
  }

  Widget menusignup() {
    return Container(
      color: Colors.green.shade300,
      child: ListTile(
        leading: const Icon(
          Icons.output,
          size: 36.0,
          color: Colors.red,
        ),
        title: Mystyle().showtitle2("ចាកចេញ", Colors.red.shade800),
        hoverColor: Colors.black54,
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (values) => const Mysignup(),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget drawerheader() {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Color(Myconstant().appbarcolor),
            // image: const DecorationImage(
            //   image: AssetImage('images/logo1.png'),
            //   fit: BoxFit.fill,
            // ),
            gradient: RadialGradient(colors: [
              Colors.white,
              Color(Myconstant().appbarcolor),
            ], radius: 1.3, center: const Alignment(-0.6, -0.1)),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: const AssetImage('images/logo3.png'),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.red,
                      width: 3.0,
                      style: BorderStyle.solid,
                      strokeAlign: 0.9),
                  shape: BoxShape.circle),
            ),
          ),
          accountName: const Text(
            'Profile',
            style: TextStyle(color: Colors.red),
          ),
          accountEmail: const Text(
            'pasophy18@gmail.com',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
