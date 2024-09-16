import 'package:navigation_drawer_flutter/network/network_api_service.dart';

import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ServiceInventoryRepository{
  final _apiService=NetworkApiServices();

  Future<String> serviceInventoryGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data,AppUrl.serviceInventoryList,sessionManagement);
  }

  Future<String> serviceInventoryListViewApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data,AppUrl.serviceInventoryListview,sessionManagement);
  }






}