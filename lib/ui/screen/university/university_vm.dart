import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:offsetfarm_assignment/core/data/repository/user_repo.dart';
import 'package:offsetfarm_assignment/core/utils/app_function.dart';
import 'package:offsetfarm_assignment/core/utils/shared_prefrences.dart';
import 'package:offsetfarm_assignment/model/university_details_model.dart';

class UniversityVm extends ChangeNotifier {
  final userRepo = GetIt.I.get<UserRepo>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UniversityVm() {
    fetchDataList();
  }

  List<UniversityDetailsModel> universityList = [];

  Future<void> fetchDataList() async {
    try {
      isLoading = true;
      universityList.clear();
      if (await checkConnection()) {
        final response = await userRepo.fetchData();
        universityList = response;
        GetIt.I.get<AppPrefs>().storeList(response);
      } else {
        universityList = GetIt.I.get<AppPrefs>().getList!;
      }
      print("==========${universityList.length}");
    } catch (e, StackTrace) {
      debugPrintStack(stackTrace: StackTrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
