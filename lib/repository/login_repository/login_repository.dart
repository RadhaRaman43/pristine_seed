import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class LoginRepository{
  final _apiService=NetworkApiServices();
  Future<String> loginApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.login_url,sessionManagement);
  }
}