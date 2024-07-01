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

}


