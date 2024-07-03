import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class OrderRepository {
  final _apiService = NetworkApiServices();

  Future<String> orderHeaderListApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderGet, sessionManagement);
  }


  Future<String> orderDetailsApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderDetailsGet, sessionManagement);
  }
  Future<String> orderItemCategoryApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderItemCategoryGet, sessionManagement);
  }

  Future<String> orderItemApiHit(var data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderItemGet, sessionManagement);
  }

    Future<String> orderLineInsert(Map<String, String> data, SessionManagement sessionManagement) async {
     return _apiService.postApi(data, AppUrl.orderLineInsert, sessionManagement);
    }

  Future<String> orderHeaderComplete(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderComplete, sessionManagement);
  }

  Future<String> getCustomersApiHit(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.customerGet, sessionManagement);
  }
  Future<String> orderHeaderCreate(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderHeaderCreate, sessionManagement);
  }

  Future<String> getApprovelData(Map<String, String> data, SessionManagement sessionManagement) async {
    return _apiService.postApi(data, AppUrl.orderApprovalGet, sessionManagement);
  }

  Future<String> getConsignee(var data,SessionManagement sessionManagement)async{
    return _apiService.postApi(data, AppUrl.getConsigneeMstGet, sessionManagement);
  }





}


