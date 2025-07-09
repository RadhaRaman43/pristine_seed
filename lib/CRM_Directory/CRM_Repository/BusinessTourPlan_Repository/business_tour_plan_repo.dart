import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class BusinessTourPlanRepo{
  final _apiService=NetworkApiServices();
  Future<String> businessPlanListGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.businessPlanListGet,sessionManagement);
  }

  Future<String> BusinessTourPlanHeaderCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanHeaderCreate,sessionManagement);
  }
}