class Foodmodel {
  String? idfood;
  String? idshop;
  String? picturefood;
  String? namefood;
  String? pricefood;
  String? detailfood;

  Foodmodel(
      {this.idfood,
      this.idshop,
      this.picturefood,
      this.namefood,
      this.pricefood,
      this.detailfood});

  Foodmodel.fromJson(Map<String, dynamic> json) {
    idfood = json['idfood'];
    idshop = json['idshop'];
    picturefood = json['picturefood'];
    namefood = json['namefood'];
    pricefood = json['pricefood'];
    detailfood = json['detailfood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idfood'] = idfood;
    data['idshop'] = idshop;
    data['picturefood'] = picturefood;
    data['namefood'] = namefood;
    data['pricefood'] = pricefood;
    data['detailfood'] = detailfood;
    return data;
  }
}
