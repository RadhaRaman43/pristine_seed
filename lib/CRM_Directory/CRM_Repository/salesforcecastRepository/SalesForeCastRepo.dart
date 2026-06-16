import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class SalesForeCastRepo{
  final _apiService=NetworkApiServices();

  Future<String> SalesForecastHeaderGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastHeaderGet,sessionManagement);
  }
  Future<String> SalesForecastHeaderGetBySalesForecastId(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastHeaderGetBySalesForecastId,sessionManagement);
  }
  Future<String> QuoteHeaderGetNewApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.QuoteHeaderGetNew,sessionManagement);
  }
  Future<String> ParentItemCategoryMstGet(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ParentItemCategoryMstGet, sessionManagement, data);
  }
  Future<String> getItemCategoryMstWithoutTaskIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.ItemCategoryMstGet, sessionManagement, data);
  }
  Future<String> SalesForecastHeaderCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastHeaderCreate,sessionManagement);
  }
  Future<String> SalesForecastHeaderCompleted(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastHeaderCompleted,sessionManagement);
  }
  Future<String> SalesForecastAddQuoteItems(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastAddQuoteItems,sessionManagement);
  }
  Future<String> SalesForecastLinesGetForUpload(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastLinesGetForUpload,sessionManagement);
  }
  Future<String> SalesForecastUploadItem(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastUploadItem,sessionManagement);
  }
  Future<String> SalesForecastLinesGetNew(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesForecastLinesGetNew,sessionManagement);
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