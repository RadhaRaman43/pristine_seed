
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../main.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessPlanReport_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessTourPlanDetailsModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BussinessTourPlanModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TourPlanAccount_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TouringDistrictModel.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_Repository/BusinessTourPlan_Repository/business_tour_plan_repo.dart';

class BusinessPlanTourViewModel extends GetxController{

  final _api = BusinessTourPlanRepo();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxBool meetingWith = true.obs;
  String StartDate = '', EndDate = '', Tour_Id = '', CustomerId = '';
  RxString isSendForApproval = ''.obs;
  RxString filterStatusFlag = 'PENDING'.obs;

  String MeetingWithResponse = '', Accompanied_With_Response = '';

  RxList<BussinessTourPlanModel> BusinessTourPlanList = <BussinessTourPlanModel>[].obs;
  RxList<BusinessTourPlanDetailsModel> BusinessTourPlanDetails_list = <BusinessTourPlanDetailsModel>[].obs;
  RxList<Lines> BusinessTourHourLines = <Lines>[].obs;
  RxList<AlongWithPersonModel> AlongPersonWith_list = <AlongWithPersonModel>[].obs;
  RxList<AlongWithPersonModel> SelectedAlongPersonWith_list = <AlongWithPersonModel>[].obs;
  RxList<String> SelectedAlongPersonWith_list1 = <String>[].obs;
  RxList<TouringDistrictModel> TouringDistirct_list = <TouringDistrictModel>[].obs;
  RxList<TouringDistrictModel> TourType_List = <TouringDistrictModel>[].obs;
  RxList<TourPlanAccountModel> TourPlanAccount_List = <TourPlanAccountModel>[].obs;
  RxList<TourPlanAccountModel> TourPlanContact_List = <TourPlanAccountModel>[].obs;
  RxList<TourPlanAccountModel> SelectedMeetingWith_List = <TourPlanAccountModel>[].obs;
  RxList<String> SelectedMeetingWith_List1 = <String>[].obs;
  RxList<BusinessPlanReportModel> ReportList = <BusinessPlanReportModel>[].obs;

  var filterCreatedByController = TextEditingController().obs;
  var filterTourIdController = TextEditingController().obs;
  var filterTouringRegionController = TextEditingController().obs;

  var touringRegionController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;

  var AlongPersonWith_controller = TextEditingController();
  var TourPlanDistrict_Controller = TextEditingController();
  var TourPlanAccount_Controller = TextEditingController().obs;
  var MeetingWith_controller = TextEditingController().obs;
  var TourPlanRemarks_Controller = TextEditingController();
  var TourPlanObjective_Controller = TextEditingController();
  var tourDate_Controller = TextEditingController();
  var TourType_Controller = TextEditingController();

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    clearAllFieldOfFilter();
    getBusinessTourPlanData(pageNumber);
    super.onInit();
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getBusinessTourPlanData(pageNumber);
  }

  String formattedNames(String encodedString) {
    try {
      List<dynamic> names = jsonDecode(encodedString);
      return names.join(", ");
    } catch (e) {
      return ""; // or fallback to original string if needed
    }
  }

  getBusinessTourPlanData(int page_no) {
    try {
      Map data = {
        "created_by": filterCreatedByController.value.text.isEmpty?"":filterCreatedByController.value.text,
        "tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,
        "touring_region": filterTouringRegionController.value.text.isEmpty?"":filterTouringRegionController.value.text,
        "email_id": email,
        "status": filterStatusFlag.value,
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no
      };
      loading.value = true;
      _api.businessPlanListGetApiHit(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if (page_no == 0) {
                BusinessTourPlanList.clear();
              }
              BusinessTourPlanList.addAll(response);
              print('listSize.....${BusinessTourPlanList.length}');
              total_rows = int.parse(BusinessTourPlanList[0].totalRows!);

            } else {
              loading.value = false;
              BusinessTourPlanList.value = [];
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  BusinessTourPlanHeaderCreate() {
    try {
      Map data = {
        "touring_region": touringRegionController.value.text,
        "start_date": startDateController.value.text,
        "end_date": endDateController.value.text,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanHeaderCreate(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              getBusinessTourPlanDetailsApi(response[0].tourId, "");

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  BusinessTourPlanHeaderComplete(String TourId) {
    try {
      Map data = {
        "tour_id": TourId,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanHeaderComplete(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              pageNumber = 0;
              getBusinessTourPlanData(pageNumber);
              Get.toNamed(RoutesName.BusinessTourPlanScreen);

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  BusinessTourPlanHeaderDelete(String TourId) {
    try {
      Map data = {
        "tour_id": TourId,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanHeaderDelete(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              pageNumber = 0;
              getBusinessTourPlanData(pageNumber);
              Get.toNamed(RoutesName.BusinessTourPlanScreen);

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  getBusinessTourPlanDetailsApi(String? TourId, String Flag) {
    Map<String , String> data = {
      "tour_id": TourId??""
    };
    loading.value = true;
    _api.BusinessTourPlanDetailsGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<BusinessTourPlanDetailsModel> response =
            JsonResponse.map((e) => BusinessTourPlanDetailsModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              BusinessTourPlanDetails_list.value=response;
              BusinessTourHourLines.value = response[0].lines??[];
              Tour_Id = BusinessTourPlanDetails_list[0].tourId??"";
              StartDate = BusinessTourPlanDetails_list[0].startDate??"";
              EndDate = BusinessTourPlanDetails_list[0].endDate??"";
              isSendForApproval.value = Flag;
              Get.toNamed(RoutesName.BusinessTourPlanDetails);


            } else {
              BusinessTourPlanDetails_list.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
              //service_installation_details_list.value=[];
            }
          } else {

            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  BusinessTourPlanLinesCreate(String TourId) {
    try {
      Map data = {
        "tour_id": TourId,
        "touring_district": TourPlanDistrict_Controller.value.text.isEmpty?"":TourPlanDistrict_Controller.value.text,
        "tour_date": tourDate_Controller.value.text.isEmpty?"":tourDate_Controller.value.text,
        "tour_type": TourType_Controller.value.text.isEmpty?'':TourType_Controller.value.text,
        "accompanied_with": jsonEncode(SelectedAlongPersonWith_list1),
        "customer": CustomerId,
        "meeting_with": jsonEncode(SelectedMeetingWith_List1),
        "objective": TourPlanObjective_Controller.value.text.isEmpty?"":TourPlanObjective_Controller.value.text,
        "remark": TourPlanRemarks_Controller.value.text.isEmpty?"":TourPlanRemarks_Controller.value.text,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanLineCreate(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              getBusinessTourPlanDetailsApi(response[0].tourId, "");

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  BusinessTourPlanLinesDelete(String TourId, String LineNo) {
    try {
      Map data = {
        "tour_id": TourId,
        "line_no": LineNo,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanLineDelete(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              getBusinessTourPlanDetailsApi(response[0].tourId, "");

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  getEmpMstEmailByApi() {
    Map<String , String> data = {
      "email_id": email
    };
    print(data);
    loading.value = true;
    _api.EmpMstEmailByGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<AlongWithPersonModel> response =
            JsonResponse.map((e) => AlongWithPersonModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              AlongPersonWith_list.value=response;


            } else {
              AlongPersonWith_list.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
            }
          } else {

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  getTourTypeApi() {
    Map<String , String> data = {
      "type": ""
    };
    print(data);
    loading.value = true;
    _api.BusinessTourTypeGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<TouringDistrictModel> response =
            JsonResponse.map((e) => TouringDistrictModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              TourType_List.value=response;


            } else {
              TourType_List.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
            }
          } else {

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  Future<Iterable<TouringDistrictModel>> getTourPlanDistrictTypeApi(String text) async {
    loading.value=true;
    Map data = {
      "filter_district": text,
      "rowsPerPage":50 ,
      "pageNumber": 0
    };
    print("Complany Data....${data}");
    String customer_response =await  _api.TourPlanDistrictApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<TouringDistrictModel> response =
        jsonResponse.map((data) => TouringDistrictModel.fromJson(data)).toList();
        if (response[0].condition == 'True') {
          TouringDistirct_list.value = response;

        } else {

          TouringDistirct_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        TouringDistirct_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      TouringDistirct_list.value = [];
    }
    finally{
      loading.value=false;
    }
    return  TouringDistirct_list.value;
  }

  Future<Iterable<TourPlanAccountModel>> getTourPlanAccountTypeApi(String text) async {
    loading.value=true;
    Map data = {
      "filter_account_name": text,
      "filter_account_owner": "",
      "filter_is_active": 1,
      "rowsPerPage":50 ,
      "pageNumber": 0
    };
    String customer_response =await  _api.TourPlanAccountApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<TourPlanAccountModel> response =
        jsonResponse.map((data) => TourPlanAccountModel.fromJson(data)).toList();
        if (response[0].condition == 'True') {
          TourPlanAccount_List.value = response;

        } else {

          TourPlanAccount_List.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        TourPlanAccount_List.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      TourPlanAccount_List.value = [];
    }
    finally{
      loading.value=false;
    }
    return  TourPlanAccount_List.value;
  }

  BusinessTourPlanContactGet(String accountCode) {
    try {
      Map data = {
        "account_code": accountCode,
        "contact_filter": ''
      };
      loading.value = true;
      _api.BusinessTourPlanContactsGet(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<TourPlanAccountModel> response =
            jsonResponse.map((e) => TourPlanAccountModel.fromJson(e)).toList();
            if (response[0].condition == 'True') {
              TourPlanContact_List.value = response;

            } else {

              TourPlanContact_List.value= [];
            }
          } else {
            loading.value = false;
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }


  Future<void> businessPlanReportDownload(String TourId) async {
    try {
      Map<String, String> data = {
        "tour_id": TourId,
      };
      print(data);
      loading.value = true;
      _api.BusinessTourPlanReport(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BusinessPlanReportModel> response = jsonResponse
                .map((e) => BusinessPlanReportModel.fromJson(e))
                .toList();
            if (response.isNotEmpty &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              ReportList.value = response;
              fileDownload(ReportList[0].bussinessTourPlanReportUrl!);
            } else {
              Utils.showErrorToastification(
                  "False Message !", response[0].message.toString());
              loading.value = false;
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
    } finally {
      loading.value = false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> checkPermissions() async {
    //await _requestPermission(Permission.storage
    if (await _requestPermission(Permission.storage)) {
      print("Storage permission grant.");
    } else {
      print("Storage permission is required to save the file.");
    }
  }


  Future<void> fileDownload(String url) async {
    await checkPermissions();
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        print("Bytes: ${bytes.length}");
        Directory? downloadsDir;
        if (Platform.isAndroid) {
          downloadsDir = Directory('/storage/emulated/0/Download');
        } else if (Platform.isIOS) {
          downloadsDir = await getApplicationDocumentsDirectory();
        } else {
          throw Exception("Unsupported platform");
        }

        if (downloadsDir == null) {
          throw Exception("Unable to get the downloads directory");
        }
        String baseName = "";
          baseName = 'Business_Tour_Plan_${BusinessTourPlanDetails_list[0].tourId}';
        String extension = '.pdf';
        String filePath = '${downloadsDir.path}/$baseName$extension';
        int counter = 1;

        while (await File(filePath).exists()) {
          filePath = '${downloadsDir.path}/$baseName($counter)$extension';
          counter++;
        }

        File file = File(filePath);
        await file.writeAsBytes(bytes);
        print("${file.path}");

        Directory? dir = await getExternalStorageDirectory();

        if (dir != null) {
          // Make sure the directory exists
          await Directory(dir.path).create(recursive: true);

          // Define the file path
          File file = File('${dir.path}/BusinessTourPlan.pdf');
          //File file = File('${dir.path}/QuoteReport.pdf');

          // Write the bytes to the file
          await file.writeAsBytes(bytes);

          // Show notification
          showNotification(file.path);
          print("File saved successfully at ${file.path}");
        } else {
          print("Failed to get the download directory");
        }
      } else {
        print("Failed to download file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  void showNotification(String path) async {
    String title = 'Business Tour Plan';
    int notificationId = Random().nextInt(100000);

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'basic_channel',
      'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      'Report downloaded successfully',
      platformDetails,
      payload: 'filePath=$path',
    );
  }


  void clearAllFieldOfFilter() {
    print("Clear Filed");
    filterCreatedByController.value.clear();
    filterTourIdController.value.clear();
    filterTouringRegionController.value.clear();

  }

  void clearAllCreateLinePlanController(){
    AlongPersonWith_controller.clear();
    TourPlanDistrict_Controller.clear();
    TourPlanAccount_Controller.value.clear();
    MeetingWith_controller.value.clear();
    TourPlanRemarks_Controller.clear();
    TourPlanObjective_Controller.clear();
    tourDate_Controller.clear();
    TourType_Controller.clear();
  }

}