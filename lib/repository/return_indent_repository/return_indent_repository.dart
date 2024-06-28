import '../../network/network_api_service.dart';
import '../../reources/app_url/app_url.dart';
import '../../viewModel/SessionManagment/session_managment.dart';

class ReturnIndentRepository{
  final _apiServices=NetworkApiServices();

  Future<String> returnIndentLocationApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.getApi( AppUrl.getReturnLocation,sessionManagement,data);
  }


  Future<String> returnIndentHeaderCreateApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentHeaderCreate,sessionManagement);
  }

  Future<String> returnIndentListApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentList,sessionManagement);
  }


  Future<String> returnIndentItemApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentItemWise,sessionManagement);
  }


  Future<String> returnIndentAddLineApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentAddLine,sessionManagement);
  }

  Future<String> returnIndentLineDeleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentLineDelete,sessionManagement);
  }


  Future<String> returnIndentHeaderDeleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentHeaderDelete,sessionManagement);
  }


  Future<String> returnIndentHeaderCompleteApiHit(var data,SessionManagement sessionManagement) async{
    return _apiServices.postApi(data,AppUrl.returnIndentHeaderComplete,sessionManagement);
  }










}