import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class DashboardRepo{
  final _apiService=NetworkApiServices();

  Future<String> callDashboardGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallDashboard,sessionManagement);
  }

  Future<String> callDashboardUserWiseDataApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallDashboardUserWiseData,sessionManagement);
  }

}