import 'package:navigation_drawer_flutter/network/network_api_service.dart';

import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';


class DashBoardRepository{
  final _apiService=NetworkApiServices();

  Future<String> serviceInstallationDashBoardApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceInstallationData,sessionManagement);
  }


  Future<String> EmployeeGetDashBoardApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeGet,sessionManagement);
  }




}