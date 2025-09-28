class UserModel {
  String? createdAt;
  String? name;
  String? avatar;
  String? address;
  String? id;

  UserModel({this.createdAt, this.name, this.avatar, this.address, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['avatar'] = avatar;
    data['address'] = address;
    data['id'] = id;
    return data;
  }
}
