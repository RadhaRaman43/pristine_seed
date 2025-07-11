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

  Future<String> BusinessTourPlanHeaderDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanHeaderDelete,sessionManagement);
  }

  Future<String> BusinessTourPlanLineCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanLineCreate,sessionManagement);
  }

  Future<String> BusinessTourPlanLineDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanLineDelete,sessionManagement);
  }

  Future<String> BusinessTourPlanDetailsGet(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.BusinessTourPlanDetailsGet, sessionManagement,data);
  }

  Future<String> EmpMstEmailByGet(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.EmpMstEmailByGet, sessionManagement, data);
  }

  Future<String> BusinessTourTypeGet(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.BusinessTourTypeGet, sessionManagement, data);
  }

  Future<String> TourPlanDistrictApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanDistrictGet,sessionManagement);
  }

  Future<String> TourPlanAccountApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanAccountGet,sessionManagement);
  }

  Future<String> BusinessTourPlanContactsGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanContactsGet,sessionManagement);
  }


}