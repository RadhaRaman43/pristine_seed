import 'package:navigation_drawer_flutter/network/network_api_service.dart';

import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ForgetPasswordRepository{
  final _apiService=NetworkApiServices();
  Future<String> forgotPassApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.forget_pass_url,sessionManagement);
  }

}