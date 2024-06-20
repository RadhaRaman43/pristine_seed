import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class CollectionRepository{
  final _apiService=NetworkApiServices();
   Future<String> getCollectionApiHit(var data,SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.getCollectionList, sessionManagement, data);
  }

}