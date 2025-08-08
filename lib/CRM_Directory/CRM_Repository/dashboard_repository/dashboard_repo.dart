import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class DashboardRepo{
  final _apiService=NetworkApiServices();

  Future<String> callDashboardGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallDashboard,sessionManagement);
  }

  Future<String> callDashboardUserWiseDataApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallDashboardUserWiseData,sessionManagement);
  }

  Future<String> CallStatusMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallStatusMstGet,sessionManagement);
  }

  Future<String> EmployeeMamberGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeMemberGet,sessionManagement);
  }

  Future<String> getItemCategoryMstWithoutTaskIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ItemCategoryMstGet, sessionManagement, data);
  }

  Future<String> clustersGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ClustersGetByEmail, sessionManagement, data);
  }

  Future<String> RegionsWithClusterFilterGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.RegionsWithClusterFilterGetByEmail, sessionManagement, data);
  }

  Future<String> AccountMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountMstGet,sessionManagement);
  }


  Future<String> funnelDashboardGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.FunnelDashboardDataGet,sessionManagement);
  }

  Future<String> funnelDashboardUserWiseDataApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.FunnelDashboardDataGetByUser,sessionManagement);
  }

  Future<String> commitDashboardGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CommitDashboardDataGet,sessionManagement);
  }

  Future<String> commitDashboardUserWiseDataApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CommitDashboardUserWiseData,sessionManagement);
  }


}