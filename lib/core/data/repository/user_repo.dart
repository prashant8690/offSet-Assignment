import 'package:offsetfarm_assignment/model/university_details_model.dart';

abstract class UserRepo {
  Future<List<UniversityDetailsModel>> fetchData();
}
