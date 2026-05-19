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

  Future<String> BusinessTourPlanHeaderComplete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanHeaderComplete,sessionManagement);
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

  Future<String> BusinessTourPlanReport(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.BusinessTourPlanReport, sessionManagement, data);
  }

  Future<String> BusinessTourPlanApprovalGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourplanApprovalGet,sessionManagement);
  }

  Future<String> BusinessTourPlanApproveReject(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanApproveReject,sessionManagement);
  }

  Future<String> BusinessTourPlanAllLineGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanAllLineGet,sessionManagement);
  }

  Future<String> BusinessTourPlanDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourPlanDelete,sessionManagement);
  }

  Future<String> clustersGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ClustersGetByEmail, sessionManagement, data);
  }

  Future<String> RegionsWithClusterFilterGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.RegionsWithClusterFilterGetByEmail, sessionManagement, data);
  }
  Future<String> EmployeeMatserGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.get_employee_master,sessionManagement);
  }

  Future<String> RegionMasterGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.RegionMasterGet,sessionManagement);
  }

  Future<String> BusinessTourplanReportingManagerGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.BusinessTourplanReportingManagerGet,sessionManagement);
  }



}