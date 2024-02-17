
class Usermodel {
  String? id;
  String? name;
  String? username;
  String? password;
  String? usertype;

  Usermodel({this.id, this.name, this.username, this.password, this.usertype});

  Usermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    usertype = json['usertype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['usertype'] = usertype;
    return data;
  }
}
