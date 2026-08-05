import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_drawer_flutter/models/service_managment_model_directory/servicePreventiveModel/amc_request_invoice_item_get_modal.dart';
import 'package:navigation_drawer_flutter/models/service_managment_model_directory/servicePreventiveModel/amc_request_invoice_modal.dart';

//import 'package:marquee/marquee.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import 'package:http/http.dart' as http;

import '../../../component/custome_confirm_dialog.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../models/service_managment_model_directory/reasonModel/reason_master_response.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_offsite_closure_model.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/createPreventiveCalenderModel.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/indent_header_line_create_model.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/item_details_model.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/preventive_item_no_moel.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/service_preventive_details_model.dart';
import '../../../models/service_managment_model_directory/servicePreventiveModel/service_preventive_list_model.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../repository/service_managment_repository_directory/preventive_repository/preventive_repository.dart';
import '../../../utils/app_utils.dart';

class PreventiveViewModel extends GetxController {
  final _api = PreventiveRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool btnloading = false.obs;
  RxInt is_done = 0.obs;
  RxString date_filter = "TODAY".obs;
  String email = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int id = 0;
  RxString image_description_flag = "".obs;
  RxBool isExpand = true.obs;
  String reason_code = "";
  RxString capture_flag = 'CAMERA'.obs;
  RxString description = "".obs;

  RxString image_flag = "".obs;
  RxString upLoadLocalImagesList = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Size size = Get.size;

  String item_no = "";
  RxBool isCheckBox = false.obs;
  int is_warrenty = 0;
  RxBool is_Showindent = false.obs;
  RxBool is_indent_type_dropDown = false.obs;
  double unit_price = 0;


  RxList<PreventiveItemNoResponse> item_no_list =
      <PreventiveItemNoResponse>[].obs;
  RxList<ServicePreventiveListResponse> service_preventive_list =
      <ServicePreventiveListResponse>[].obs;
  RxList<ServicePreventiveDetailsResponse> service_preventive_details_list =
      <ServicePreventiveDetailsResponse>[].obs;

  RxList<PreventiveIndentHeaderCreateResponse> service_indent_header_list =
      <PreventiveIndentHeaderCreateResponse>[].obs;

  //RxList<ServicePreventiveIndentHeaderResponse> service_indent_header_list = <ServicePreventiveIndentHeaderResponse>[].obs;
  RxList<PreventiveIndentHeaderCreateResponse>
      service_indent_header_create_list =
      <PreventiveIndentHeaderCreateResponse>[].obs;

  RxList<CreatePreventiveCalender> create_preventive_calender_list =
      <CreatePreventiveCalender>[].obs;

  RxList<ReasonModel> reason_master_list = <ReasonModel>[].obs;
  RxList<ReasonModel> action_taken_list = <ReasonModel>[].obs;

  RxList<PreventiveItemDetailsResponse> item_details_list =
      <PreventiveItemDetailsResponse>[].obs;

  RxList<AMCRequestInvoiceGetModal> amcRequestInvoiceList =
      <AMCRequestInvoiceGetModal>[].obs;

  RxList<AMCRequestInvoiceItemGetModal> amcRequestInvoiceItemNoList =
      <AMCRequestInvoiceItemGetModal>[].obs;
  RxList<String> indent_type_list = <String>["Self", "Warehouse"].obs;
  GoogleMapController? mapController;
   LatLng initialPosition =  LatLng(
    28.6139,
    77.2090,
  ); // Delhi

  var reason_code_controller = TextEditingController();
  var reason_description_controller = TextEditingController();
  var reschdule_date_controller = TextEditingController();
  var reschdule_remark_controller = TextEditingController();
  var indent_remark_controller = TextEditingController();
  var indent_visit_charge_controller = TextEditingController();
  var image_description_controller = TextEditingController();
  var item_no_controller = TextEditingController();
  var item_no_description_controller = TextEditingController();
  var consumer_quantity_controller = TextEditingController();
  var remain_quantity_controller = TextEditingController();
  var bad_quantity_controller = TextEditingController();
  var quantity_controller = TextEditingController();

  var warranty_visit_date_controller = TextEditingController();
  var warranty_visit_time_controller = TextEditingController();
  var globle_search_controller = TextEditingController();
  var customer_no_search_controller = TextEditingController();
  var serial_no_search_controller = TextEditingController();
  var item_no_search_controller = TextEditingController();
  var invoice_no_search_controller = TextEditingController();
  var invoice_date_search_controller = TextEditingController();
  var discount_controller = TextEditingController();
  var closure_remark_controller = TextEditingController();
  var unit_price_controller = TextEditingController();
  var indent_type_controller = TextEditingController();
  var paybal_amount_controller = TextEditingController();

  var indent_date_controller = TextEditingController();

  var item_price_controller = TextEditingController();
  var serialNoController = TextEditingController();
  var actionTakenController= TextEditingController();
  var problemIdentifiedController= TextEditingController();


  //todo add new preventive calender controller

  var amcRequestInvoiceNoController = TextEditingController().obs;
  final amcRequestInvoiceItemNoController = TextEditingController();
  var warrantyStartDateController = TextEditingController().obs;
  var warrantyEndDateController = TextEditingController().obs;
  var frequencyController = TextEditingController().obs;
  var pinCodeController = TextEditingController().obs;
  RxBool isShowInvoiceNo=true.obs;
  RxBool isShowItemNo=true.obs;
  RxInt invoiceKey = 0.obs;
  RxInt itemKey = 0.obs;
  RxString problem_Identified_des="".obs;
  RxString action_taken_des="".obs;

  RxString serviceNo="".obs;
  RxString selectedItemNo="".obs;

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  Timer? _debounce;

  @override
  void onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    getServicePreventiveList(is_done.value, pageNumber, date_filter.value);
    // getReasonMaster();
    initCurrentLocationLatLant();

    amcRequestInvoiceNoController.value.addListener(() {
      final query = amcRequestInvoiceNoController.value.text;
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 400), () {
        getAMCRequestInvoice(query);
      });
    });

  }




  void toggle() {
    isExpand.value = !isExpand.value;
  }

  Future<void> refreshPreventiveDetailsData() async {
    // Implement your refresh logic here
    getServicePreventiveDetails(id, "");
  }

  Future<void> refreshPreventiveListData() async {
    print("lmlkgnk");
    // Implement your refresh logic here
    getServicePreventiveList(is_done.value, pageNumber, date_filter.value);
  }

  Future<void> refreshIndentListData() async {
    // Implement your refresh logic here
    IndentHeaderListApi();
    getServicePreventiveDetails(id, "Refresh");
  }

  getServicePreventiveList(int is_done, int page_no, String date_filter,
      {String globle_search_value = ""}) {
    var date =
        StaticMethod.convertDateFormat(invoice_date_search_controller.text);
    Map data;
    if (globle_search_value != null &&
        globle_search_value!.isNotEmpty &&
        globle_search_value != "") {
      data = {
        "flag": "GlobalFilterApp",
        "service_type": "Preventive",
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
    } else {
      data = {
        "service_type": "Preventive",
        "date_filter": date_filter,
        "service_no": "",
        "service_status": "",
        "is_done": is_done,
        "email_id": email,
        // "invoice_date": invoice_date_search_controller.value.text.isEmpty ? "" : invoice_date_search_controller.value.text,
        "invoice_date": date!.isEmpty ? "" : date,
        "customer_no_name": customer_no_search_controller.value.text.isEmpty
            ? ""
            : customer_no_search_controller.value.text,
        "item_no_name": item_no_search_controller.value.text.isEmpty
            ? ""
            : item_no_search_controller.text,
        "serial_no": serial_no_search_controller.value.text.isEmpty
            ? ""
            : serial_no_search_controller.text,
        "row_per_page": rowsPerPage.toString(),
        "page_number": page_no
      };
    }

    loading.value = true;
    print(data);
    try {
      _api.serviceCorrectiveListApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServicePreventiveListResponse> response = JsonResponse.map(
                (e) => ServicePreventiveListResponse.fromJson(e)).toList();

            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              if (page_no == 0) {
                service_preventive_list.clear();
              }
              service_preventive_list.addAll(response);
              total_rows = service_preventive_list[0].totalCount!;
            } else {
              loading.value = false;
              service_preventive_list.value = [];
            }
          } else {
            loading.value = false;
            service_preventive_list.value = [];
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

/*  getItemNo() {
    Map data = {
     // "indent_no": service_indent_header_list[0].indentNo,
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
            List<PreventiveItemNoResponse> response =
                JsonResponse.map((e) => PreventiveItemNoResponse.fromJson(e))
                    .toList();
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
  }*/

  Future<Iterable<PreventiveItemNoResponse>> getItemNo(String text) async {
    if (text == '') {
      return const Iterable<PreventiveItemNoResponse>.empty();
    }
    Map data = {
      "indent_no": service_indent_header_create_list[0].indentNo,
      "email_id": email,
      "filter_item_no": text
    };

    String itemdropdownresp = await _api.item_noApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(itemdropdownresp);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<PreventiveItemNoResponse> response = jsonResponse
            .map((data) => PreventiveItemNoResponse.fromJson(data))
            .toList();
        if (response[0].condition == 'True') {
          print(jsonResponse);
          item_no_list.value = response;
        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          item_no_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        item_no_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      item_no_list.value = [];
    }
    return item_no_list.value;
  }

  getItemDetails() {
    Map<String, String> data = {
      'item_no': service_preventive_details_list[0].itemNo.toString(),
    };
    print(data);
    loading.value = true;
    try {
      _api.itemDetailsApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PreventiveItemDetailsResponse> response = JsonResponse.map(
                (e) => PreventiveItemDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              item_details_list.value = response;
            } else {
              loading.value = false;
            }
          } else {
            loading.value = false;
            item_details_list.value = [];

            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          item_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      item_details_list.value = [];
      print(e);
    }
  }

  MarkClosureApi() {
    Map data = {
      "service_id": id,
      "email_id": email,
      "reopen_remark": closure_remark_controller.text,
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
            List<ServiceOffsiteClosureResponse> response = JsonResponse.map(
                (e) => ServiceOffsiteClosureResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Success!", response[0].message!);
              Get.offAllNamed(RoutesName.corrective_screen);
            } else {
              loading.value = false;
              Utils.showErrorToastification("Error!", response[0].message!);
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
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              indent_date_controller.clear();
              //service_indent_header_create_list.value = response;
              IndentHeaderListApi();
              Get.toNamed(RoutesName.preventive_screen);
              Utils.showToastification(
                  "Success!", response[0].message.toString());
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

  IndentConsumerLineApi(
    String indent_no,
    int line_no,
  ) {
    Map data = {
      "indent_no": indent_no,
      "line_no": line_no,
      "consume_qty": consumer_quantity_controller.text,
      "bad_qty": bad_quantity_controller.text,
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentConsumerLineMarkApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value = response;
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
          service_indent_header_create_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  getServicePreventiveDetails(int id, String flag) {
    print("flag........" + flag);
    Map data = {"service_id": id.toString(), "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.servicePreventiveDetailsApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServicePreventiveDetailsResponse> response = JsonResponse.map(
                (e) => ServicePreventiveDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_preventive_details_list.value = response;
              if (flag != "Refresh") {
                Get.toNamed(RoutesName.preventive_details_screen);
              } else {
                print("mgkfngknk");
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

  //todo search reason drop down ....

/*  getReasonMaster() {
    Map data = {
      "flag": "select",
      "reason_code": "",
      "reason_type": "Preventive",
      "reason_description": "",
      "created_by": email,
      "id": "",
    };
    print(data);
    loading.value = true;
    try {
      _api.preventiveReasonMasterApiHit(data, sessionManagement).then(
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
  }*/

  Future<Iterable<ReasonModel>> getSearchReasonMaster(String text, String flagApiType) async {
    if (text == '') {
      return const Iterable<ReasonModel>.empty();
    }
    Map data = {
      "flag": "select",
      "reason_code": text,
      "reason_type": "Preventive",
      "reason_description": "",
      "sub_reason_type":flagApiType,
      "created_by": email,
      "id": "",
    };

    String reasondropdownresp =
        await _api.preventiveReasonMasterApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(reasondropdownresp);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<ReasonModel> response =
            jsonResponse.map((data) => ReasonModel.fromJson(data)).toList();
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
      reason_master_list.value = [];
    }
    return reason_master_list.value;
  }

  Future<Iterable<ReasonModel>> getActionTaken(String text, String flagApiType) async {
    if (text == '') {
      return const Iterable<ReasonModel>.empty();
    }
    Map data = {
      "flag": "select",
      "reason_code": text,
      "reason_type": "Preventive",
      "reason_description": "",
      "sub_reason_type":flagApiType,
      "created_by": email,
      "id": "",
    };

    String reasondropdownresp = await _api.preventiveReasonMasterApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(reasondropdownresp);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<ReasonModel> response =
        jsonResponse.map((data) => ReasonModel.fromJson(data)).toList();
        if (response[0].condition == 'True') {
          print(jsonResponse);
          action_taken_list.value = response;
        } else {
          action_taken_list.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        action_taken_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      action_taken_list.value = [];
    }
    return action_taken_list.value;
  }

  IndentLineCreate(String indent_no, BuildContext context) {
    if (item_no_controller.text.isEmpty) {
      Utils.showErrorToastification("Message!", "Please Select Item Code");
      return;
    }
    if (quantity_controller.text.isEmpty) {
      Utils.showErrorToastification("Message!", "Please Enter Quantity ");
      return;
    }
    if (discount_controller.text.isEmpty) {
      discount_controller.text = "0";
    }

    Map data = {
      "indent_no": indent_no,
      "item_no": item_no,
      "qty": quantity_controller.text,
      "is_customer_damage": isCheckBox.value == true ? '1' : "0",
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
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              item_no = "";
              is_warrenty = 0;
              unit_price = 0;
              unit_price_controller.clear();
              item_price_controller.clear();
              service_indent_header_create_list.value = response;

              Navigator.pop(context);
              /*IndentHeaderCreateApi(
                  service_indent_header_create_list[0].indentNo!);*/
              Utils.showToastification(
                  "Success!", response[0].message.toString());
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
          Utils.showExceptionToastification("Api Error!", error.toString());
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_list.value = [];
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
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              //
              if (flag == "HeaderDiscard") {
                print("if......" + flag);
                Get.toNamed(RoutesName.preventive_markvisit_screen);
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
              /*Utils.showErrorToastification(
                  "Error!", response[0].message.toString());*/
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

  IndentConsumerHeaderMarkApi(String indent_no) {
    Map data = {"indent_no": indent_no, "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentConsumerHeaderMarkApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value = response;
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
          service_indent_header_create_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  IndentHeaderListApi() {
    Map data = {"service_id": id, "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.serviceIndentListApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_list.value = response;
              print("ifnjngbh");
            } else {
              loading.value = false;
              print("else........");
              service_indent_header_list.value = [];
              /*Utils.showErrorToastification(
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

  PreventiveMarkVisitApi() {
    Map data = {"service_id": id, "user_remark": "", "email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.serviceMarkVisitApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServicePreventiveDetailsResponse> response = JsonResponse.map(
                (e) => ServicePreventiveDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              IndentHeaderListApi();
              Get.toNamed(RoutesName.preventive_markvisit_screen);
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            service_preventive_details_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          service_preventive_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_preventive_details_list.value = [];
      print(e);
    }
  }

  createPreventiveCalenderCallApi() {
    Map data = {"email_id": email};
    print(data);
    loading.value = true;
    try {
      _api.createPreventiveCalenderCallApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<CreatePreventiveCalender> response =
                JsonResponse.map((e) => CreatePreventiveCalender.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              create_preventive_calender_list.value = response;

            } else {
              loading.value = false;
              create_preventive_calender_list.value = [];
              /* Utils.showErrorToastification(
                  "Error!", "No Calender Date Found");*/
              //Utils.showErrorToastification("Error!", response[0].message!);
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_list.value = [];
      print(e);
    }
  }

  createPreventiveCallApi(
      String warranty_id, String service_id, String dateAndTime) {
    Map data = {
      "warranty_id": warranty_id,
      "service_id": service_id,
      "email_id": email,
      "service_tat_datetime": dateAndTime
    };
    print(data);
    loading.value = true;
    try {
      _api.createPreventiveCallApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<CreatePreventiveCalender> response =
                JsonResponse.map((e) => CreatePreventiveCalender.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              getServicePreventiveList(
                  is_done.value, pageNumber, date_filter.value);
              Utils.showToastification(
                  "Success!", response[0].message.toString());
              Get.offAllNamed(RoutesName.preventive_screen);
            } else {
              loading.value = false;

              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
              //service_installation_details_list.value=[];
            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          //service_indent_header_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_indent_header_list.value = [];
      print(e);
    }
  }

  reAssignRequestApi(BuildContext context) {
    if (reason_code_controller.text.isEmpty) {
      Utils.showErrorToastification("Message", "Please Select Reason Code");
      return;
    }
    if (reason_description_controller.text.isEmpty) {
      Utils.showErrorToastification("Message", "Please Enter Remark");
      return;
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
            List<ServicePreventiveDetailsResponse> response = JsonResponse.map(
                (e) => ServicePreventiveDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification(
                  "Success!", response[0].message.toString());
              Navigator.pop(context);
              Get.offAllNamed(RoutesName.preventive_screen);
              //  getServicePreventiveDetails(id, "Refresh");
              // service_installation_details_list.value = response;
            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error!", response[0].message.toString());
            }
          } else {
            loading.value = false;
            service_preventive_details_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          service_preventive_details_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      service_preventive_details_list.value = [];
      print(e);
    }
  }

  reSchduleRequestApi(BuildContext context) {
    if (reason_code_controller.text.isEmpty) {
      Utils.showErrorToastification("Message", "Please Select Reason Code");
      return;
    }
    if (reschdule_remark_controller.text.isEmpty) {
      Utils.showErrorToastification(
          "Message", "Please Enter Reschedule Remark");
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
            List<ServicePreventiveDetailsResponse> response = JsonResponse.map(
                (e) => ServicePreventiveDetailsResponse.fromJson(e)).toList();
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
              getServicePreventiveDetails(id, "Refresh");
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
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              service_indent_header_create_list.value = response;
              indent_type_controller.clear();
              is_Showindent.value = true;
              is_indent_type_dropDown.value = false;
              if (indent_no != "") {
                is_Showindent.value = true;
                is_indent_type_dropDown.value = false;
                Get.toNamed(RoutesName.preventive_Indent_header_view_screen);
              }

              if (response[0].message != null) {
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

  PreventiveMarkComplete(String service_id) {
    if (indent_remark_controller.text.isEmpty) {
      Utils.showErrorToastification("Message!", "Please Enter remark");
      return;
    }
    if(problemIdentifiedController.text.isEmpty){
      Utils.sanckBarError('Error', 'Action Taken can not be blank');
      return;
    }

    if(actionTakenController.text.isEmpty){
      Utils.sanckBarError('Error', 'Action Taken can not be blank');
      return;
    }
    Map data = {
      "service_id": service_id,
      "user_remark": indent_remark_controller.text,
      "visit_charges": indent_visit_charge_controller.text,
      "from_latitude": currentLat.value,
      "from_longitude": currentLng.value,
      "problem_reason_code": problemIdentifiedController.text,
      "problem_reason_desc": problem_Identified_des.value,
      "action_taken_reason_code": actionTakenController.text,
      "action_taken_reason_desc": action_taken_des.value,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serVicePreventiveMarkCompletedApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<PreventiveIndentHeaderCreateResponse> response =
                JsonResponse.map(
                        (e) => PreventiveIndentHeaderCreateResponse.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification(
                  "Success!", response[0].message.toString());
              indent_remark_controller.clear();
              getServicePreventiveList(
                  is_done.value, pageNumber, date_filter.value);
              Get.toNamed(RoutesName.preventive_screen);
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

  Future<void> upLoadImageApi(BuildContext context) async {
    if (image_description_controller.text.isEmpty) {
      Utils.showErrorToastification("Message", "Please Enter Description");
      return;
    }
    try {
      final server_uri = Uri.parse(AppUrl.preventiveCertificateImage);
      final clint_request = http.MultipartRequest('POST', server_uri);
      var fields = <String, String>{
        "service_id": id.toString(),
        "service_type": 'Preventive',
        "document_type": image_flag.value,
        "email_id": email,
        "file_desc": image_description_controller.text,
        "capture_type": capture_flag.value
      };
      clint_request.fields.addAll(fields);
      clint_request.files.add(await http.MultipartFile.fromPath(
          'files', upLoadLocalImagesList.toString()));
      loading.value = true;
      print(fields);

      _api
          .serviceIndentImageInsert(clint_request, sessionManagement)
          .then((value) {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ServicePreventiveDetailsResponse> response_data = jsonResponse
              .map((data) => ServicePreventiveDetailsResponse.fromJson(data))
              .toList();

          if (response_data != null &&
              response_data.length > 0 &&
              response_data[0].condition == 'True') {
            loading.value = false;
            upLoadLocalImagesList.value = '';
            capture_flag.value = 'CAMERA';
            Navigator.pop(context);
            getServicePreventiveDetails(id, "Refresh");

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
    var image = null;
    try {
      image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      upLoadLocalImagesList.value = image.path.toString();
      Navigator.of(context).pop();
      //showLineImagesPopup(context);
      imageDescriptionDialog(context);
    } catch (e) {
      //Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  imageDeleteApiHit(String image_id, BuildContext context) {
    Map data = {"service_id": id, "email_id": email, "image_id": image_id};
    print(data);
    loading.value = true;
    try {
      _api.serviceCorrectiveImageDeleteApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<ServicePreventiveDetailsResponse> response = JsonResponse.map(
                (e) => ServicePreventiveDetailsResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Success!", response[0].message!);
              getServicePreventiveDetails(id, "Refresh");
              Navigator.of(context).pop();
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
          service_indent_header_create_list.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  void showLineImagesPopup(BuildContext context) {
    List<FileList> dialog_file_list = [];
    if (image_flag.value == "Preventive_Certificate") {
      dialog_file_list = service_preventive_details_list[0]
          .fileList!
          .where((element) =>
              element.documentType!.toLowerCase() ==
              'Preventive_Certificate'.toLowerCase())
          .toList();
    } else if (image_flag.value == "Preventive_Product") {
      dialog_file_list = service_preventive_details_list[0]
          .fileList!
          .where((element) =>
              element.documentType!.toLowerCase() ==
              'Preventive_Product'.toLowerCase())
          .toList();
    }
    if (dialog_file_list.length > 0) {
      upLoadLocalImagesList.value = dialog_file_list[0].fileUrl!;
      description.value ="${dialog_file_list[0].fileDesc!} (${dialog_file_list[0].captureType})" ;

    } else {
      upLoadLocalImagesList.value = "";
      description.value = "";

      Get.toNamed(RoutesName.image_not_found_screen);
      return;
    }

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
                          icon:
                              Icon(Icons.cancel, color: AllColors.primaryDark1),
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
                          //upLoadImage(context);
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
                                child: Icon(Icons.camera_alt_outlined,
                                    color: AllColors.primaryDark1,
                                    size: size.height * 0.1),
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
                      border: Border.all(
                          color: AllColors.primaryliteColor, width: .5),
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
                          child: Divider(
                              color: AllColors.primaryliteColor, height: 1),
                        ),
                        SizedBox(height: 10),
                        // Check if imageUrls is empty, display a message, else display images
                        if (dialog_file_list == null &&
                                dialog_file_list!.length <= 0) Center(
                                child: Text(
                                  'No Images found',
                                  style: GoogleFonts.poppins(
                                      fontSize: AllFontSize.eighteen,
                                      fontWeight: FontWeight.w700,
                                      color: AllColors.primaryDark1),
                                ),
                              ) else Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dialog_file_list!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        upLoadLocalImagesList.value =
                                            dialog_file_list![index].fileUrl!;
                                        description.value =" ${ dialog_file_list![index].fileDesc??""}  (${dialog_file_list![index].captureType})"
                                          ;

                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.blueGrey,
                                                  width: 0.5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: upLoadImageSection(
                                                  dialog_file_list![index]),
                                            ),
                                          ),
                                          Visibility(
                                            visible: service_preventive_details_list[0].serviceStatus?.toLowerCase()!='completed',
                                            child: Positioned(
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  CustomConfirmDialog.showDialog(
                                                      context: context,
                                                      title: "Confirm",
                                                      content:
                                                          "Do You Want to continue",
                                                      onPress: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        imageDeleteApiHit(
                                                            dialog_file_list[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            context);
                                                      },
                                                      isLoading: loading);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          AllColors.primaryDark1),
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 18,
                                                    color: AllColors
                                                        .customDarkerWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                        // child:
                                      ),

                                      /* Container(
                                        width: 100,
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 0.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: upLoadImageSection(
                                              dialog_file_list![index]),
                                        ),
                                      ),*/
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
          child: Obx(
            () {
              return Visibility(
                visible: description.value.isNotEmpty,
                child: Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(0.0, 1.0),
                        color: Colors.black54,
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 2)
                  ], color: Colors.white60),
                  child: Tooltip(
                    message: description.value,
                    child: Text(
                      " " + description.value,
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.twenteetwo),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
            //child:
          ),
        )
      ],
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

  imageDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            image_description_flag.value == "Certificate"
                ? image_description_flag + " Details...."
                : "Product Details...",
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            height: 280,
            child: Column(
              children: [
                TextFormField(
                  controller: image_description_controller,
                  //   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: image_description_flag.value == "Certificate"
                        ? image_description_flag + " Description"
                        : "Product Description",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        //  Navigator.of(context).pop();
                        description.value = image_description_controller.text;
                        upLoadImageApi(context);

                        // todo  Your onPressed logic...
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok',
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
                  ],
                ),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.file(
                        File(upLoadLocalImagesList.toString()),
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to make the image fit
                      ),
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

  Future upLoadGalleryImage(BuildContext context) async {
    var image = null;
    try {
      image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 60);
      upLoadLocalImagesList.value = image.path.toString();
      Navigator.of(context).pop();
      //showLineImagesPopup(context);
      imageDescriptionDialog(context);
    } catch (e) {
      //Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  initCurrentLocationLatLant() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled &&
        (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse)) {
      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLat.value = userLocation.latitude;
      currentLng.value = userLocation.longitude;
    }
  }


  Future<List<AMCRequestInvoiceGetModal>> getAMCRequestInvoice(String text) async {
    try {
      Map<String, String> data = {"email_id": email, "invoice_no": text};

      String customer_response =await  _api.aMCRequestInvoiceGetApiHit(data, sessionManagement);
      final jsonResponse = json.decode(customer_response);
      if (jsonResponse is List) {
        print(jsonResponse);
        List<AMCRequestInvoiceGetModal> response =
        jsonResponse.map((data) => AMCRequestInvoiceGetModal.fromJson(data)).toList();
        if (response[0].condition?.toLowerCase() == 'true') {
          amcRequestInvoiceList.value = response;

        } else {
          amcRequestInvoiceList.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        amcRequestInvoiceList.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      amcRequestInvoiceList.value = [];
    }
    return  amcRequestInvoiceList.value;
  }

/*  getAMCRequestInvoice(String invoiceNo) {
    Map<String, String> data = {"email_id": email, "invoice_no": invoiceNo};
    print(data);
    loading.value = true;
    try {
      _api.aMCRequestInvoiceGetApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<AMCRequestInvoiceGetModal> response =
                JsonResponse.map((e) => AMCRequestInvoiceGetModal.fromJson(e))
                    .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              amcRequestInvoiceList.value = response;
            } else {
              loading.value = false;
            }
          } else {
            loading.value = false;
            amcRequestInvoiceList.value = [];

            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          amcRequestInvoiceList.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      amcRequestInvoiceList.value = [];
      print(e);
    }
  }*/


  Future<void> getAMCRequestInvoiceItemNo(String invoiceNo) async {
    amcRequestInvoiceItemNoList.clear();
    Map<String, String> data = {
      "email_id": email,
      "invoice_no": invoiceNo
    };
    loading.value = true;
    try {
      final value =
      await _api.aMCRequestInvoiceWiseItemGetApiHit(
          data, sessionManagement);
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<AMCRequestInvoiceItemGetModal> response =
        jsonResponse
            .map((e) =>
            AMCRequestInvoiceItemGetModal.fromJson(e))
            .toList();
        if (response.isNotEmpty &&
            response[0].condition == "True") {
          amcRequestInvoiceItemNoList.clear();
          amcRequestInvoiceItemNoList.addAll(response);
        } else {
          amcRequestInvoiceItemNoList.clear();
        }
      } else {
        amcRequestInvoiceItemNoList.clear();
        Utils.sanckBarException("Api Error!", jsonResponse);
      }
    } catch (e) {
      amcRequestInvoiceItemNoList.clear();
      print(e);
    }
    loading.value = false;
  }

/*  getAMCRequestInvoiceItemNo(String invoiceNo) {
    amcRequestInvoiceItemNoList.value=[];
    Map<String, String> data = {"email_id": email, "invoice_no": invoiceNo};
    print(data);
    loading.value = true;
    try {
      _api.aMCRequestInvoiceWiseItemGetApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<AMCRequestInvoiceItemGetModal> response = JsonResponse.map(
                (e) => AMCRequestInvoiceItemGetModal.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              amcRequestInvoiceItemNoList.value = response;
            } else {
              loading.value = false;
            }
          } else {
            loading.value = false;
            amcRequestInvoiceItemNoList.value = [];
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
          amcRequestInvoiceItemNoList.value = [];
        },
      );
    } catch (e) {
      loading.value = false;
      amcRequestInvoiceItemNoList.value = [];
      print(e);
    }
  }*/

  void clearAllField() {
    amcRequestInvoiceItemNoController.clear();
    amcRequestInvoiceNoController.value.clear();
    warrantyStartDateController.value.clear();
    warrantyEndDateController.value.clear();
    frequencyController.value.clear();
    serviceNo.value="";
    selectedItemNo.value="";
   // amcRequestInvoiceItemNoList.value=[];
    isShowInvoiceNo.value=false;
    isShowInvoiceNo.value=true;
    isShowItemNo.value=false;
    isShowItemNo.value=true;
    invoiceKey.value++;
    itemKey.value++;
    pinCodeController.value.text="";

  }

  /*@override
  void onClose() {
    amcRequestInvoiceNoController.value.dispose();
    warrantyStartDateController.value.dispose();
    warrantyEndDateController.value.dispose();
    frequencyController.value.dispose();
    super.onClose();
  }*/

  getAMCRequestCreation() {
    Map<String, String> data = {
      "email_id": email,
      "service_no": serviceNo.value,
      "invoice_no": amcRequestInvoiceNoController.value.text,
      "item_no":selectedItemNo.value,
      "warranty_start_date": warrantyStartDateController.value.text,
      "warranty_end_date": warrantyEndDateController.value.text,
      "frequency_of_pm": frequencyController.value.text
    };
    print(data);
    btnloading.value = true;
    try {
      _api.aMCRequestCreationApiHit(data, sessionManagement).then(
        (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<AMCRequestInvoiceItemGetModal> response = JsonResponse.map(
                (e) => AMCRequestInvoiceItemGetModal.fromJson(e)).toList();
            if (response[0].condition?.toString() == "True") {
              btnloading.value = false;
              Utils.sanckBarSuccess('Success', response[0].message.toString());
              Get.offNamed(RoutesName.create_preventive_calender_view_screen);
              createPreventiveCalenderCallApi();
              clearAllField();
            } else {
              Utils.sanckBarError('False', response[0].message.toString());
              btnloading.value = false;
            }
          } else {
            btnloading.value = false;
            Utils.sanckBarException("Api Error!", JsonResponse);
          }
        },
      ).onError(
        (error, stackTrace) {
          print(error);
        },
      );
    } catch (e) {
      btnloading.value = false;
      print(e);
    }
  }
  serviceSerialNumberUpdate(int id, String oldSerialNo, BuildContext context) {
    if(serialNoController.text.isEmpty){
      Utils.sanckBarError('Error', 'Serial No is empty');
      return ;
    }
    Map data = {
      "id": id,
      "old_serial_no": oldSerialNo,
      "new_serial_no": serialNoController.text,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.serviceSerialNumberUpdateApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<AMCRequestInvoiceItemGetModal> response =
            JsonResponse.map((e) => AMCRequestInvoiceItemGetModal.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition?.toLowerCase() == "true") {
              loading.value = false;
              getServicePreventiveDetails(id,"");
              Navigator.pop(context);
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

}
