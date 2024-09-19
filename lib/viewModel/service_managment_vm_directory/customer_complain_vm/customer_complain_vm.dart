import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_address_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_item_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_raise_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/complain_serial_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/filter_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/select_customer_complain_modal.dart';
import '../../../models/service_managment_model_directory/Customer_complain_modal/show_all_complain_modal.dart';
import '../../../models/service_managment_model_directory/reasonModel/reason_master_response.dart';
import '../../../models/service_managment_model_directory/serviceCorrectiveModel/service_corrective_list_model.dart';
import '../../../repository/service_managment_repository_directory/customer_complain_repository/customer_complain_repository.dart';
import '../../../utils/app_utils.dart';
import '../../SessionManagment/session_managment.dart';


class CustomerComplainVm extends GetxController {
 final _api = CustomerComplainRepository();
 SessionManagement sessionManagement = new SessionManagement();
 RxBool loading = false.obs;

 String email = "";

 int pageNumber = 0;
 int rowsPerPage =10;

 int total_rows = 0;

 RxInt is_done = 0.obs;
 RxString date_filter = "TODAY".obs;

 var service_no_search_controller = TextEditingController();
 var serial_no_search_controller = TextEditingController();
 var service_status_search_controller = TextEditingController();
 var item_no_search_controller = TextEditingController();
 var item_name_search_controller = TextEditingController();
 var customer_name_search_controller = TextEditingController();
 var addresse_search_controller = TextEditingController();
 var select_item_controller = TextEditingController();
 var select_serial_no_controller = TextEditingController();
 var select_date_controller = TextEditingController();


 var reason_code_controller = TextEditingController();
 var user_remark_controller = TextEditingController();

 RxBool isShowDocDropDown = true.obs;
 RxBool filter_color = false.obs;

 //RxList<CustomerComplainModal> customer_complain_details_list = <CustomerComplainModal>[].obs;
 RxList<ReasonModel> reason_master_list = <ReasonModel>[].obs;
 RxList<ComplainRaiseModal> raise_marker_list = <ComplainRaiseModal>[].obs;
 RxList<ShowAllComplainModal> all_complain_list = <ShowAllComplainModal>[].obs;

 RxList<SelectCustomerComplainModal> select_customer_list = <SelectCustomerComplainModal>[].obs;
 RxList<FilterModal> filter_list = <FilterModal>[].obs;
 RxList<ComplainAddressModal> address_list = <ComplainAddressModal>[].obs;
 RxList<ComplainItemModal> item_list = <ComplainItemModal>[].obs;
 RxList<ComplainSerialModal> serial_no_list = <ComplainSerialModal>[].obs;

 RxList<CorrectiveListResponse> complain_list = <CorrectiveListResponse>[].obs;


 @override
 void onInit() async {
  email = await sessionManagement.getEmail() ?? "";
  getComplainList(pageNumber, is_done.value, date_filter.value);
  getCompListFilter();
  //getCustomerComplainList();
  getReasonMaster("");
 }

 clearFilterOptions() {
  service_no_search_controller.clear();
  serial_no_search_controller.clear();
  service_status_search_controller.clear();
  item_no_search_controller.clear();
  customer_name_search_controller.clear();
  addresse_search_controller.clear();
  select_item_controller.clear();
  select_serial_no_controller.clear();
  select_date_controller.clear();
 }

 /*getCustomerComplainList() {
  Map data;
  data = {
   "customer_no_name": customer_name_search_controller.value.text.isEmpty
       ? ""
       : customer_name_search_controller.value.text,
   "email_id": email,
   "flag": "ComplainRaiseGetList",
   "is_done": 1,
   "item_no_name": item_no_search_controller.value.text.isEmpty
       ? ""
       : item_no_search_controller.text,
   "service_no": service_no_search_controller.value.text.isEmpty
       ? ""
       : service_no_search_controller.value.text,
   "serial_no": serial_no_search_controller.value.text.isEmpty
       ? ""
       : serial_no_search_controller.text,
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

      if (response != null && response.length > 0 &&
          response[0].condition == "True") {
       if (pageNumber == 0) {
        customer_complain_details_list.clear();
       }
       customer_complain_details_list.addAll(response);
       total_rows = customer_complain_details_list[0].totalcount!;
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
  finally {
   loading.value = false;
  }
 }*/

 Future<Iterable<ReasonModel>> getReasonMaster(String reason_code) async {
   if (reason_code == '') {
   return const Iterable<ReasonModel>.empty();
  }
  Map data = {
   "flag": "select",
   "reason_code": reason_code,
   "reason_type": "Installation",
   "reason_description": "",
   "created_by": email,
   "id": "",
  };
  print(data);
  loading.value = true;
  try {
   String value = await _api.reasonMasterApiHit(data, sessionManagement);
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
  } catch (e) {
   loading.value = false;
   reason_master_list.value = [];
   print(e);
  }
  return  reason_master_list.value;
 }

 raiseComplainApi(int id) {
  if (reason_code_controller.text.isEmpty) {
   Utils.sanckBarException("Error!", "Please Select Reason");
   return;
  }
  Map data = {
   "service_id": id,
   "reason_code": reason_code_controller.text,
   "user_remark": user_remark_controller.text,
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

      if (response != null && response.length > 0 &&
          response[0].condition == "True") {
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
  finally {
   loading.value = false;
  }
 }

 Future<void> refreshCorrectiveListData() async {
  // Implement your refresh logic here
  getComplainList(pageNumber, is_done.value, date_filter.value);
 }

 getComplainList(int page_no, int is_done, String date_filter) {
  Map data = {
   "customer_no_name": customer_name_search_controller.value.text.isEmpty
       ? ""
       : customer_name_search_controller.value.text,
   "date_filter": date_filter,
   "email_id": email,
   "flag": "WebUI",
   "is_done": is_done,
   "item_no_name": "",
   "page_number": page_no,
   "row_per_page": rowsPerPage,
   "serial_no": serial_no_search_controller.value.text.isEmpty
       ? ""
       : serial_no_search_controller.value.text,
   "service_no": service_no_search_controller.value.text.isEmpty
       ? ""
       : service_no_search_controller.value.text,
   "service_status": service_status_search_controller.value.text.isEmpty
       ? ""
       : service_status_search_controller.value.text,
   "service_type": "Corrective"
  };

  loading.value = true;
  //print("data value $data");
  try {
   _api.serviceCorrectiveListApiHit(data, sessionManagement).then(
        (value) {
     print(value);
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<CorrectiveListResponse> response = JsonResponse.map((e) =>
          CorrectiveListResponse.fromJson(e)).toList();
      if (response != null && response.length > 0 &&
          response[0].condition == "True") {
       loading.value = false;
       if (page_no == 0) {
        complain_list.clear();
       }
       complain_list.addAll(response);
       total_rows = complain_list[0].totalCount!;
      } else {
       loading.value = false;
       complain_list.value = [];
      }
     } else {
      loading.value = false;
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

 Future<Iterable<SelectCustomerComplainModal>> getSelectCustomerFilter(String customer_name, String flag) async {
  if (customer_name == '') {
   return const Iterable<SelectCustomerComplainModal>.empty();
  }
  Map data = {
   "flag": flag,
   "customer_filter": customer_name,
   "address_filter": "",
   "item_filter": "",
   "serial_filter": "",
   "email_id": email
  };
  print(data);
  loading.value = true;
  try {
   String select_customer_filter = await _api.getServiceComplainAddFilter(data, sessionManagement);

   final JsonResponse = json.decode(select_customer_filter);
   if (JsonResponse is List) {
    List<SelectCustomerComplainModal> response =
    JsonResponse.map((e) => SelectCustomerComplainModal.fromJson(e)).toList();
    if (response != null &&
        response.length > 0 &&
        response[0].condition == "True") {
     loading.value = false;
     select_customer_list.value = response;
    } else {
     loading.value = false;
     select_customer_list.value = [];
    }
   } else {
    loading.value = false;
    select_customer_list.value = [];

    Utils.sanckBarException("Api Error!", JsonResponse);
   }
  } catch (e) {
   loading.value = false;
   select_customer_list.value = [];
   print(e);
  }
  return  select_customer_list.value;
 }

 Future<Iterable<ComplainAddressModal>>
 getSelectAddressFilter(String address)  async{
  Map data = {
   "flag": "Address",
   "customer_filter": customer_name_search_controller.value.text,
   "address_filter": address,
   "item_filter": "",
   "serial_filter": "",
   "email_id": email
  };
  print("address data ${data}");
  loading.value = true;
  try {
   String value = await _api.getServiceComplainAddFilter(data, sessionManagement);
   print(value);
   final JsonResponse = json.decode(value);
   if (JsonResponse is List) {
    List<ComplainAddressModal> response = JsonResponse.map((e) =>
        ComplainAddressModal.fromJson(e)).toList();
    if (response != null && response.length > 0 &&
        response[0].condition == "True") {
     loading.value = false;
     address_list.value = response;

    } else {
     loading.value = false;
     address_list.value = [];
    }
   } else {
    loading.value = false;
    address_list.value = [];
   }

  } catch (e) {
   loading.value = false;
   address_list.value = [];
   print(e);
  }
  return address_list.value;
 }

 Future<Iterable<ComplainItemModal>>  getSelectItemFilter(String item_no) async {
  Map data = {
   "flag": "Item",
   "customer_filter": customer_name_search_controller.value.text,
   "address_filter": addresse_search_controller.value.text,
   "item_filter": item_no,
   "serial_filter": "",
   "email_id": email
  };
  print("Item data ${data}");
  loading.value = true;
  try {
   String value = await _api.getServiceComplainAddFilter(data, sessionManagement);
   print(value);
   final JsonResponse = json.decode(value);
   if (JsonResponse is List) {
    List<ComplainItemModal> response = JsonResponse.map((e) =>
        ComplainItemModal.fromJson(e)).toList();
    if (response != null && response.length > 0 &&
        response[0].condition == "True") {
     loading.value = false;
     item_list.value = response;

    } else {
     loading.value = false;
     item_list.value = [];
    }
   } else {
    loading.value = false;
    item_list.value = [];
   }

  } catch (e) {
   loading.value = false;
   item_list.value = [];
   print(e);
  }
  return item_list.value;
 }
 Future<Iterable<ComplainSerialModal>> getSelectSerialNoFilter(String serial_no) async {
  Map data = {
   "flag": "Serial",
   "customer_filter": customer_name_search_controller.value.text,
   "address_filter": addresse_search_controller.value.text,
   "item_filter": select_item_controller.value.text,
   "serial_filter": serial_no,
   "email_id": email
  };
  print("address data ${data}");
  loading.value = true;
  try {
   String value =await _api.getServiceComplainAddFilter(data, sessionManagement);
   print(value);
   final JsonResponse = json.decode(value);
   if (JsonResponse is List) {
    List<ComplainSerialModal> response = JsonResponse.map((e) =>
        ComplainSerialModal.fromJson(e)).toList();
    if (response != null && response.length > 0 &&
        response[0].condition == "True") {
     loading.value = false;
     serial_no_list.value = response;

    } else {
     loading.value = false;
     serial_no_list.value = [];
    }
   } else {
    loading.value = false;
    serial_no_list.value = [];
   }

  } catch (e) {
   loading.value = false;
   serial_no_list.value = [];
   print(e);
  }
  return serial_no_list.value;

 }

 getCompListFilter() {
  if(select_date_controller.value.text.isNotEmpty){

  }
  Map data = {
   "customer_filter": customer_name_search_controller.value.text,
   "address_filter": addresse_search_controller.value.text,
   "item_filter": select_item_controller.value.text,
   "installation_date_filter": select_date_controller.value.text,
   "serial_filter": select_serial_no_controller.value.text,
   "email_id": email,
   "row_per_page": rowsPerPage,
   "page_number": pageNumber
  };
  print("data value $data");
  loading.value = true;
  try {
   _api.getServiceComplainAddList(data, sessionManagement).then(
        (value) {
     print(value);
     final JsonResponse = json.decode(value);
     if (JsonResponse is List) {
      List<FilterModal> response =
      JsonResponse.map((e) => FilterModal.fromJson(e)).toList();
      if (response != null &&
          response.length > 0 &&
          response[0].condition == "True") {
       loading.value = false;
       if (pageNumber == 0) {
        filter_list.clear();
       }
       filter_list.addAll(response);
       total_rows = filter_list[0].totalcount!;
      } else {
       Utils.sanckBarException("data!", "No Record Found");
       loading.value = false;
       filter_list.value = [];
      }
     } else {
      loading.value = false;
      filter_list.value = [];

      Utils.sanckBarException("Api Error!", JsonResponse);
     }
    },
   ).onError(
        (error, stackTrace) {
     print(error);
     filter_list.value= [];
    },
   );
  } catch (e) {
   loading.value = false;
   filter_list.value = [];
   print(e);
  }
 }

}