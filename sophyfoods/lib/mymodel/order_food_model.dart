

class Ordermodel {
  int? id;
  String? idshop;
  String? nameshop;
  String? idfood;
  String? namefood;
  String? price;
  String? amount;
  String? sumamount;
  String? distance;
  String? transport;

  Ordermodel(
      {this.id,
      this.idshop,
      this.nameshop,
      this.idfood,
      this.namefood,
      this.price,
      this.amount,
      this.sumamount,
      this.distance,
      this.transport});

  Ordermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idshop = json['idshop'];
    nameshop = json['nameshop'];
    idfood = json['idfood'];
    namefood = json['namefood'];
    price = json['price'];
    amount = json['amount'];
    sumamount = json['sumamount'];
    distance = json['distance'];
    transport = json['transport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['idshop'] = idshop;
    data['nameshop'] = nameshop;
    data['idfood'] = idfood;
    data['namefood'] = namefood;
    data['price'] = price;
    data['amount'] = amount;
    data['sumamount'] = sumamount;
    data['distance'] = distance;
    data['transport'] = transport;
    return data;
  }
}
