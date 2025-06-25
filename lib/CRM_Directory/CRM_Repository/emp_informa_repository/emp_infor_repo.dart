
import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class EmpInforRepository{
  final _apiService=NetworkApiServices();
  Future<String> employeeLeaveDataGetApihit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveDataGet,sessionManagement);
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
  Future<String> empLeaveMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeLeaveMark,sessionManagement);
  }

}