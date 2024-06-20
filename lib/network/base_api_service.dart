import '../viewModel/SessionManagment/session_managment.dart';

abstract class BaseApiServices{
  Future<dynamic> getApi(String url,SessionManagement sessionManagement,Map<String, String> queryParams);
  Future<dynamic> postApi(dynamic data, String url,SessionManagement sessionManagement);
}