import 'package:sophyfoods/mymodel/order_food_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper {
  final String databaseName = "sophyfoods.db";
  final String tableName = "tbOrderfood";
  int version = 1;
  final String idorder = "id";
  final String idshop = "idshop";
  final String nameshop = "nameshop";
  final String idfood = "idfood";
  final String namefood = "namefood";
  final String price = "price";
  final String amount = "amount";
  final String sumamount = "sumamount";
  final String distance = "distance";
  final String transport = "transport";

  SqliteHelper() {
    initDatabase();
  }

  // Get a location using getDatabasesPath and open the database
  Future<Null> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableName ($idorder INTEGER PRIMARY KEY, $idshop TEXT, $nameshop TEXT, $idfood TEXT, $namefood TEXT, $price TEXT, $amount TEXT, $sumamount TEXT, $distance TEXT, $transport TEXT)'),
      version: version,
    );
  }

  //connectdatabase
  Future<Database> connectDatabase() async {
    return openDatabase(join(await getDatabasesPath(), databaseName));
  }

  //insertdata to table tbOrderfood
  Future<Null> insertdataOrder(Ordermodel ordermodel) async {
    Database database = await connectDatabase();
    try {
      database.insert(
        tableName,
        ordermodel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // ignore: avoid_print
      print("Order error");
    }
  }

  //Gate all Order data frome table tbOrderfood
  Future<List<Ordermodel>> gateAllOrderdata() async {
    Database database = await connectDatabase();
    List<Ordermodel> listorder = [];
    List<Map<String, dynamic>> maps = await database.query(tableName);
    for (var map in maps) {
      Ordermodel ordermodel = Ordermodel.fromJson(map);
      listorder.add(ordermodel);
    }
    return listorder;
  }
}
