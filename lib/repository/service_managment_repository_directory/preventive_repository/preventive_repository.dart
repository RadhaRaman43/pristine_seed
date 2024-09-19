import 'package:navigation_drawer_flutter/network/network_api_service.dart';

import 'package:http/http.dart' as http;

import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class PreventiveRepository {
  final _apiService=NetworkApiServices();
  Future<String> serviceCorrectiveListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveListData,sessionManagement);
  }

  Future<String> servicePreventiveDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.servicePreventiveDetailsGet,sessionManagement);
  }
  Future<String> preventiveReasonMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveReasonMasterGet,sessionManagement);
  }

  Future<String>serviceIndentListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentGet,sessionManagement);
  }

  Future<String>serviceMarkVisitApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceMarkVisit,sessionManagement);
  }

  Future<String> reassignmentApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveReAssignment,sessionManagement);
  }
  Future<String> reScheduleApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.reSchedule,sessionManagement);
  }



  Future<String>serviceIndentHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentHeaderCreate,sessionManagement);
  }

  Future<String> serviceIndentImageInsert(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }

  Future<String>serVicePreventiveMarkCompletedApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveMarkCompleted,sessionManagement);
  }


  Future<String> item_noApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveItemNoGet,sessionManagement);
  }

  Future<String>serviceIndentConsumerLineMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentConsumerLineMark,sessionManagement);
  }
  Future<String>serviceIndentLineCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentLineCreate,sessionManagement);
  }


  Future<String>serviceIndentDeleteLineAndHeaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentLineAndHeader,sessionManagement);
  }

  Future<String>serviceIndentConsumerHeaderMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentConsumerHeaderMark,sessionManagement);
  }

  Future<String>serviceIndentCompleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveServiceIndentHeader,sessionManagement);
  }


  Future<String>createPreventiveCalenderCallApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.createPreventiveCalender,sessionManagement);
  }

  Future<String>createPreventiveCallApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.createPreventiveCall,sessionManagement);
  }

  Future<String> itemDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi( AppUrl.PreventiveitemDetailsGet,sessionManagement,data,);
  }




  Future<String>serviceOffsiteMarkCloserApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.preventiveOffSiteMarkClosure,sessionManagement);
  }

}