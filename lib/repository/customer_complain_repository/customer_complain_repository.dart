import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class CustomerComplainRepository{
  final _apiService=NetworkApiServices();

  Future<String> getCustomerComplainApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.servicePreventiveListData,sessionManagement);
  }
  Future<String> reasonMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveReasonMasterGet,sessionManagement);
  }
  Future<String> customerRaiseComplainApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.customerRaiseComplain,sessionManagement);
  }

  Future<String> getAllComplainApi(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.getAllComplain,sessionManagement);
  }


  Future<String> serviceCorrectiveListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveListData,sessionManagement);
  }

  Future<String> getServiceComplainAddFilter(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.getServiceComplainAddFilter,sessionManagement);
  }

  Future<String> getServiceComplainAddList(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.getServiceComplainAddList,sessionManagement);
  }
}