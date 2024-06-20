import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ExpenseApproverRepository{
  final _apiService=NetworkApiServices();
  Future<String> getEmployeeTeam(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.employeeTeamMemberGet, sessionManagement);
  }
  Future<String> GetApproverData(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expense_approverData, sessionManagement);
  }
  Future<String> markApproveReject(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseMarkApprove, sessionManagement);
  }

  Future<String> expenseCreate(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.expenseCreate, sessionManagement);
  }
}