import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider_app/user_model.dart';

class ListController extends ChangeNotifier {
  final String baseUrl =
      "https://68bab10384055bce63efd7a2.mockapi.io/api/v1/users";
  bool _isLoading = false;
  final Dio _dio = Dio();
  String? _error;
  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get all users from the server
  Future<void> getUsers() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _dio.get(baseUrl);

      if (response.statusCode == 200) {
        print("get user response ${response.data}");

        // response.data is already a List<dynamic>
        List<dynamic> jsonData = response.data;

        _userList = jsonData.map((user) => UserModel.fromJson(user)).toList();

        print("total users are ${_userList.length}");
      } else {
        print("Error fetching users: ${response.statusCode}");
      }
    } catch (e, s) {
      print("Error fetching data from API: $e\nStacktrace: $s");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // get a single user based on ID
  Future<UserModel?> getUserById(String id) async {
    try {
      final response = await _dio.get("$baseUrl/$id");
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e, s) {
      print("Error fetching user by ID: $e, Stacktrace: $s");
    }
    return null;
  }

// CREATE  a new user
  Future<void> addUser(UserModel userToAdd) async {
    try {
      final response = await _dio.post(baseUrl, data: userToAdd.toJson());
      if (response.statusCode == 201) {
        _userList.add(UserModel.fromJson(response.data));
        notifyListeners();
      }
    } catch (e, s) {
      print("Error adding user: $e, Stacktrace: $s");
    }
  }

  // UPDATE an existing user
  Future<void> updateUser(String id, UserModel userToUpdate) async {
    try {
      final response =
          await _dio.put("$baseUrl/$id", data: userToUpdate.toJson());
      if (response.statusCode == 200) {
        int index = _userList.indexWhere((u) => u.id == id);
        if (index != -1) {
          _userList[index] = UserModel.fromJson(response.data);
          notifyListeners();
        }
      }
    } catch (e, s) {
      print("Error uploading user $e, Stacktree : $s");
    }
  }

  // Delete User
  Future<void> deleteUser(String idToDelete) async {
    try {
      final response = await _dio.delete("$baseUrl/$idToDelete");
      if (response.statusCode == 200) {
        _userList.removeWhere((user) => user.id == idToDelete);
        notifyListeners();
      }
    } catch (e, s) {
      print("Error deleting user: $e, Stacktrace: $s");
    }
  }

  // Future<List<UserModel>> getDropDownusers() async{
  //   List<UserModel> users = [];
  //   try{
  //     _isLoading = true;
  //     _error = null;
  //     notifyListeners();

  //     final response = await _dio.get(baseUrl);

  //     if(response.statusCode == 200){
  //       print("get users dropdown data ${response.data}");

  //       List<dynamic> jsonData = response.data;
  //     }
  //   }
  // }
}
