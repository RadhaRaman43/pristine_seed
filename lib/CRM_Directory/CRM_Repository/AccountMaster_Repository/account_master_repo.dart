import 'package:http/http.dart' as http;
import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class AccountMasterRepo {
  final _apiService=NetworkApiServices();

  Future<String> AccountMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountMstGet,sessionManagement);
  }

  Future<String> getMasterTypeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.getMasterType, sessionManagement, data);
  }

  Future<String> EmployeeMamberGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeMemberGet,sessionManagement);
  }

  Future<String> CompanyProfileMsGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CompanyProfileMstGet,sessionManagement);
  }

  Future<String> CompanyTypeMsGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CompanyTypeMstGet,sessionManagement);
  }

  Future<String> getStateMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.GetStateList, sessionManagement, data);
  }

  Future<String> getAccountMasterGetByCodeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.AccountMstGetBuyCode, sessionManagement, data);
  }

  Future<String> getTatResponseMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.GetTatResponseList,sessionManagement);
  }

  Future<String> AccountMstUploaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountMstUploader,sessionManagement);
  }

  Future<String> DraftAccountMstGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.DraftAccountMstGet,sessionManagement);
  }

  Future<String> DraftAccountMstUploaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.DraftAccountMstUploader,sessionManagement);
  }

  Future<String> CompanyProfileMstUploaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CompanyProfileMstUploader,sessionManagement);
  }

  Future<String> AccountMstImageUploadApiHit(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }

  Future<String> contactMstGetList(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstGet,sessionManagement);
  }

  Future<String> ConsigneeAddMstGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ConsigneeMstGet,sessionManagement);
  }

  Future<String> AccountDashboardCount(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountDashboardCountGet,sessionManagement);
  }

  Future<String> AccountTaskHistory(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountTaskHistoryGet,sessionManagement);
  }

  Future<String> AccountDashboardDataGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountDashboardDataGet,sessionManagement);
  }

  Future<String> EmployeeGetDashBoardApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeGet,sessionManagement);
  }
}