import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class AddressConsigneeRepo{
  final _apiService=NetworkApiServices();

  Future<String> ConsigneeAddMstUploader(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ConsigneeMstUploader,sessionManagement);
  }

  Future<String> ConsigneeAddMstGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ConsigneeMstGet,sessionManagement);
  }

  Future<String> GeoGetPincodeHierarchy(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.GeoGetPincodeHierarchy,sessionManagement);
  }

  Future<String> PincodeMasterGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.PincodeMasterGet,sessionManagement);
  }
}