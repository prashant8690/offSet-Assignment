import 'package:offsetfarm_assignment/model/university_details_model.dart';

abstract class ApiClient {
  Future<List<UniversityDetailsModel>> fetchData();
}
