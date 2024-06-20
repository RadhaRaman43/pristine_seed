import 'package:navigation_drawer_flutter/network/network_api_service.dart';

import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class CheckInApproverRepository{
  final _apiServices=NetworkApiServices();

  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }
  Future<String> GetApproverData(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.check_in_approverData, sessionManagement);
  }

  Future<String> currentRunningCheckInDataApiHit(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.currentRunningCheckInData, sessionManagement);
  }
  Future<String> markApproveReject(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.CheckInMarkApprove, sessionManagement);
  }
}