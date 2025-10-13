import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? createdAt;
  final String? name;
  final String? avatar;
  final String? address;
  final String? id;

  const UserModel(
      {this.createdAt, this.name, this.avatar, this.address, this.id});

  UserModel.fromJson(Map<String, dynamic> json)
      : createdAt = json['createdAt'],
        name = json['name'],
        avatar = json['avatar'],
        address = json['address'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['avatar'] = avatar;
    data['address'] = address;
    data['id'] = id;
    return data;
  }

  @override
  List<Object?> get props => [createdAt, name, avatar, address, id];
}
