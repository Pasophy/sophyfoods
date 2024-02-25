
class Usermodel {
  String? id;
  String? name;
  String? username;
  String? password;
  String? usertype;
  String? shopname;
  String? phone;
  String? address;
  String? picture;
  String? lat;
  String? lng;
  String? token;

  Usermodel(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.usertype,
      this.shopname,
      this.phone,
      this.address,
      this.picture,
      this.lat,
      this.lng,
      this.token});

  Usermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    usertype = json['usertype'];
    shopname = json['shopname'];
    phone = json['phone'];
    address = json['address'];
    picture = json['picture'];
    lat = json['lat'];
    lng = json['lng'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['usertype'] = usertype;
    data['shopname'] = shopname;
    data['phone'] = phone;
    data['address'] = address;
    data['picture'] = picture;
    data['lat'] = lat;
    data['lng'] = lng;
    data['token'] = token;
    return data;
  }
}

