import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/indent_list_model/indent-list_model.dart';
import '../../models/indent_list_model/indent_list_details_model.dart';
import '../../repository/indent_list_repository/indent_list_repository.dart';
import '../../utils/app_utils.dart';

class IndentListViewModel extends GetxController{

  final _api=IndentListRepository();
  RxBool loading=false.obs;
  SessionManagement sessionManagement= SessionManagement();

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email="";

  RxList<IndentListModel> indent_list=<IndentListModel>[].obs;
  RxList<IndentListHeaderResponse> indent_header_details_list=<IndentListHeaderResponse>[].obs;

  var globle_search_controller = TextEditingController();
  var indent_status_controller = TextEditingController();
  var indent_no_controller = TextEditingController();
  var service_controller = TextEditingController();
  var date_controller = TextEditingController();

  var indent_serviceType_controller = TextEditingController();
  RxList<String> indent_status_list = <String>["Completed","Approved","Rejected","Ready For Consumption","Received"].obs;
  RxList<String> service_type_list = <String>["Installation","Corrective","Preventive"].obs;

  @override
  void onInit() async{
    email=await sessionManagement.getEmail()??"";
    GetIndentList(pageNumber);

  }

  GetIndentList(int page_no,{String global_search=""}) {
    Map data;
    if(global_search!=null && global_search.isNotEmpty && global_search!=""){
        data = {
        "indent_status": "",
        "service_type": "",
        "filter_item_no_or_cust_no_or_service_no": global_search,
        "indent_no": "",
        "service_no": "",
        "indent_date": "",
        "email_id":email,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
    }else{
      data = {
        "indent_status": indent_status_controller.text,
        "service_type": indent_serviceType_controller.text,
        "filter_item_no_or_cust_no_or_service_no": "",
        "indent_no":indent_no_controller.text,
        "service_no": service_controller.text,
        "indent_date": date_controller.text,
        "email_id":email,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
    }

    print(data);
    loading.value = true;
    try {
      _api.indentListApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentListModel> response =
            JsonResponse.map((e) => IndentListModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {

              if(page_no==0){
                indent_list.clear();
              }
              indent_list.addAll(response);
              total_rows=indent_list[0].totalCount!;
            } else {
              Utils.showErrorToastification("Error!", response[0].message.toString());
            }
          } else {
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      ).whenComplete(() {
        loading.value = false;

      },);
    } catch (e) {
      print(e);
    }finally{
      loading.value = false;
    }
  }

  IndentHeaderCreateApi(String indent_no,String id) {
    Map data = {
      "service_id":id ,
      "indent_no": indent_no,
      "indent_type": "",
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.indentListDetailsApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentListHeaderResponse> response =
            JsonResponse.map((e) => IndentListHeaderResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_header_details_list.value=response;
              Get.toNamed(RoutesName.indentListDetailsscreen);
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError((error, stackTrace) {
              loading.value = false;
          print(error);
        },
      ).whenComplete(() {
        loading.value = false;
      },);
    } catch (e) {
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }

  }

}