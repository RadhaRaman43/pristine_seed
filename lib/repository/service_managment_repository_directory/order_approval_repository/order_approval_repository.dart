

import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class OrderApprovalRepository{
  final _apiService=NetworkApiServices();

  Future<String> orderApprovalListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.orderApprovalGet,sessionManagement);
  }

  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }

  Future<String> orderDetailGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderCreate, sessionManagement);
  }

  Future<String> orderApproverLineInsert(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderApprovalLineUpdate, sessionManagement);
  }

  Future<String> markApproveReject(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.OrderMarkApprove, sessionManagement);
  }



}