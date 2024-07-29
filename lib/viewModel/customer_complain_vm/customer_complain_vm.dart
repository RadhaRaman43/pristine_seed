import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/Customer_complain_modal/complain_raise_modal.dart';
import '../../models/Customer_complain_modal/customer_complain_modal.dart';
import '../../models/Customer_complain_modal/show_all_complain_modal.dart';
import '../../models/reasonModel/reason_master_response.dart';
import '../../repository/customer_complain_repository/customer_complain_repository.dart';
import '../../utils/app_utils.dart';
import '../SessionManagment/session_managment.dart';

class CustomerComplainVm extends GetxController{
 final _api = CustomerComplainRepository();
  SessionManagement sessionManagement = new SessionManagement();
 RxBool loading = false.obs;

  String email = "";

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;

 var service_no_search_controller = TextEditingController();
 var serial_no_search_controller = TextEditingController();
 var item_no_search_controller = TextEditingController();
 var item_name_search_controller = TextEditingController();
 var customer_name_search_controller = TextEditingController();


 var reason_code_controller = TextEditingController();
 var user_remark_controller = TextEditingController();

 RxList<CustomerComplainModal> customer_complain_details_list = <CustomerComplainModal>[].obs;
 RxList<ReasonModel> reason_master_list = <ReasonModel>[].obs;
 RxList<ComplainRaiseModal> raise_marker_list = <ComplainRaiseModal>[].obs;
 RxList<ShowAllComplainModal> all_complain_list = <ShowAllComplainModal>[].obs;

  @override
  void onInit() async {
    email = await sessionManagement.getEmail() ?? "";

    getCustomerComplainList();
    getReasonMaster();

  }
 getCustomerComplainList() {
  Map data;
   data = {
    "customer_no_name": customer_name_search_controller.value.text.isEmpty?"":customer_name_search_controller.value.text,
    "email_id": email,
    "flag":"ComplainRaiseGetList",
    "is_done": 1,
    "item_no_name": item_no_search_controller.value.text.isEmpty?"":item_no_search_controller.text,
    "service_no": service_no_search_controller.value.text.isEmpty?"":service_no_search_controller.value.text,
    "serial_no": serial_no_search_controller.value.text.isEmpty?"":serial_no_search_controller.text,
    "service_status": "",
    "service_type": "Installation",
    "row_per_page": rowsPerPage,
    "page_number": pageNumber

   };

  loading.value = true;
  print(data);
  try {
   _api.getCustomerComplainApiHit(data, sessionManagement).then(
        (value) {
     print("value is ${value}");
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<CustomerComplainModal> response = JsonResponse.map(
              (e) => CustomerComplainModal.fromJson(e)).toList();

      if (response != null && response.length > 0 && response[0].condition == "True") {
       if(pageNumber==0){
        customer_complain_details_list.clear();
       }
       customer_complain_details_list.addAll(response);
       total_rows=customer_complain_details_list[0].totalcount!;
       print('total count ${customer_complain_details_list[0].totalcount}');

      } else {

       customer_complain_details_list.value = [];
      }
     } else {
      customer_complain_details_list.value = [];
     }
    },
   ).onError(
        (error, stackTrace) {
     print(error);
    },
   );
  } catch (e) {
   print(e);
  }
  finally{
   loading.value = false;
  }
 }

 getReasonMaster() {
  Map data = {
   "flag": "select",
   "reason_code": "",
   "reason_type": "Installation",
   "reason_description": "",
   "created_by": email,
   "id": "",
  };
  print(data);
  loading.value = true;
  try {
   _api.reasonMasterApiHit(data, sessionManagement).then(
        (value) {
     print(value);
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<ReasonModel> response =
      JsonResponse.map((e) => ReasonModel.fromJson(e)).toList();
      if (response != null &&
          response.length > 0 &&
          response[0].condition == "True") {
       loading.value = false;
       reason_master_list.value = response;
      } else {
       loading.value = false;
       reason_master_list.value = [];
      }
     } else {
      loading.value = false;
      reason_master_list.value = [];

      Utils.sanckBarException("Api Error!", JsonResponse);
     }
    },
   ).onError(
        (error, stackTrace) {
     print(error);
     reason_master_list.value = [];
    },
   );
  } catch (e) {
   loading.value = false;
   reason_master_list.value = [];
   print(e);
  }
 }

 raiseComplainApi(int id) {
   if(reason_code_controller.text.isEmpty){
    Utils.sanckBarException("Error!", "Please Select Reason");
    return;
   }
  Map data = {
   "service_id": id,
   "reason_code": reason_code_controller.text,
   "user_remark":user_remark_controller.text ,
   "email_id": email
  };
  print(data);
  loading.value = true;
  try {
   _api.customerRaiseComplainApiHit(data, sessionManagement).then(
        (value) {
     print(value);
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<ComplainRaiseModal> response =
      JsonResponse.map((e) => ComplainRaiseModal.fromJson(e)).toList();
      if (response != null &&
          response.length > 0 &&
          response[0].condition == "True") {
       Utils.sanckBarSuccess("Success!", "Complain Raise Successfully");
       user_remark_controller.clear();
       reason_code_controller.clear();
       loading.value = false;

      } else {
       loading.value = false;

      }
     } else {
      loading.value = false;


      Utils.sanckBarException("Api Error!", JsonResponse);
     }
    },
   ).onError(
        (error, stackTrace) {
     print(error);

    },
   );
  } catch (e) {
   loading.value = false;

   print(e);
  }
 }

 getAllComplain(int id) {
  Map data;
  data = {
   "installation_service_id": id,
   "email_id": email

  };

  loading.value = true;
  print(data);
  try {
   _api.getAllComplainApi(data, sessionManagement).then(
        (value) {
     print("value is ${value}");
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<ShowAllComplainModal> response = JsonResponse.map(
              (e) => ShowAllComplainModal.fromJson(e)).toList();

      if (response != null && response.length > 0 && response[0].condition == "True") {

       all_complain_list.value = response;

      } else {

       all_complain_list.value = [];
      }
     } else {
      all_complain_list.value = [];
     }
    },
   ).onError(
        (error, stackTrace) {
     print(error);
    },
   );
  } catch (e) {
   print(e);
  }
  finally{
   loading.value = false;
  }
 }
}