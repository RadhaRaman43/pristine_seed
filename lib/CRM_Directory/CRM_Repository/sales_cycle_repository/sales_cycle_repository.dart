
import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class SalesCycleRepository{
  final _apiService=NetworkApiServices();
  Future<String> salesCycleMstGetApihit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.salesCycleMstGet,sessionManagement);
  }


  Future<String> salesCycleMstUpdateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.salesCycleMstUpdate,sessionManagement);
  }


  Future<String> salesCycleMstApproveRejectApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.salesCycleMstApproveReject,sessionManagement);
  }

  Future<String> quoteHeaderGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderGet,sessionManagement);
  }

  Future<String> quoteWonDataGetApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.QuoteWonDataGet,sessionManagement);
  }

  Future<String> quoteHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderCreate,sessionManagement);
  }

  Future<String> quoteHeaderDuplicateCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderDuplicateCreate,sessionManagement);
  }

  Future<String> quoteHeaderGetByQuoteIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderGetByQuoteId,sessionManagement);
  }

  Future<String> itemMstGetByQuoteIdApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.itemMstGetByQuoteId,sessionManagement);
  }


  Future<String> quoteLineCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteLineCreate,sessionManagement);
  }

  Future<String> quoteLineDuplicateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteLineDuplicate,sessionManagement);
  }
  Future<String> quoteLineDeleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteLineDelete,sessionManagement);
  }
  Future<String> quoteLineMarkRegretApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteLineMarkRegret,sessionManagement);
  }

  Future<String> quoteHeaderUpdateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderUpdate,sessionManagement);
  }

  Future<String> quoteHeaderMarkRegretApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteHeaderMarkRegret,sessionManagement);
  }


  Future<String> quoteSendForApprovalApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteSendForApproval,sessionManagement);
  }
  Future<String> quoteApproveRejectApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.quoteApproveReject,sessionManagement);
  }

  Future<String> TaskSaleCatCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.TaskSalesProductCategoryCreate, sessionManagement);
  }


  Future<String> getItemCategoryMstApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data,AppUrl.ItemCategoryMstGetByDocument, sessionManagement);
  }

  Future<String> taskSaleCatCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.QuoteSalesProductCategoryCreate, sessionManagement);
  }

  Future<String> UpdateBusinessTermsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.QuoteHeaderUpdateBusinessTerms, sessionManagement);
  }
 /* Future<String> getquoteReportApiHit(Map<String, String> data,SessionManagement sessionManagement) async {
    return _apiService.getApi(AppUrl.quotationReport, sessionManagement, data);
  }*/

  Future<String> getquoteReportApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.quotationReport, sessionManagement, data);
  }

  Future<String> specialPriceRequestReportApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.specialPriceRequestReport, sessionManagement, data);
  }

  Future<String> ConsigneeAddMstGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ConsigneeMstGet,sessionManagement);
  }

  Future<String> SaleCycleProductCategoryWiseAmtCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SaleCycleProductCategoryWiseAmtCreate,sessionManagement);
  }

  Future<String> SaleCycleProductCategoryWiseAmtDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SaleCycleProductCategoryWiseAmtDelete,sessionManagement);
  }


  Future<String> SaleCycleProductCategoryWiseAmtGet(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SaleCycleProductCategoryWiseAmtGet,sessionManagement);
  }

  Future<String> getMasterTypeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.getMasterType, sessionManagement, data);
  }

  Future<String> SalesCycleMstPurchaseByUpdate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesCycleMstPurchaseByUpdate,sessionManagement);
  }

  Future<String> SalesCycleProductGetBySalesCycleId(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesCycleProductGetBySalesCycleId,sessionManagement);
  }

  Future<String> SalesProductLineDelete(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesProductLineDelete,sessionManagement);
  }

  Future<String> SalesProductLineCreate(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesProductLineCreate,sessionManagement);
  }

  Future<String> ItemMstGetBySalesCycleId(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.ItemMstGetBySalesCycleId,sessionManagement);
  }

  Future<String> SalesCycleMstStatusChangeApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesCycleMstStatusChange,sessionManagement);
  }


  Future<String> SalesCycleMstUpdateSuspectApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.SalesCycleMstUpdateSuspect,sessionManagement);
  }



}