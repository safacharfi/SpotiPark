class User {
  late String id;
  late String name;
  late String password;
  late String phone;

  User(this.id,
      {required this.name, required this.password, required this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['phone'] = phone;
    return data;
  }
}