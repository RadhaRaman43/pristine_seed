import 'package:navigation_drawer_flutter/network/network_api_service.dart';
import 'package:http/http.dart' as http;

import '../../viewModel/SessionManagment/session_managment.dart';
class ProfileRepository{
  final _apiServices=NetworkApiServices();

  Future<String> uploadImage(http.MultipartRequest clint_request, SessionManagement sessionManagement) async{
    return _apiServices.postFormApiHttpClient(clint_request,sessionManagement);
  }


}