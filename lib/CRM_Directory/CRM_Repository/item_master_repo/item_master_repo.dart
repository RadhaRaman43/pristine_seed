import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class ItemMasterRepo{
  final _apiService=NetworkApiServices();
  Future<String> ItemMstSalesCycleGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ItemMstSalesCycleGet,sessionManagement);
  }

  Future<String> ItemMstSalesCycleDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ItemMstSalesCycleDelete,sessionManagement);
  }

  Future<String> getItemCategoryMstWithoutTaskIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ItemCategoryMstGet, sessionManagement, data);
  }

  Future<String> GSTGroupGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.GSTGroupGet,sessionManagement);
  }

  Future<String> ItemMasterCreateFromCRM(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ItemMasterCreateFromCRM,sessionManagement);
  }

}