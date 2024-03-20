import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sophyfoods/mymodel/order_food_model.dart';
import 'package:sophyfoods/utility/myconstant.dart';
import 'package:sophyfoods/utility/mysql_lite_helper.dart';
import 'package:sophyfoods/utility/mystyle.dart';

class Cartorderfood extends StatefulWidget {
  const Cartorderfood({super.key});

  @override
  State<Cartorderfood> createState() => _CartorderfoodState();
}

class _CartorderfoodState extends State<Cartorderfood> {
  List<Ordermodel> listfood = [];
  int total = 0;
  Widget? actionbuttom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gateorderdatasqlite();
  }

  Future<Null> gateorderdatasqlite() async {
    listfood.clear();
    var object = await SqliteHelper().gateAllOrderdata();
    for (var model in object) {
      String? sumsring = model.sumamount;
      int sumamount = int.parse(sumsring.toString());
      setState(() {
        listfood = object;
        total += sumamount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonBar(
        buttonPadding: const EdgeInsets.all(20.0),
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
            onPressed: () {
              setState(() {
                confirmdeleteorder(context);
              });
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            label: Mystyle().showtitle3("មិនកម្ម៉ង", Colors.white),
          ),
          ElevatedButton.icon(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Mystyle().showtitle3("កម៉្មង", Colors.white)),
        ],
      ),
      body: listfood.isEmpty
          ? Mystyle().showinformation("មិនទាន់មានទិ្នន័យ")
          : showmycontent(),
    );
  }

  Future<dynamic> confirmdeleteorder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showtitle3(
            "តើអ្នកចង់លុបអាហារដែលបានកម៉្មង់ទាំងអស់មែនទេ..?",
            Color(Myconstant().reds)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await SqliteHelper().deletealldataorder().then((value) {
                    setState(() {
                      total = 0;
                      gateorderdatasqlite();
                    });
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(Myconstant().greencokor),
                  ),
                ),
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
              const SizedBox(width: 20.0),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(Myconstant().greencokor),
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32.0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Column showmycontent() {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Mystyle()
                .showtitle3("ឈ្មោះហាង: ${listfood[0].nameshop}", Colors.blue),
          ],
        ),
        Row(
          children: [
            Mystyle().showtitle3(
                "ចំងាយផ្លូវ: ${listfood[0].distance} គីឡូម៉ែត្រ", Colors.blue),
          ],
        ),
        Row(
          children: [
            Mystyle().showtitle3(
                "ថ្លៃដឹក: ${listfood[0].transport} រៀល", Colors.blue),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Mystyle().showtitle3("មុខម្ហូប", Colors.blue),
            ),
            Expanded(
                flex: 1, child: Mystyle().showtitle3("តម្លៃ.៛", Colors.blue)),
            Expanded(
                flex: 1, child: Mystyle().showtitle3("ចំនួន", Colors.blue)),
            Expanded(
                flex: 1, child: Mystyle().showtitle3("សរុប.៛", Colors.blue)),
            Expanded(
              flex: 1,
              child: Mystyle().showtitle3("លុប", Colors.blue),
            ),
          ],
        ),
        buildlistfoods(),
        const Divider(
          color: Colors.black26,
        ),
        Container(
          margin: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Mystyle().showtitle3(
                  "Total:   ${NumberFormat("#,##0", "en_US").format(total)}៛",
                  Colors.blue),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildlistfoods() => ListView.builder(
        padding: const EdgeInsets.all(5.0),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: listfood.length,
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "${listfood[index].namefood}",
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${listfood[index].price}",
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${listfood[index].amount}",
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${listfood[index].sumamount}",
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {
                  int? idorder = listfood[index].id;
                  await SqliteHelper().deletefoodorder(idorder!).then((value) {
                    setState(() {
                      total = 0;
                      gateorderdatasqlite();
                    });
                  });
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      );
}
