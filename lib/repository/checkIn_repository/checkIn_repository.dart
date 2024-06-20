import 'package:navigation_drawer_flutter/network/network_api_service.dart';
import 'package:http/http.dart' as http;
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class CheckInRepository {
  final _apiServices=NetworkApiServices();

  Future<String> vehileTypeGetInsert(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.vehileTypeGetInsert, sessionManagement);
  }

  Future<String> currentRunningCheckInDataApiHit(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.currentRunningCheckInData, sessionManagement);
  }
  Future<String> getVehicleDetails(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.getVehicleDetails, sessionManagement);
  }

  Future<String> getEmployeeMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data, AppUrl.get_employee_master,sessionManagement);
  }

  Future<String> SubmitCheckinpostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiServices.postFormApiHttpClient(clint_request,sessionManagement);
  }


  Future<String> SubmitCheckOutpostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiServices.postFormApiHttpClient(clint_request,sessionManagement);
  }

  Future<String> checkOutComplete(var data,SessionManagement sessionManagement)async{
    return _apiServices.postApi(data, AppUrl.checkOutComplete, sessionManagement);
  }

  Future<String> submitExpLinepostFormApi(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiServices.postFormApiHttpClient(clint_request,sessionManagement);
  }

}