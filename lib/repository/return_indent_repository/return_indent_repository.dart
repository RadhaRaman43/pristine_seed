import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ReturnIndentRepository{
  final _apiServices=NetworkApiServices();

  Future<String> returnIndentLocationApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.getApi( AppUrl.getReturnLocation,sessionManagement,data);
  }


}