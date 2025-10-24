import '../../../../network/network_api_service.dart';
import '../../../../reources/app_url/app_url.dart';
import '../../../../viewModel/SessionManagment/session_managment.dart';

class ContactMasterRepo{
  final _apiService=NetworkApiServices();

  Future<String> contactMstGetList(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstGet,sessionManagement);
  }
  Future<String> AccountMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountMstGet,sessionManagement);
  }
  Future<String> departmentGetInsert(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.DepartmentGetInsert,sessionManagement);
  }
  Future<String> ContactMstUploader(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstUploader,sessionManagement);
  }

  Future<String> DesignationGet(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.DesignationGet, sessionManagement, data);
  }

  Future<String> getMasterTypeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.getMasterType, sessionManagement, data);
  }

  Future<String> getAccountMasterGetByCodeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.AccountMstGetBuyCode, sessionManagement, data);
  }


  Future<String> getContactMstGetAllApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstGetAll,sessionManagement);
  }

  Future<String> ContactMstDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstDelete,sessionManagement);
  }


}