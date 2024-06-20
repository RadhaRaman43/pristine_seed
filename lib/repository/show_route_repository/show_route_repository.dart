import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ShowRoutesRepository {
  final _apiService = NetworkApiServices();
  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }

  Future<String> userWiseCoordinatesApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.getDateWiseUserCoordinate, sessionManagement);
  }
}