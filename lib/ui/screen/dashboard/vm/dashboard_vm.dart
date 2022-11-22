
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:offsetfarm_assignment/core/utils/shared_prefrences.dart';
import 'package:offsetfarm_assignment/model/user_model.dart';

class DashBoardVm extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? value) {
    _userModel = value;
    notifyListeners();
  }

  DashBoardVm() {
    fetchUser();
  }

  fetchUser() {
    _userModel = GetIt.I.get<AppPrefs>().getUser!;
  }
}
