
import 'package:http/http.dart' as http;

import '../../../network/network_api_service.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';

class ServiceCorrectiveRepository{
  final _apiService=NetworkApiServices();


  Future<String> serviceCorrectiveListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveListData,sessionManagement);
  }



  Future<String> serviceCorrectiveDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveDetailsGet,sessionManagement);
  }

  Future<String>serviceMarkCorrectiveVisitApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveMarkVisit,sessionManagement);
  }

  Future<String>serviceCorrectiveIndentListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveIndentGet,sessionManagement);
  }


  Future<String>serviceCorrectiveIndentHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceCorrectiveIndentHeaderCreate,sessionManagement);
  }

  Future<String>serviceCorrectiveMarkCompletedApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveMarkCompleted,sessionManagement);
  }



  Future<String>itemDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi(AppUrl.serviceCorrectiveItemDetails,sessionManagement,data);
  }




  Future<String> serviceIndentImageInsert(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }


  Future<String>serviceIndentConsumerHeaderMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveIndentConsumerHeaderMark,sessionManagement);
  }

  Future<String>serviceIndentCompleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveIndentHeader,sessionManagement);
  }

  Future<String>serviceIndentDeleteLineAndHeaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveIndentLineAndHeader,sessionManagement);
  }

  Future<String> item_noApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveitemNoGet,sessionManagement);
  }

  Future<String>serviceIndentConsumerLineMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveIndentConsumerLineMark,sessionManagement);
  }


  Future<String>serviceIndentLineCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveIndentLineCreate,sessionManagement);
  }

  Future<String> reasonMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveReasonMasterGet,sessionManagement);
  }

  Future<String> reScheduleApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveReSchedule,sessionManagement);
  }
  Future<String> reassignmentApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveReAssignment,sessionManagement);
  }



  Future<String>serviceOffsiteMarkCloserApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.correctiveOffSiteMarkClosure,sessionManagement);
  }


}