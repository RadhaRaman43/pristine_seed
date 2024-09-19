import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';
import 'package:http/http.dart' as http;

class ServiceInstallationRepository{
  final _apiService=NetworkApiServices();

  Future<String> serviceInstallationDashBoardApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceInstallationListData,sessionManagement);
  }
  Future<String> serviceInstallationDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceInstallationDetailsGet,sessionManagement);
  }
  Future<String> reasonMasterApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.reasonMasterGet,sessionManagement);
  }
  Future<String> itemDetailsApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.getApi( AppUrl.itemDetailsGet,sessionManagement,data,);
  }
  Future<String> item_noApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.itemNoGet,sessionManagement);
  }
  Future<String> reassignmentApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.reAssignment,sessionManagement);
  }
  Future<String> reScheduleApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.reSchedule,sessionManagement);
  }
  Future<String>serviceMarkVisitApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceMarkVisit,sessionManagement);
  }
  Future<String>serviceIndentListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentGet,sessionManagement);
  }
  Future<String>serviceOffsiteMarkCloserApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceOffSiteMarkClosure,sessionManagement);
  }
  Future<String>serviceIndentHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentHeaderCreate,sessionManagement);
  }

  Future<String>serviceIndentLineCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentLineCreate,sessionManagement);
  }
  Future<String> serviceIndentImageInsert(http.MultipartRequest clint_request,SessionManagement sessionManagement)async{
    return _apiService.postFormApiHttpClient(clint_request, sessionManagement);
  }
  Future<String>serviceIndentDeleteLineAndHeaderApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentLineAndHeader,sessionManagement);
  }
  Future<String>serviceIndentCompleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentHeader,sessionManagement);
  }


  Future<String>serviceIndentConsumerLineMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentConsumerLineMark,sessionManagement);
  }

  Future<String>serviceIndentConsumerHeaderMarkApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.serviceIndentConsumerHeaderMark,sessionManagement);
  }
  Future<String>serViceInstallationMarkCompletedApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.installationMarkCompleted,sessionManagement);
  }

}