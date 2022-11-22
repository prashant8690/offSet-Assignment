import 'package:get_it/get_it.dart';
import 'package:offsetfarm_assignment/core/data/network/api_client.dart';
import 'package:offsetfarm_assignment/core/data/repository/user_repo.dart';
import 'package:offsetfarm_assignment/model/university_details_model.dart';

class UserRepoImpl extends UserRepo {
  static final apiClient = GetIt.I.get<ApiClient>();
  @override
  Future<List<UniversityDetailsModel>> fetchData() async {
    return await apiClient.fetchData();
  }
}
