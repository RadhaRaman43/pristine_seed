import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class BackGroundServiceRepository{

  final _apiService=NetworkApiServices();
  Future<String> userLocationInsertApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.userLocationInsert,sessionManagement);
  }
}