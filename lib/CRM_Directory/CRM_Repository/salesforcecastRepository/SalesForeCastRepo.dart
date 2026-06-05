import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class SalesForeCastRepo{
  final _apiService=NetworkApiServices();

  Future<String> SalesForecastHeaderGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastHeaderGet,sessionManagement);
  }
  Future<String> QuoteHeaderGetForSalesForecast(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.QuoteHeaderGetForSalesForecast,sessionManagement);
  }

  Future<String> RegionsWithClusterFilterGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.RegionsWithClusterFilterGetByEmail, sessionManagement, data);
  }
  Future<String> clustersGetByEmailApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ClustersGetByEmail, sessionManagement, data);
  }
}