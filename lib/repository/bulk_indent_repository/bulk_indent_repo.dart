import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class BulkIndentRepository{
  final _apiServices=NetworkApiServices();

  Future<String> getBulkIndentListApiHit(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.bulkIndentList, sessionManagement);
  }

  Future<String>bulkIndentHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.bulkIndentHeaderCreate,sessionManagement);
  }


  Future<String> item_noApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.itemMasterGet,sessionManagement);
  }


}