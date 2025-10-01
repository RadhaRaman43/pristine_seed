import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class TaskMasterRepo{
  final _apiService=NetworkApiServices();

  Future<String> TaskMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskMstGet,sessionManagement);
  }

  Future<String> TaskMstGetApprovalListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskMstGetApprovalList,sessionManagement);
  }



  Future<String> TaskMasterCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskMstCreate,sessionManagement);
  }

  Future<String> TaskMstApproveRejectApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskMstApproveReject,sessionManagement);
  }

  Future<String> TaskMstRejectReopenApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskMstRejectReopen,sessionManagement);
  }

  Future<String> AccountMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.AccountMstGet,sessionManagement);
  }

  Future<String> contactMstGetList(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ContactMstGet,sessionManagement);
  }

  Future<String> CallStatusMasterGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.CallStatusMstGet,sessionManagement);
  }

  Future<String> TaskDSARMstGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskDSARMstGet,sessionManagement);
  }

  Future<String> TaskDSARMstCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskDSARMstCreate,sessionManagement);
  }

  Future<String> getItemCategoryMstApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ItemCategoryMstGetByTaskId, sessionManagement, data);
  }

  Future<String> getItemCategoryInfraMstApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data,AppUrl.ItemCategoryMstGetByDocument, sessionManagement);
  }

  Future<String> getItemCategoryMstWithoutTaskIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ItemCategoryMstGet, sessionManagement, data);
  }

  Future<String> TaskSaleCatCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskSalesProductCategoryCreate, sessionManagement);
  }

  Future<String> taskMstInfraUpdateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.taskMstInfraUpdate, sessionManagement);
  }

  Future<String> SalesCycleMstGetByAccountCodeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesCycleMstGetByAccountCode, sessionManagement);
  }

  Future<String> EmpMstEmailByGet(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.EmpMstEmailByGet, sessionManagement, data);
  }

  Future<String> TaskPersonMstGetByTaskId(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data,AppUrl.TaskPersonMstGetByTaskId, sessionManagement);
  }

  Future<String> TaskPersonMstCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.taskPersonMstCreate, sessionManagement);
  }

  Future<String> EmployeeMamberGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.employeeMemberGet,sessionManagement);
  }
  Future<String> EmployeeMatserGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.get_employee_master,sessionManagement);
  }


}