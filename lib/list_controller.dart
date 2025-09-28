import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_app/user_model.dart';
import 'package:http/http.dart' as http;

class ListController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getUsers() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      const String fullUrl =
          "https://68bab10384055bce63efd7a2.mockapi.io/api/v1/users";

      final response = await http.get(Uri.parse(fullUrl));
      // print("full url $fullUrl");
      if (response.statusCode == 200) {
        print("get user response ${response.body}");

        List<dynamic> jsonData = json.decode(response.body);

        _userList = jsonData.map((user) => UserModel.fromJson(user)).toList();

        print("total user are ${_userList.length}");
      } else {
        // print("error fetching users ${response.body} ${response.statusCode}");
      }
    } catch (e, s) {
      print("error fethcing data from api, Error: $e, Stacktree: $s");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
