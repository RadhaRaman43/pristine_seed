
import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class EmpMarkLeaveRequestRepository{
  final _apiService=NetworkApiServices();
  Future<String> employeeLeaveDataGetApihit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveRequestDataGet,sessionManagement);
  }
  Future<String> leaveTypeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.leaveTypesGet,sessionManagement);
  }

  Future<String> getShortLeave(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.shiftDetailsByEmailGet, sessionManagement,data);
  }

  Future<String> getAnnualHolidaysList(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getEmployeeHolidays, sessionManagement,data);
  }


  Future<String> EmployeeLeaveRequestDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.EmployeeLeaveRequestDelete,sessionManagement);
  }

  Future<String> empLeaveMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveRequestMark,sessionManagement);
  }

  Future<String> employeeLeaveRequestRejectApproveDataGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveRequestRejectApproveDataGet,sessionManagement);
  }

  Future<String> employeeLeaveRequestApproveRejectApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveRequestApproveReject,sessionManagement);
  }

  Future<String> clustersGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ClustersGetByEmail, sessionManagement, data);
  }

  Future<String> RegionsWithClusterFilterGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.RegionsWithClusterFilterGetByEmail, sessionManagement, data);
  }


}