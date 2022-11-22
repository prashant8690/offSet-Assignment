import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:offsetfarm_assignment/model/university_details_model.dart';
import 'package:offsetfarm_assignment/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static late AppPrefs _appPreferences;
  static SharedPreferences? _sharedPreferences;

  static SharedPreferences get sharedPreferences => _sharedPreferences!;

  AppPrefs._();

  static Future<AppPrefs> getInstance() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _appPreferences = AppPrefs._();
    }
    return _appPreferences;
  }

  final String _user = "user";
  final String listStore = "storeList";
  void storeList(List<UniversityDetailsModel> universityList) {
    _set(listStore, universityDetailsModelToJson(universityList));
  }

  void setUser(UserModel? userModel) {
    if (userModel != null) {
      _set(_user, jsonEncode(userModel.toJson()));
    } else {
      _set(_user, userModel);
    }
  }

  List<UniversityDetailsModel>? get getList {
    String? getListString = _getString(listStore);
    if (getListString != null) {
      return universityDetailsModelFromJson(getListString);
    }
    return null;
  }

  UserModel? get getUser {
    String? getUserString = _getString(_user);
    if (getUserString != null) {
      return UserModel.fromJson(jsonDecode(getUserString));
    } else {
      return null;
    }
  }

  _set(
    String key,
    dynamic value,
  ) {
    if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is List) {
      sharedPreferences.setStringList(key, value as List<String>);
    } else {
      debugPrint('Invalid type');
    }
  }

  String? _getString(String key, {String? def}) {
    return sharedPreferences.containsKey(key)
        ? sharedPreferences.getString(key)
        : def;
  }

  Future<bool> clear() {
    return sharedPreferences.clear();
  }
}
