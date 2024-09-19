import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
//import 'package:marquee/marquee.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import 'package:http/http.dart' as http;

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';


import '../../../models/service_managment_model_directory/reasonModel/reason_master_response.dart';
import '../../../models/service_managment_model_directory/serviceIndentModel/Item_no_model.dart';
import '../../../models/service_managment_model_directory/serviceIndentModel/service_indent_header_create_model.dart';
import '../../../models/service_managment_model_directory/serviceIndentModel/service_indent_header_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/item_details_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_installation_details_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_installation_list_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_offsite_closure_model.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../repository/service_managment_repository_directory/installation_repositiory/service_installation_repository.dart';

class InstallationViewModel extends GetxController {
  final _api = ServiceInstallationRepository();

  SessionManagement sessionManagement = SessionManagement();

  String email = "";

  RxBool loading = false.obs;

  final ImagePicker _picker = ImagePicker();
  RxString date_filter="TODAY".obs;

  RxList<ServiceInstallationListResponse> service_intallatallation_list =
      <ServiceInstallationListResponse>[].obs;

  RxList<ServiceInstallationDetails> service_installation_details_list =
      <ServiceInstallationDetails>[].obs;
  RxList<ServiceIndentHeaderResponse> service_indent_header_list = <ServiceIndentHeaderResponse>[].obs;
  RxList<IndentHeaderCreateResponse> service_indent_header_create_list = <IndentHeaderCreateResponse>[].obs;

  RxBool isExpand = true.obs;
  RxList<ReasonModel> reason_master_list = <ReasonModel>[].obs;
  RxList<ItemDetailsResponse> item_details_list = <ItemDetailsResponse>[].obs;

  RxList<ItemNoResponse> item_no_list = <ItemNoResponse>[].obs;

  RxList<String> indent_type_list = <String>["Self","Warehouse"].obs;




  RxString upLoadLocalImagesList = ''.obs;
  var reason_code_controller = TextEditingController();
  var reason_description_controller = TextEditingController();
  var reschdule_date_controller = TextEditingController();
  var reschdule_remark_controller = TextEditingController();
  var rechdule_reason_code_controller = TextEditingController();
  var image_description_controller = TextEditingController();
  var item_no_controller = TextEditingController();
  var quantity_controller = TextEditingController();
  var item_no_description_controller = TextEditingController();
  var discount_controller = TextEditingController();
  var consumer_quantity_controller=TextEditingController();
  var bad_quantity_controller=TextEditingController();
  var indent_remark_controller=TextEditingController();
  var globle_search_controller = TextEditingController();
  var customer_no_search_controller = TextEditingController();
  var serial_no_search_controller = TextEditingController();
  var item_no_search_controller = TextEditingController();
  var invoice_no_search_controller = TextEditingController();
  var invoice_date_search_controller = TextEditingController();
  var remain_quantity_controller=TextEditingController();
  var closure_remark_controller=TextEditingController();
  var indent_type_controller=TextEditingController();
  var unit_price_controller=TextEditingController();
  var paybal_amount_controller=TextEditingController();
  var indent_date_controller=TextEditingController();
  var item_price_controller=TextEditingController();


  RxBool isCheckBox = false.obs;


  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  RxBool is_Showindent=false.obs;
  RxBool is_indent_type_dropDown=false.obs;


  int id = 0;
  String reason_code = "";
  String item_no = "";
  double item_Qty = 0.0;

  RxDouble damage= 0.0.obs;
   int is_warrenty= 0;
   double unit_price= 0;

  RxInt is_done = 0.obs;

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;


  RxString capture_flag = ''.obs;

  RxString image_flag = "".obs;

  RxString image_description_flag = "".obs;

  RxString description="".obs;

  RxString screen_route_flag="".obs;

  void toggle() {
    isExpand.value = !isExpand.value;
  }

  Future<void> refreshIndentListData() async {
    // Implement your refresh logic here
    IndentHeaderListApi();
    getServiceInstallationDetails(id,"Refresh");
  }

  Future<void> InstallionListrefreshListData() async {
    // Implement your refresh logic here
    getServiceInstallationList(is_done.value, pageNumber,date_filter.value);
  }

  Future<void> refreshInstallationDetailsData() async {
    // Implement your refresh logic here
    getServiceInstallationDetails(id,"Refresh");
  }


  @override
  void onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    getServiceInstallationList(is_done.value, pageNumber,date_filter.value);
   // getReasonMaster();
    initCurrentLocationLatLant();
  }

  getServiceInstallationList(int is_done, int page_no,String date_filter,{String globle_search_value=""}) {
    var date=StaticMethod.convertDateFormat(invoice_date_search_controller.text);
    Map data;
    if(globle_search_value!=null && globle_search_value.isNotEmpty && globle_search_value!=""){
      print("fjdbfgjdb");
     data = {
        "flag":"GlobalFilterApp",
        "service_type": "Installation",
        "date_filter": date_filter,
        "service_no": globle_search_value,
        "service_status": "",
        "is_done": is_done,
        "email_id": email,
        "customer_no_name": "",
        "item_no_name": "",
        "serial_no": "",
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no
      };
    }else{
      print("3333333333");
      print(customer_no_search_controller.text);
      data = {
        "service_type": "Installation",
        "service_no": "",
        "date_filter": date_filter,
        "service_status": "",
        "is_done": is_done,
        "email_id": email,
       // "invoice_date":invoice_date_search_controller.value.text.isEmpty?"":invoice_date_search_controller.value.text,
        "invoice_date":date!.isEmpty?"":date,
        "customer_no_name": customer_no_search_controller.value.text.isEmpty?"":customer_no_search_controller.value.text,
        "item_no_name": item_no_search_controller.value.text.isEmpty?"":item_no_search_controller.text,
        "serial_no": serial_no_search_controller.value.text.isEmpty?"":serial_no_search_controller.text,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no
      };
    }

    loading.value = true;
    print(data);
    try {
      _api.serviceInstallationDashBoardApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceInstallationListResponse> response = JsonResponse.map(
                    (e) => ServiceInstallationListResponse.fromJson(e))
                .toList();

            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              if(page_no==0){
                service_intallatallation_list.clear();
              }
              service_intallatallation_list.addAll(response);
              total_rows=service_intallatallation_list[0].totalCount!;

            } else {
              loading.value = false;
              service_intallatallation_list.value = [];
            }
          } else {
            loading.value = false;
            service_intallatallation_list.value = [];
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

  getServiceInstallationDetails(int id, String flag) {
    print("flag........"+flag);
    Map data = {"service_id": id.toString(), "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.serviceInstallationDetailsApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceInstallationDetails> response =
            JsonResponse.map((e) => ServiceInstallationDetails.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_installation_details_list.value = response;
              if (flag != "Refresh") {
                Get.toNamed(RoutesName.installation_details_screen);
              }
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


  //todo search reason drop down........
/*
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
*/

  Future<Iterable<ReasonModel>> getSearchReasonMaster(String text) async {
    if (text == '') {
      return const Iterable<ReasonModel>.empty();
    }
    Map data = {
      "flag": "select",
      "reason_code": text,
      "reason_type": "Installation",
      "reason_description": "",
      "created_by": email,
      "id": "",
    };

    String reasondropdownresp =
    await _api.reasonMasterApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(reasondropdownresp);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<ReasonModel> response = jsonResponse
            .map((data) => ReasonModel.fromJson(data))
            .toList();
        if (response[0].condition == 'True') {
          print(jsonResponse);
          reason_master_list.value = response;
        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          reason_master_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        reason_master_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      reason_master_list.value= [];
    }
    return   reason_master_list.value;
  }

  getItemDetails() {
    Map<String, String> data = {
      'item_no': service_installation_details_list[0].itemNo.toString() ,
    };
    print(data);
    loading.value = true;
    try {
      _api.itemDetailsApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ItemDetailsResponse> response =
            JsonResponse.map((e) => ItemDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              item_details_list.value=response;
            } else {
              loading.value = false;

            }
          } else {
            loading.value = false;
            item_details_list.value=[];


            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          item_details_list.value=[];

        },
      );
    } catch (e) {
      loading.value = false;
      item_details_list.value=[];
      print(e);
    }
  }

  reAssignRequestApi(BuildContext context) {
    if(reason_code_controller.text.isEmpty){
      Utils.showErrorToastification("Message", "Please Select Reason Code");
      return ;
    }
    if(reason_description_controller.text.isEmpty){
      Utils.showErrorToastification("Message", "Please Enter Reason Remark");
      return ;
    }
    Map data = {
      "service_id": id,
      "reason_code": reason_code,
      "user_remark": reason_description_controller.text,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.reassignmentApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceInstallationDetails> response =
            JsonResponse.map((e) => ServiceInstallationDetails.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
             // service_installation_details_list.value = response;
              Utils.showToastification(
                  "Success!", response[0].message.toString());
              Navigator.pop(context);
              Get.offAllNamed(RoutesName.installation_screen);
               // getServiceInstallationDetails(id, "Refresh");
              // service_installation_details_list.value = response;
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            service_installation_details_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_installation_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_installation_details_list.value = [];
      print(e);
    }
  }
  reSchduleRequestApi(BuildContext context) {
    if(reason_code_controller.text.isEmpty){
      Utils.showErrorToastification("Message", "Please Select Reason Code");
      return;
    }if(reschdule_remark_controller.text.isEmpty){
      Utils.showErrorToastification("Message", "Please Enter Reschedule Remark");
      return;
    }
    Map data = {
      "service_id": id,
      "reschedule_datetime": reschdule_date_controller.text,
      "reason_code": reason_code,
      "user_remark": reschdule_remark_controller.text,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.reScheduleApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceInstallationDetails> response =
            JsonResponse.map((e) => ServiceInstallationDetails.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              reason_code_controller.clear();
              reschdule_date_controller.clear();
              reschdule_remark_controller.clear();
              Utils.showToastification(
                  "Success!", response[0].message.toString());
                  Navigator.pop(context);
              getServiceInstallationDetails(id, "Refresh");
            } else {
              loading.value = false;

              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_installation_details_list.value = [];

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          // service_installation_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  InstallationMarkVisitApi() {
    Map data = {"service_id": id, "user_remark": "", "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.serviceMarkVisitApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceInstallationDetails> response =
            JsonResponse.map((e) => ServiceInstallationDetails.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              IndentHeaderListApi();
              Get.toNamed(RoutesName.installation_mark_visit);
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            service_installation_details_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_installation_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_installation_details_list.value = [];
      print(e);
    }
  }

  IndentHeaderListApi() {
    Map data = {
      "service_id": id,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentListApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceIndentHeaderResponse> response =
            JsonResponse.map((e) => ServiceIndentHeaderResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_list.value = response;
            } else {
              loading.value = false;
              service_indent_header_list.value = [];

            /*  Utils.showErrorToastification(
                  "Error!", response[0].message.toString());*/

              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_list.value = [];
      print(e);
    }
  }

  MarkClosureApi() {
    Map data = {
        "service_id": id,
        "email_id": email,
        "reopen_remark":closure_remark_controller.text ,
        "request_current_status": "Completed"
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceOffsiteMarkCloserApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServiceOffsiteClosureResponse> response =
            JsonResponse.map((e) => ServiceOffsiteClosureResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Success!", response[0].message!);
              Get.offAllNamed(RoutesName.installation_screen);
            } else {
              loading.value = false;
                Utils.showErrorToastification(
                  "Error!", response[0].message!);

            }
          } else {
            loading.value = false;

            Utils.showExceptionToastification("Api Error!", JsonResponse);
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


  IndentHeaderCreateApi(String indent_no) {
    Map data = {
      "service_id": id,
      "indent_no": indent_no,
      "indent_type": indent_type_controller.text,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentHeaderCreateApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value = response;
              indent_type_controller.clear();
              is_Showindent.value=true;
              is_indent_type_dropDown.value=false;
              if(indent_no!="" ){
                is_Showindent.value=true;
                is_indent_type_dropDown.value=false;
               Get.toNamed(RoutesName.installation_Indent_view);
              }/*else{
                is_Showindent.value=true;
                is_indent_type_dropDown.value=false;
              }*/
              if(response[0].message!=null){
                Utils.showToastification(
                    "Success!", response[0].message.toString());
              }
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

  IndentLineCreate(String indent_no, BuildContext context) {
    if(item_no_controller.text.isEmpty){
      Utils.showErrorToastification("Message!", "Please Select Item Code");
      return;
    }
    if(quantity_controller.text.isEmpty){
      Utils.showErrorToastification("Message!", "Please Enter Quantity ");
      return;
    }
    if(discount_controller.text.isEmpty){
      discount_controller.text="0";
    }
    Map data = {
      "indent_no": indent_no,
      "item_no": item_no,
      "qty": quantity_controller.text,
      "is_customer_damage":isCheckBox.value==true?'1':"0",
      "unit_price": unit_price_controller.text,
      "email_id": email,
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentLineCreateApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
             item_no_controller.clear();
              item_no ="";
              item_Qty = 0;
              is_warrenty =0;
              unit_price = 0;
              service_indent_header_create_list.value = response;
              Navigator.pop(context);
              /*IndentHeaderCreateApi(
                  service_indent_header_create_list[0].indentNo!);*/
              Utils.showToastification(
                  "Success!", response[0].message.toString());
            } else {
              print(response[0].message);
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          Utils.showExceptionToastification("Api Error!", error.toString());
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_create_list.value = [];
      print(e);
    }
  }

  IndentHeaderLineDelete(String indent_no, String indent_line_no, String flag) {
    Map data = {
      "flag": flag == "HeaderDiscard" ? "HeaderDiscard" : "LineDiscard",
      "indent_no": indent_no,
      "indent_line_no": flag == "HeaderDiscard" ? -1 : indent_line_no,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentDeleteLineAndHeaderApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;

              if (flag == "HeaderDiscard") {
                print("if......" + flag);
                Get.toNamed(RoutesName.installation_mark_visit);
                IndentHeaderListApi();
              }
              service_indent_header_create_list.value = response;

              /*IndentHeaderCreateApi(
                  service_indent_header_create_list[0].indentNo!);*/
              Utils.showToastification(
                  "Success!", response[0].message.toString());
            } else {
              loading.value = false;
              service_indent_header_create_list.value = [];
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            service_indent_header_create_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_indent_header_create_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_create_list.value = [];
      print(e);
    }
  }

  IndentComplete(String indent_no) {
    Map data = {
      "indent_no": indent_no,
      "email_id": email,
      "reschedule_datetime": indent_date_controller.text
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentCompleteApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_date_controller.clear();
              //service_indent_header_create_list.value = response;
              IndentHeaderListApi();
              Get.toNamed(RoutesName.installation_mark_visit);
              Utils.showToastification("Success!", response[0].message.toString());
            } else {
              loading.value = false;
              Utils.showErrorToastification("Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.showExceptionToastification("Api Error!", JsonResponse);
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

  InstallationMarkComplete(String service_id) {
    if(indent_remark_controller.text.isEmpty){
      Utils.showErrorToastification("Message!", "Please Enter Remark");
      return;
    }
    Map data = {
      "service_id": service_id,
      "user_remark":indent_remark_controller.text,
      "visit_charges": "0",
      "from_latitude": currentLat.value,
      "from_longitude": currentLng.value,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serViceInstallationMarkCompletedApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_remark_controller.clear();
              getServiceInstallationList(is_done.value, pageNumber,date_filter.value);
              Get.toNamed(RoutesName.installation_screen);

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


  getItemNo() {
    Map data = {
      "indent_no": service_indent_header_create_list[0].indentNo,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.item_noApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ItemNoResponse> response =
            JsonResponse.map((e) => ItemNoResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              item_no_list.value = response;
            } else {
              loading.value = false;
              item_no_list.value = [];
            }
          } else {
            loading.value = false;
            item_no_list.value = [];

            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          item_no_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      item_no_list.value = [];
      print(e);
    }
  }

  Future<void> upLoadImageApi(BuildContext context) async {
    try {
      final server_uri = Uri.parse(AppUrl.installationCertificateImage);
      final clint_request = http.MultipartRequest('POST', server_uri);
      var fields = <String, String>{
        "service_id": id.toString(),
        "service_type": 'Installation',
        "document_type": image_flag.value,
        "email_id": email,
        "file_desc": description.isEmpty && description==null ?"":description.value,
        "capture_type":capture_flag.value
      };
      print(fields);
      clint_request.fields.addAll(fields);
        clint_request.files.add(await http.MultipartFile.fromPath(
            'files', upLoadLocalImagesList.toString()));
      loading.value = true;

      _api
          .serviceIndentImageInsert(clint_request, sessionManagement)
          .then((value) {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ServiceInstallationDetails> response_data = jsonResponse
              .map((data) => ServiceInstallationDetails.fromJson(data))
              .toList();

          if (response_data != null &&
              response_data.length > 0 &&
              response_data[0].condition == 'True') {
            loading.value = false;
            upLoadLocalImagesList.value = '';
            capture_flag.value="";
            Navigator.pop(context);
            getServiceInstallationDetails(id, "Refresh");

            Utils.sanckBarSuccess(
                'Message!', response_data[0].message.toString());
          } else {
            print("Errror.....${response_data[0].message}");
            loading.value = false;
            Navigator.of(context).pop();
            Utils.sanckBarError(
                'False Message!', response_data[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarException("Api Error!", jsonResponse);
          /*Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);*/
        }
      }).onError((error, stackTrace) {
        print("errorrrrrr.....${error}");
        print("stack......r.....${stackTrace}");
        loading.value = false;
        // Utils.sanckBarError('Error!', "Api Response Error");
      });
    } catch (e) {
      print(e);
    }
  }


  Future upLoadImage(BuildContext context) async {
   // var image = null;
    final XFile? image;
    try {
      image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      upLoadLocalImagesList.value=image!.path.toString();
      Navigator.of(context).pop();
      //showLineImagesPopup(context);
      imageDescriptionDialog(context);
    } catch (e) {
      //Utils.sanckBarError("Image Exception!", e.toString());
    }
  }


  Future upLoadGalleryImage(BuildContext context) async {
    var image = null;
    try {
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
      upLoadLocalImagesList.value=image.path.toString();
      Navigator.of(context).pop();
      //showLineImagesPopup(context);
      imageDescriptionDialog(context);
    } catch (e) {
      //Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  IndentConsumerLineApi(String indent_no,int line_no,) {
    Map data = {
      "indent_no": indent_no,
      "line_no":line_no ,
      "consume_qty":consumer_quantity_controller.text,
      "bad_qty":bad_quantity_controller.text,
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentConsumerLineMarkApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value=response;
              consumer_quantity_controller.clear();
              bad_quantity_controller.clear();

              Utils.showToastification("Success!", response[0].message!);
            } else {
              loading.value = false;
              Utils.showErrorToastification("Error!", response[0].message!);
            }
          } else {
            loading.value = false;
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_indent_header_create_list.value=[];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }


  IndentConsumerHeaderMarkApi(String indent_no) {
    Map data = {
      "indent_no": indent_no,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentConsumerHeaderMarkApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<IndentHeaderCreateResponse> response =
            JsonResponse.map((e) => IndentHeaderCreateResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value=response;
              IndentHeaderListApi();
          //    Get.toNamed(RoutesName.installation_screen);
              Utils.showToastification("Success!", response[0].message!);
            } else {
              loading.value = false;
              print(response);
              Utils.showErrorToastification("Error!", response[0].message!);
            }
          } else {
            loading.value = false;
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          service_indent_header_create_list.value=[];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }


  void showLineImagesPopup(BuildContext context) {
    List<FileList> dialog_file_list=[];
    if(image_flag.value=="Installation_Certificate"){
      dialog_file_list=service_installation_details_list[0].fileList!.where((element) => element.documentType!.toLowerCase()=='Installation_Certificate'.toLowerCase()).toList();
    }else if(image_flag.value=="Installation_Product"){
      dialog_file_list=service_installation_details_list[0].fileList!.where((element) => element.documentType!.toLowerCase()=='Installation_Product'.toLowerCase()).toList();
    }
    if(dialog_file_list.length>0){
      upLoadLocalImagesList.value=dialog_file_list[0].fileUrl!;
      description.value=dialog_file_list[0].fileDesc!;
    }else{
      print("image Blank......");
      upLoadLocalImagesList.value="";
      description.value="";
    }
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text(
                    'View Images',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cancel, color: AllColors.primaryDark1),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  color: AllColors.primaryliteColor,
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: false,
                  child: Container(
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          upLoadImage(context);
                        },
                        child: Column(
                          children: [
                            DottedBorder(
                              color: AllColors.primaryDark1,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8),
                              dashPattern: [20, 10, 20, 10],
                              child: Container(
                                width: size.height * 0.1,
                                height: size.height * 0.1,
                                child: Icon(Icons.camera_alt_outlined, color: AllColors.primaryDark1, size: size.height * 0.1),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Capture Image',
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Container(
                    width: size.width * .98,
                    height: size.height * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: AllColors.primaryliteColor, width: .5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: upLoadBigImageSection(),
                    ),
                  );
                }),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                          child: Divider(color: AllColors.primaryliteColor, height: 1),
                        ),
                        SizedBox(height: 10),
                        // Check if imageUrls is empty, display a message, else display images
                        dialog_file_list ==null && dialog_file_list!.length<=0
                            ? Center(
                          child:Text( 'No Images found',
                            style:GoogleFonts.poppins(
                                fontSize: AllFontSize.eighteen,
                                fontWeight: FontWeight.w700,
                                color: AllColors.primaryDark1
                            ),
                          ),
                        )
                            : Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:   dialog_file_list!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  upLoadLocalImagesList.value=dialog_file_list![index].fileUrl!;
                                  description.value=dialog_file_list![index].fileDesc!;
                                },
                                child: Container(
                                  width: 100,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blueGrey, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: upLoadImageSection(dialog_file_list![index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget upLoadImageSection(FileList? file_model_data) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.network(
          file_model_data!.fileUrl!.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );

  }
/*  Widget upLoadBigImageSection() {
      return Stack(
        children: [
          Positioned(
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child:Image.network(
                  upLoadLocalImagesList.value.toString(),
                fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
              ),

            ),
          ),

          Positioned(
           // bottom: 20,
            child: Obx(() {
              return  Visibility(
                visible: description.value.isEmpty || description.value==null || description.value=="" ?false:true ,
                child: Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(offset: Offset(0.0, 1.0),
                        color: Colors.black54,
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        spreadRadius:2
                      )
                    ],color: Colors.white60
                  ),
                  child:  Text(" "+description.value,style:  GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w700,
                      fontSize: AllFontSize.twenteetwo
                  ),),

                 *//* Row(
                    children: [
                      Text(" "+description.value,style:  GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.twenteetwo
                      ),),
                    ],
                  )*//*




                ),
              );
            },
              //child:
            ),
          )
        ],

      );
  }*/


  Widget upLoadBigImageSection() {
    return Stack(
      children: [
        Positioned(
          width: 400,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
              upLoadLocalImagesList.value.toString(),
              fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
            ),
          ),
        ),
        Positioned(
          // bottom: 20,
          child: Obx(() {
            return Visibility(
              visible: description.value.isNotEmpty,
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0.0, 1.0),
                      color: Colors.black54,
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 2,
                    )
                  ],
                  color: Colors.white60,
                ),
                child:Tooltip(
                  message: " " + description.value,
                  child: Text(" " + description.value,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w700,
                        fontSize: AllFontSize.twenteetwo),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  imageDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title:  Text(image_description_flag=="Certificate"?
            image_description_flag.value+" Details...":"Product Details...",
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content:Container(
            height: 280,
            child: Column(
              children: [
                TextFormField(
                  controller:image_description_controller,
                  //   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: image_description_flag.value=="Certificate"?
                    image_description_flag+" Description":"Product Description",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        //Navigator.of(context).pop();
                        description.value=image_description_controller.text;
                        upLoadImageApi(context);

                        // todo  Your onPressed logic...
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text('Ok',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],),

                Container(
                  width: 100,
                  height: 120,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueGrey, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child:Image.file(
                        File(upLoadLocalImagesList.toString()),
                        fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
                      ),

                    ),
                  ),
                ),

              ],
            ),
          ) ,
        );

      },
    );
  }


  initCurrentLocationLatLant()async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled && (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse)) {
      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLat.value=userLocation.latitude;
      currentLng.value=userLocation.longitude;
    }

  }


}
