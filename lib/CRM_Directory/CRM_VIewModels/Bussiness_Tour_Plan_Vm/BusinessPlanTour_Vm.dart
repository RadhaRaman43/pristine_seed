
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
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessPlanReport_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessTourPlanDetailsModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BussinessTourPlanLineDetailsModal.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BussinessTourPlanModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TourPlanAccount_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TouringDistrictModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/region_master_modal.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/reporting_manager_modal.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_Repository/BusinessTourPlan_Repository/business_tour_plan_repo.dart';
import 'Business_Tour_Approval_Vm.dart';

class BusinessPlanTourViewModel extends GetxController{

  final _api = BusinessTourPlanRepo();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  RxString isAdminWritePermission = "".obs;
  RxString isHeadOfficePermission = "".obs;
  String filterRouting = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxBool meetingWith = true.obs;
  RxBool tourType = true.obs;
  RxBool customerVisible = true.obs;
  RxBool addCustomer = false.obs;
  RxBool selectMeetingWith = false.obs;
  String StartDate = '', EndDate = '', Tour_Id = '', CustomerId = '';
  RxString isSendForApproval = ''.obs;
  RxString fromPage = ''.obs;
  RxString filterStatusFlag = 'PENDING'.obs;

  String MeetingWithResponse = '', Accompanied_With_Response = '';

  RxList<BussinessTourPlanModel> BusinessTourPlanList = <BussinessTourPlanModel>[].obs;
  RxList<BussinessTourPlanLineDetailsModal> BusinessTourPlanLineDetailList = <BussinessTourPlanLineDetailsModal>[].obs;
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

  var filterTourIdController = TextEditingController().obs;
  var filterTouringRegionController = TextEditingController().obs;
  var filterTouringNameController = TextEditingController().obs;
  var filterCreatedByController = TextEditingController().obs;

  final StartDate_filter_controller=TextEditingController().obs;
  final EndDate_filter_controller=TextEditingController().obs;
  final createdOn_filter_controller=TextEditingController().obs;
  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  var filterTourDateController = TextEditingController().obs;
  var filterTourDateFromToController = TextEditingController().obs;
  var filterCreatedOnController = TextEditingController().obs;

  RxString createdOnStartToEnd="".obs;



  RxList<EmployeeMemberModel> employee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<EmployeeMemberModel> SelectedEmployee_Member_list = <EmployeeMemberModel>[].obs;
  RxList<RegionMasterModal> regionMasterList = <RegionMasterModal>[].obs;
  RxList<ReportingManagerModal> reportingMangerList = <ReportingManagerModal>[].obs;
  RxList<ReportingManagerModal> selectedReportingMangerList = <ReportingManagerModal>[].obs;

 /* //todo Bussiness Tour Plan Line Details Controller
  var filterCreatedByController = TextEditingController().obs;
  var filterTourIdController = TextEditingController().obs;
  var filterTouringRegionController = TextEditingController().obs;
  var filterTouringNameController = TextEditingController().obs;
  var filterClusterNameController = TextEditingController().obs;*/

  var touringRegionController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;
  var remarkController = TextEditingController().obs;

  var AlongPersonWith_controller = TextEditingController();
  var TourPlanDistrict_Controller = TextEditingController();
  var TourPlanAccount_Controller = TextEditingController().obs;
  var MeetingWith_controller = TextEditingController().obs;
  var TourPlanRemarks_Controller = TextEditingController();
  var TourPlanObjective_Controller = TextEditingController();
  var tourDate_Controller = TextEditingController();
  var TourType_Controller = TextEditingController().obs;

  var ApproveReject_Controller = TextEditingController();
  var RejectReason_Controller = TextEditingController().obs;
  var manager_remark_Controller = TextEditingController().obs;
  var reporting_manager_Controller = TextEditingController().obs;
  var ApprovalStatusController = TextEditingController().obs;

  RxList<String> ApprovalStatusList = ["All", "PENDING", "PENDING FOR APPROVAL", "APPROVED", "REJECTED"].obs;

  RxBool RejectBool=false.obs;
  String ApproveReject = '';
  RxList<String> approveRejectList = <String>[].obs;

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission.value = await sessionManagement.getIsAdminPermission() ?? '';
    isHeadOfficePermission.value = await sessionManagement.getisHeadofficePermission() ?? '';
    filterRouting = await sessionManagement.getfilterRouting() ?? '';
    approveRejectList.value = ['Approve', 'Reject'];
    clearAllFieldOfFilter();
    //getReportingManager("");
    RegionMasterGet();
    EmployeeMasterGet("");
    getClustersGetByEmail();
    super.onInit();
  }
  Future<void> refreshList() async {
    pageNumber = 0;
    getBusinessTourPlanData(pageNumber);
  }
  Future<void> refreshLineDetailList() async {
    pageNumber = 0;
    getBusinessTourPlanAllLineGet(pageNumber);
  }

  String formattedNames(String value) {
    try {
      if (value.startsWith('[') && value.endsWith(']')) {
        List<dynamic> names = jsonDecode(value);
        return names.join(", ");
      }
      return value;
    } catch (e) {
      return value;
    }
  }

  Future<Iterable<EmployeeMemberModel>> EmployeeMasterGet(String query) async {

    try {
      Map data = {
        'filter_name': '',
        'filter_email': query,
        'filter_location_id': '',
        'email_id': email,
        'rowsPerPage': 50,
        'pageNumber': 0,
      };
      loading.value=true;
      print("created by ${data}");
      String employee_response =await _api.EmployeeMatserGetApiHit(data, sessionManagement);


      final jsonResponse = json.decode(employee_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<EmployeeMemberModel> response =
        jsonResponse.map((data) => EmployeeMemberModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          employee_Member_list.value = response;
          loading.value=false;
        } else {
          loading.value=false;
          employee_Member_list.value = [];
        }
      } else {
        loading.value=false;
        Utils.sanckBarException('False!', jsonResponse.message);
        employee_Member_list.value = [];
      }
    } catch (e) {
      loading.value=false;
      Utils.sanckBarException('Exception!', e.toString());
      employee_Member_list.value = [];
    }
    return employee_Member_list.value;
  }

  void RegionMasterGet() async {

    try {
      Map data = {
        "filter_cluster_name": "",
        "filter_zone_name": "",
        "filter_region_name": ""
      };
      loading.value=true;
      print("created by ${data}");
      String employee_response =await _api.RegionMasterGet(data, sessionManagement);


      final jsonResponse = json.decode(employee_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<RegionMasterModal> response =
        jsonResponse.map((data) => RegionMasterModal.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          regionMasterList.value = response;
        } else {
          Utils.sanckBarException('False!', response.toString());

        }
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      employee_Member_list.value = [];
    }
    finally{
      loading.value=false;
    }

  }
  Future<List<ReportingManagerModal>> getReportingManager(String searchText) async {
    try {
      Map<String, dynamic> data = {
        "email_id": "rajesh.kumar1@methodexsystems.com",
        "filter_value": searchText,
        "rowsPerPage": 50,
        "pageNumber": 0
      };
      print("data is master....${data}");
      final response =
      await _api.BusinessTourplanReportingManagerGet(data, sessionManagement);

      final jsonResponse = json.decode(response);

      if (jsonResponse is List) {
        List<ReportingManagerModal> list =
        jsonResponse.map((e) => ReportingManagerModal.fromJson(e)).toList();
        if (list.isNotEmpty && list[0].condition?.toLowerCase() == "true") {
          reportingMangerList.value = list;
          return list;
        }
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  void getClustersGetByEmail() async{
    try{
      Map<String, String> data={
        "email_id":email
      };
      loading.value=true;
      print("data is ${data}");
      String onValue = await _api.clustersGetByEmailApiHit(data, sessionManagement);
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<ClusterModal> response = jsonResponse.map((e) => ClusterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            clusterGetByEmailList.value=response;
            if (clusterGetByEmailList.value.isNotEmpty && SelectedCluster_list.isEmpty) {
              SelectedCluster_list.assignAll(clusterGetByEmailList.value);
              clusterName_controller.value.text = clusterGetByEmailList.value.map((e) => e.geoValue).join('|');
              getRegionsWithClusterFilterGetByEmail();
            }
          }else {
            loading.value = false;
            clusterGetByEmailList.value=[];
          }
        } else {
          loading.value = false;
        }

    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }

  void getRegionsWithClusterFilterGetByEmail() async{
    var selectedCluster="";
    if(clusterName_controller.value.text.isNotEmpty){
      selectedCluster = clusterName_controller.value.text.split(',').map((e) => e.trim()).join('|');
    }
    try{
      Map<String, String> data={
        "email_id":email,
        "cluster_filter":selectedCluster.isEmpty?"":selectedCluster
      };
      loading.value=true;
      print("data is ${data}");
      String onValue = await _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement);
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            regionwithclusterGetByEmailList.value=response;
            RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
            SelectedRegion_list.assignAll(regionwithclusterGetByEmailList);
            if(filterRouting=='Business Tour Plan Line Details'){
              getBusinessPlanLineFilterData();
            }
            else if(filterRouting=='Business Tour Plan'){
              getFilterData();
            }

            //getBusinessTourPlanAllLineGet(pageNumber);

          }else {
            loading.value = false;
            regionwithclusterGetByEmailList.value=[];
          }
        } else {
          loading.value = false;
        }

    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }

  getBusinessTourPlanData(int page_no)  {
    try {
      Map data = {
        "created_by": filterCreatedByController.value.text.isEmpty?"":filterCreatedByController.value.text,
        "tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,
        "touring_region": filterTouringRegionController.value.text.isEmpty?"":filterTouringRegionController.value.text,
        "email_id": email,
        "branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "start_date": StartDate_filter_controller.value.text.isEmpty?"":StartDate_filter_controller.value.text,
        "end_date": EndDate_filter_controller.value.text.isEmpty?"":EndDate_filter_controller.value.text,
        "filter_created_on": createdOn_filter_controller.value.text.isEmpty?"":createdOn_filter_controller.value.text,
        "status":  ApprovalStatusController.value.text.toUpperCase()=='ALL'?'':ApprovalStatusController.value.text,
        "reporting_manager": reporting_manager_Controller.value.text.isEmpty?"":reporting_manager_Controller.value.text,
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
              total_rows = int.parse(BusinessTourPlanList[0].totalRows!);
              print('listSize.....${BusinessTourPlanList.length} and ${total_rows}');

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
          print("on error $error");
          loading.value = false;
        },
      );
    } catch (e) {
      loading.value = false;
      print("catch error $e");
    }
  }

  getBusinessTourPlanAllLineGet(int page_no) async{
    try {
      Map data = {
        "tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,
        "account_code": "",
        "created_by": filterCreatedByController.value.text.isEmpty? email:filterCreatedByController.value.text,
        "created_on": createdOnStartToEnd.value.isEmpty?"":createdOnStartToEnd.value,
        "tour_date_on": filterTourDateFromToController.value.text.isEmpty?"":filterTourDateFromToController.value.text,
        "branch_head_value": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
        "clusture_head_value": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
        "district": "",
        "status": "",
        "touring_region": filterTouringRegionController.value.text.isEmpty?"":filterTouringRegionController.value.text,
        "filter_flag": "AllBusinessTourLine",
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no
      };
      loading.value = true;
      String onValue = await _api.BusinessTourPlanAllLineGet(data, sessionManagement);
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanLineDetailsModal> response =
            jsonResponse.map((e) => BussinessTourPlanLineDetailsModal.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              if (page_no == 0) {
                BusinessTourPlanLineDetailList.clear();
              }
              BusinessTourPlanLineDetailList.addAll(response);
              print('listSize.....${BusinessTourPlanLineDetailList.length}');
              total_rows = int.parse(BusinessTourPlanLineDetailList[0].totalRows!);

            } else {
              BusinessTourPlanLineDetailList.value = [];
            }
          }
    } catch (e) {

      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  BusinessTourPlanHeaderCreate() {
    try {
      Map data = {
        "touring_region": touringRegionController.value.text,
        "start_date": startDateController.value.text,
        "end_date": endDateController.value.text,
        "email_id": email,
        "remarks": remarkController.value.text
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
              getBusinessTourPlanDetailsApi(response[0].tourId, "TourDetail");

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
        "meeting_with": TourType_Controller.value.text.toString().trim().toLowerCase()=="client meeting"?jsonEncode(SelectedMeetingWith_List1):MeetingWith_controller.value.text,
        //"meeting_with": MeetingWith_controller.value.text,
        "objective": TourPlanObjective_Controller.value.text.isEmpty?"":TourPlanObjective_Controller.value.text,
        "remark": TourPlanRemarks_Controller.value.text.isEmpty?"":TourPlanRemarks_Controller.value.text,
        "email_id": email
      };
      loading.value = true;
      print("data is ${data}");
      _api.BusinessTourPlanLineCreate(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              customerVisible.value =true;
              addCustomer.value = false;
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

      if (response.statusCode != 200) {
        print("Failed to download file: ${response.statusCode}");
        return;
      }

      final bytes = response.bodyBytes;
      print("Bytes: ${bytes.length}");

      Directory directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        throw Exception("Unsupported platform");
      }

      String baseName =
          'Business_Tour_Plan_${BusinessTourPlanDetails_list[0].tourId}';
      String extension = '.pdf';

      String filePath = '${directory.path}/$baseName$extension';
      int counter = 1;

      while (await File(filePath).exists()) {
        filePath = '${directory.path}/$baseName($counter)$extension';
        counter++;
      }

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      print("File saved at: ${file.path}");

      // 🔔 Show notification
      showNotification(file.path);

    } catch (e) {
      print("Error downloading file: $e");
    }
  }


/*
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
*/

  /*void showNotification(String path) async {
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
  }*/

  void showNotification(String path) async {
    const String title = 'Business Tour Plan';
    final int notificationId = Random().nextInt(100000);

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'download_channel', // ✅ MUST MATCH init channel
      'File Downloads',
      channelDescription: 'Notification for downloaded files',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails iosDetails =
    DarwinNotificationDetails();

    const NotificationDetails platformDetails =
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    print("dhow notification after download");
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      'Report downloaded successfully',
      platformDetails,
      payload: path, // ✅ DIRECT FILE PATH ONLY
    );
  }


  BusinessTourPlanApproveReject(String TourId, String Status) {
    try {
      if(manager_remark_Controller.value.text.isEmpty){
        Utils.sanckBarError("Manager Remark!", "Please Enter Manager Remark");
        return;
      }
      Map data = {
        "tour_id": TourId,
        "status": Status,
        "reject_remark": RejectReason_Controller.value.text.isNotEmpty?RejectReason_Controller.value.text:'',
        "email_id": email,
        "manager_remarks": manager_remark_Controller.value.text
      };
      loading.value = true;
      _api.BusinessTourPlanApproveReject(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              BusinessTourApprovalVm BusinessTourApprovalController=Get.put(BusinessTourApprovalVm());
              BusinessTourApprovalController.pageNumber = 0;
              BusinessTourApprovalController.getBusinessTourApprovalListData(pageNumber);
              if(fromPage.value=="business_tour_plan_page"){
                Get.offAllNamed(RoutesName.BusinessTourPlanScreen);
              }
              else{
               Get.offAllNamed(RoutesName.BusinessTourApprovalListScreen);
              }
              //Get.toNamed(RoutesName.BusinessTourApprovalListScreen);

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


  void clearAllFieldOfFilter() {
    print("Clear Filed");
    filterCreatedByController.value.clear();
    filterTourIdController.value.clear();
    StartDate_filter_controller.value.clear();
    EndDate_filter_controller.value.clear();
    createdOn_filter_controller.value.clear();
    filterTouringRegionController.value.clear();
    filterTouringNameController.value.clear();
    filterTourDateController.value.clear();
    filterTourDateFromToController.value.clear();
    filterCreatedOnController.value.clear();
    reporting_manager_Controller.value.clear();
    ApprovalStatusController.value.clear();
    createdOnStartToEnd.value="";
    selectedReportingMangerList.value=[];
    filterStatusFlag.value = 'PENDING';
    ApprovalStatusController.value.text='PENDING';

    SelectedCluster_list.value=[];
    SelectedRegion_list.value=[];
    //RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
    getRegionsWithClusterFilterGetByEmail();

  }

  void clearAllCreateLinePlanController(){
    AlongPersonWith_controller.clear();
    TourPlanDistrict_Controller.clear();
    TourPlanAccount_Controller.value.clear();
    MeetingWith_controller.value.clear();
    TourPlanRemarks_Controller.clear();
    TourPlanObjective_Controller.clear();
    tourDate_Controller.clear();
    TourType_Controller.value.clear();
    SelectedAlongPersonWith_list.value=[];
    SelectedMeetingWith_List.value=[];

    SelectedCluster_list.value=[];
    SelectedRegion_list.value=[];
    RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join('|');
    clusterName_controller.value.text = clusterGetByEmailList.map((e) => e.geoValue).join('|');
  }

  RxString filterDataChecker = ''.obs;
  void SaveFilterData() async{
    await sessionManagement.saveBusinessTourPlanData({

      'filterTourIdController': filterTourIdController.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'filterTouringRegionController': filterTouringRegionController.value.text,
      'StartDate_filter_controller': StartDate_filter_controller.value.text,
      'EndDate_filter_controller': EndDate_filter_controller.value.text,
      'filterCreatedByController': filterCreatedByController.value.text,
      'createdOn_filter_controller': createdOn_filter_controller.value.text,
      'reporting_manager_Controller': reporting_manager_Controller.value.text,
      'ApprovalStatusController': ApprovalStatusController.value.text,

    });
    filterDataChecker.value='';
    pageNumber=0;
    getBusinessTourPlanData(pageNumber);
  }

  void getFilterData() async{
    Map getFilterData=await sessionManagement.getBusinessTourPlanData();

    if(getFilterData.isNotEmpty){
      filterTourIdController.value.text=getFilterData["filterTourIdController"]??"";
      filterTouringRegionController.value.text=getFilterData["filterTouringRegionController"]??"";
      StartDate_filter_controller.value.text=getFilterData["StartDate_filter_controller"]??"";
      EndDate_filter_controller.value.text=getFilterData["EndDate_filter_controller"]??"";
      filterCreatedByController.value.text=getFilterData["filterCreatedByController"]??"";
      createdOn_filter_controller.value.text=getFilterData["createdOn_filter_controller"]??"";
      reporting_manager_Controller.value.text=getFilterData["reporting_manager_Controller"]??"";
      ApprovalStatusController.value.text=getFilterData["ApprovalStatusController"]??"";
      ApprovalStatusController.value.text=ApprovalStatusController.value.text;
      filterDataChecker.value='1';

      if(getFilterData["region_name"].toString().isNotEmpty && getFilterData["region_name"].toString()!=""){
        RegionName_controller.value.text = "";
        RegionName_controller.value.text = getFilterData["region_name"].toString()??"";
      }
      if(getFilterData["cluster_name"].toString().isNotEmpty && getFilterData["cluster_name"].toString()!=""){
        clusterName_controller.value.text="";
        clusterName_controller.value.text=getFilterData["cluster_name"].toString()??"";
        print("clusterName_controller.value.text.....${clusterName_controller.value.text}");
      }
    }
    else{
      print("else condition");
    }

    pageNumber=0;
    getBusinessTourPlanData(pageNumber);
  }

  void clearFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearBusinessTourPlanData();
  }

  //todo business tour plan data
  void SaveBusinessPlanLineFilterData() async{
    await sessionManagement.saveBusinessTourPlanLineData({
      'filterTourIdController': filterTourIdController.value.text,
      'region_name': RegionName_controller.value.text,
      'cluster_name': clusterName_controller.value.text,
      'filterTouringRegionController': filterTouringRegionController.value.text,
      'filterTourDateController': filterTourDateController.value.text,
      'filterTourDateFromToController': filterTourDateFromToController.value.text,
      'filterCreatedByController': filterCreatedByController.value.text,
      'filterCreatedOnController': filterCreatedOnController.value.text,
    });
    filterDataChecker.value='';
    pageNumber=0;
    getBusinessTourPlanAllLineGet(pageNumber);
  }

  void getBusinessPlanLineFilterData() async{
    Map getFilterData=await sessionManagement.getBusinessTourPlanLineData();
    if(getFilterData.isNotEmpty){
      filterTourIdController.value.text=getFilterData["filterTourIdController"]??"";
      filterTouringRegionController.value.text=getFilterData["filterTouringRegionController"]??"";
      filterTourDateController.value.text=getFilterData["filterTourDateController"]??"";
      filterTourDateFromToController.value.text=getFilterData["filterTourDateFromToController"]??"";
      filterCreatedByController.value.text=getFilterData["filterCreatedByController"]??"";
      filterCreatedOnController.value.text=getFilterData["filterCreatedOnController"]??"";
      filterDataChecker.value='1';

      if(getFilterData["region_name"].toString().isNotEmpty && getFilterData["region_name"].toString()!=""){
        RegionName_controller.value.text = "";
        RegionName_controller.value.text = getFilterData["region_name"].toString()??"";
      }
      if(getFilterData["cluster_name"].toString().isNotEmpty && getFilterData["cluster_name"].toString()!=""){
        clusterName_controller.value.text="";
        clusterName_controller.value.text=getFilterData["cluster_name"].toString()??"";
        print("clusterName_controller.value.text.....${clusterName_controller.value.text}");
      }
    }
    else{
      print("else condition");
    }
    pageNumber=0;
    getBusinessTourPlanAllLineGet(pageNumber);
  }

  void clearBusinessPlanLineFilterData() {
    filterDataChecker.value='';
    sessionManagement.clearBusinessTourPlanLineData();
  }



  getBusinessTourPlanDelete(String TourId) {
    try {
      Map data = {
        "tour_id": TourId,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanDelete(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if ( response[0].condition?.toLowerCase() == "true") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              pageNumber = 0;
              getBusinessTourPlanData(pageNumber);

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

}