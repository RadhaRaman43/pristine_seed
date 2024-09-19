import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class IndentListRepository{
  final _apiService=NetworkApiServices();
  Future<String> indentListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.indentListGet,sessionManagement);
  }

  Future<String> indentListDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.indentListHeaderGet,sessionManagement);
  }

}

