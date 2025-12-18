

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/emp_infor_modal/annual_holiday_modal.dart';
import '../../CRM_Models/emp_infor_modal/leave_type_modal.dart';
import '../../CRM_Models/emp_infor_modal/mark_leave_modal.dart';
import '../../CRM_Models/emp_infor_modal/mark_leave_request_modal.dart';
import '../../CRM_Models/emp_infor_modal/short_leave_modal.dart';
import '../../CRM_Repository/emp_informa_repository/emp_infor_repo.dart';
import '../../CRM_Repository/emp_informa_repository/emp_mark_leave_request_repo.dart';

class EmpMarkLeaveRequestVm extends GetxController{
  var _api=EmpMarkLeaveRequestRepository();
  RxBool loading=false.obs;
  int rowsPerPage = 10;
  int total_rows = 0;
  int pageNumber = 0;
  RxString filterStatus="Pending for Approval".obs;
  SessionManagement sessionManagement= SessionManagement();
  String email="";

  String ShortLeaveTiming = "";
  String LeaveAction = "Add";

  var selectedChipIndex = (0).obs;
  RxBool isHalfDay = false.obs;
  RxBool isShortLeave = false.obs;
  RxBool isLeaveType = true.obs;
  RxBool isComprehensiveLeave = false.obs;
  RxBool isPaternityLeave = false.obs;
  RxBool isDateDifferenceShow = false.obs;
  RxInt Datedifference = 0.obs;
  var selectedRadio = 0.obs;

  RxList<String> isTwinBabiesList =["Yes", "No"].obs;
  RxList<String> isBabiesGenderList =["Male", "Female"].obs;

  //todo mark leave...

  final StartDate_controller=TextEditingController();
  final EndDate_controller=TextEditingController();
  final CompOffDate_controller=TextEditingController();
  final leaveCode_controller=TextEditingController();
  final isTwinBabies_cobtroller=TextEditingController();
  final babyName_controller=TextEditingController();
  final babyGender_controller=TextEditingController();
  final babyBirthDate_controller=TextEditingController();
  final leave_Reason_controller=TextEditingController();


  //todo filter..
  final StartDate_filter_controller=TextEditingController();
  final EndDate_filter_controller=TextEditingController();
  final createdOn_filter_controller=TextEditingController();
  final leaveCode_filter_controller=TextEditingController();
  final leaveId_filter_controller=TextEditingController();
  final leave_reason_filter_controller=TextEditingController();

  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;


  RxList<MarkLeaveRequestModal> employee_leave_data_list=<MarkLeaveRequestModal>[].obs;
  RxList<MarkLeaveRequestModal> employee_leave_data_Approval_list=<MarkLeaveRequestModal>[].obs;
  RxList<MarkLeaveRequestModal> employee_leave_mark=<MarkLeaveRequestModal>[].obs;
  RxList<LeaveTypeModel> leaveType_data_list=<LeaveTypeModel>[].obs;

  Rx<LeaveTypeModel> leave_selection=LeaveTypeModel().obs;

  RxList<ShortLeaveTimeModel> ShortleaveTime_list=<ShortLeaveTimeModel>[].obs;
  RxList<AnnualHolidaysModel> Annual_Holidays_list=<AnnualHolidaysModel>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail()??"";
    getClustersGetByEmail();
    //getEmployeeLeaveData(filterStatus.value, pageNumber);
  }
  void getClustersGetByEmail() {
    try{
      Map<String, String> data={
        "email_id":email
      };
      loading.value=true;
      print("data is ${data}");
      _api.clustersGetByEmailApiHit(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<ClusterModal> response = jsonResponse.map((e) => ClusterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            clusterGetByEmailList.value=response;
            if (clusterGetByEmailList.value.isNotEmpty && SelectedCluster_list.isEmpty) {
              SelectedCluster_list.assignAll(clusterGetByEmailList.value);
              clusterName_controller.value.text =
                  clusterGetByEmailList.value.map((e) => e.geoValue).join(', ');
              getRegionsWithClusterFilterGetByEmail();
            }
          }else {
            loading.value = false;
            clusterGetByEmailList.value=[];
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
    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }
  void getRegionsWithClusterFilterGetByEmail() {
    var selectedCluster="";
    if(clusterName_controller.value.text.isNotEmpty){
      selectedCluster = clusterName_controller.value.text
          .split(',')
          .map((e) => e.trim())
          .join('||');
    }
    try{
      Map<String, String> data={
        "email_id":email,
        "cluster_filter":selectedCluster.isEmpty?"":selectedCluster
      };
      loading.value=true;
      print("data is ${data}");
      _api.RegionsWithClusterFilterGetByEmailApiHit(data, sessionManagement).then((onValue){
        print(onValue);
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<RegionWithClusterFilterModal> response = jsonResponse.map((e) => RegionWithClusterFilterModal.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            regionwithclusterGetByEmailList.value=response;
            RegionName_controller.value.text = regionwithclusterGetByEmailList.map((e) => e.geoValue).join(', ');
            print('region....${RegionName_controller.value.text}');
            getEmployeeLeaveData(filterStatus.value, pageNumber);

          }else {
            loading.value = false;
            regionwithclusterGetByEmailList.value=[];
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
    }catch(e){
      loading.value = false;
      print(e);
    }finally{
      loading.value = false;
    }
  }

  getEmployeeLeaveData(String status, int pageNumber){
    Map data= {
      "created_by": email,
      "leave_id": leaveId_filter_controller.value.text.isEmpty?"":leaveId_filter_controller.value.text,
      "leave_code": leaveCode_controller.value.text.isEmpty?"":leaveCode_controller.value.text.isEmpty,
      "status": status,
      "start_date":StartDate_filter_controller.value.text.isEmpty?"":StartDate_filter_controller.value.text,
      "end_date": EndDate_filter_controller.value.text.isEmpty?"":EndDate_filter_controller.value.text,
      "leave_reason": leave_reason_filter_controller.value.text.isEmpty?"":leave_reason_filter_controller.value.text,
      "region": RegionName_controller.value.text.isEmpty?"":RegionName_controller.value.text,
      "clusture": clusterName_controller.value.text.isEmpty?"":clusterName_controller.value.text,
      "created_on": createdOn_filter_controller.value.text.isEmpty?"":createdOn_filter_controller.value.text,
      "pageNumber": pageNumber,
      "rowsPerPage": rowsPerPage
    };

    print(data);
    loading.value=true;
    _api.employeeLeaveDataGetApihit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<MarkLeaveRequestModal> response=Jsonresponse.map((e) =>
              MarkLeaveRequestModal.fromJson(e)).toList();
          print("response...${response.length}");
          if(response!=null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            print("hhh...${employee_leave_data_list.value.length}");
            employee_leave_data_list.value = response;
          }else{
            employee_leave_data_list.value=[];
          }
        }
      }catch(e){
        print(e);
      }finally{

        loading.value=false;
      }
    },).onError((error, stackTrace) {
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);
  }


  getEmployeeLeaveRequestRejectApproveDataGet(String status, int pageNumber){
    Map data= {
      "leave_id": "",
      "email": "",
      "status": "",
      "filter_start_date": "",
      "filter_end_date": "",
      "filter_leave_code": "",
      "filter_created_by": email,
      "leave_reason": "",
      "pageNumber": pageNumber,
      "rowsPerPage": rowsPerPage
    };

    print(data);
    loading.value=true;
    _api.employeeLeaveDataGetApihit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<MarkLeaveRequestModal> response=Jsonresponse.map((e) =>
              MarkLeaveRequestModal.fromJson(e)).toList();
          print("response...${response.length}");
          if(response!=null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            print("hhh...${employee_leave_data_Approval_list.value.length}");
            employee_leave_data_Approval_list.value = response;
          }else{
            employee_leave_data_Approval_list.value=[];
          }
        }
      }catch(e){
        print(e);
      }finally{

        loading.value=false;
      }
    },).onError((error, stackTrace) {
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);
  }
 /* void onHalfDayChanged(bool? value) {
    isHalfDay.value = value ?? false;
    if (isHalfDay.value) {
      isShortLeave.value = false;
      selectedRadio = 0.obs;
    }
  }

  void onShortLeaveChanged(bool? value) {
    isShortLeave .value = value ?? false;
    if (isShortLeave .value) {
      isHalfDay.value = false;
    }
  }


  void selectRadio(int value) {
    selectedRadio.value = value; // Update the selected value
  }*/


  getLeaveTypeData(){
    Map data={
      "leave_code": "",
      "description": "",
    };
    print(data);

    _api.leaveTypeApiHit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<LeaveTypeModel > response=Jsonresponse.map((e) =>
              LeaveTypeModel .fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condtion?.toLowerCase()=="true"){
            leaveType_data_list.value = response;
          }else{
            leaveType_data_list.value=[];
          }
        }
      }catch(e){
        print(e);
      }finally{

        loading.value=false;
      }
    },).onError((error, stackTrace) {
      loading.value=false;
    },).whenComplete(() {
      loading.value=false;
    },);
  }

  getShortLeaveTime() {
    Map<String, String> data = {
      'email_id': email,
    };
    print("data......${data}");
    _api.getShortLeave(data, sessionManagement).then((value) {
      print(value);
      try {
        final Jsonresponse = json.decode(value);
        if (Jsonresponse is List) {
          List<ShortLeaveTimeModel> response = Jsonresponse.map((e) =>
              ShortLeaveTimeModel.fromJson(e)).toList();
          if (response.isNotEmpty && response[0].condition?.toLowerCase() == "true") {
            ShortleaveTime_list.value = response;
            print("ShortLeaveData......${ShortleaveTime_list[0].morningLeaveStart}");
          } else {
            leaveType_data_list.value = [];
          }
        }
      } catch (e) {
        print("Error during parsing: $e");
        printError();
      }
    }).onError((error, stackTrace) {
      print("API Error: $error");
    });
  }

  getAnnualHolidaysList() {
    Map<String, String> data = {
      'email_id': email,
    };
    print("data......${data}");
    _api.getAnnualHolidaysList(data, sessionManagement).then((value) {
      print(value);
      try {
        final Jsonresponse = json.decode(value);
        if (Jsonresponse is List) {
          List<AnnualHolidaysModel > response = Jsonresponse.map((e) =>
              AnnualHolidaysModel .fromJson(e)).toList();
          if (response.isNotEmpty && response[0].condition?.toLowerCase() == "true") {
            Annual_Holidays_list.value = response;
            print("ShortLeaveData......${Annual_Holidays_list[0].description}");
          } else {
            Annual_Holidays_list.value = [];
          }
        }
      } catch (e) {
        print("Error during parsing: $e");
        printError();
      }
    }).onError((error, stackTrace) {
      print("API Error: $error");
    });
  }

  employeeLeaveMarkData(String leaveAction){
    if(StartDate_controller.value.text.isEmpty){
      Utils.showToastification('Start Date!', "Please Select Start Date");
      return;
    }
    if(EndDate_controller.value.text.isEmpty){
      Utils.showToastification('End Date!', "Please Select End Date");
      return;
    }
   /* if(isShortLeave.value && selectedRadio.value == 0 ){
      Utils.showToastification('Short Leave', 'Please Select Short Leave Timing');
      return;
    }
    if(isShortLeave.value && Datedifference > 1 ){
      Utils.showToastification('Short Leave', 'Short Leave Apply for Only One Day');
      return;
    }*/
    if(leaveCode_controller.value.text.isEmpty){
      Utils.showToastification('Leave Type!', "Please Select Type of Leave");
      return;
    }
   /* if(leaveCode_controller.value.text == 'Comprehensive Leave (COMPL)' && CompOffDate_controller.value.text.isEmpty ){
      Utils.showToastification('Comp Off Date!', "Please Enter Comp Off Date");
      return;
    }
    if(leaveCode_controller.value.text == 'Comprehensive Leave (COMPL)' && CompOffDate_controller.value.text.isNotEmpty && Datedifference > 1 ){
      Utils.showToastification('Comp Off Date!', "You can't apply comprehensive leave more than one day");
      return;
    }
    if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && isTwinBabies_cobtroller.value.text.isEmpty ){
      Utils.showToastification('Is Twin Babies!', "Please Enter Is twin Babies");
      return;
    }
    if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyName_controller.value.text.isEmpty ){
      Utils.showToastification('Baby Name!', "Please Enter Baby Name");
      return;
    }
    if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyGender_controller.value.text.isEmpty ){
      Utils.showToastification('Baby Gender!', "Please Enter Baby Gender");
      return;
    }
    if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyBirthDate_controller.value.text.isEmpty ){
      Utils.showToastification('Baby Birth Date!', "Please Enter Baby Birth Date");
      return;
    }*/
    if(leave_Reason_controller.value.text.isEmpty){
      Utils.showToastification('Leave Reason!', "Please Enter Leave Reason");
      return;
    }
    Map data={
      "leaveDetails": [
        {
          "leave_start_date": StartDate_controller.value.text,
          "leave_end_date": EndDate_controller.value.text,
          "leave_code": leave_selection.value.leaveCode,
          "leave_reason": leave_Reason_controller.value.text,
          "is_half_day": 0,
          "is_short_leave": 0,
          "short_leave_time": "",
          "is_twin_babies": 0,
          "is_comp_off": 0,
          "comp_off_date": "",
          "baby_name": "",
          "baby_gender": "",
          "baby_birth_date":""
        }
      ],
      "created_by": email,
      "flag": leaveAction
    };

    print(data);
    loading.value=true;
    _api.empLeaveMarkApiHit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<MarkLeaveRequestModal> response=Jsonresponse.map((e) =>
              MarkLeaveRequestModal.fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            employee_leave_mark.value = response;
            Utils.showToastification('Success', '${response[0].message}');
            clearField();
            Get.offAllNamed(RoutesName.empMarkLeaveRequestScreen);
          }else{
            employee_leave_mark.value=[];
            Utils.showErrorToastification('Error!', '${response[0].message}');
          }
        }
      }catch(e){
        print(e);
      }finally{

        loading.value=false;
      }
    },).onError((error, stackTrace) {
      loading.value=false;
      print(error);
    },).whenComplete(() {
      loading.value=false;
    },);
  }

  void clearField(){
    StartDate_controller.clear();
    EndDate_controller.clear();
    isDateDifferenceShow.value = false;
    isHalfDay.value = false;
    isShortLeave.value = false;
    selectedRadio = 0.obs;
    isLeaveType.value = false;
    isLeaveType.value = true;
    isComprehensiveLeave.value = false;
    isPaternityLeave.value = false;
    leaveCode_controller.clear();
    CompOffDate_controller.clear();
    isTwinBabies_cobtroller.clear();
    babyName_controller.clear();
    babyGender_controller.clear();
    babyBirthDate_controller.clear();
    leave_Reason_controller.clear();
  }

  Future<void> refreshList() async {
    pageNumber=0;
    getEmployeeLeaveData(filterStatus.value, pageNumber);
  }

  Future<void> refreshApprovalList() async{
    pageNumber=0;
    getEmployeeLeaveRequestRejectApproveDataGet(filterStatus.value, pageNumber);
  }

 /* void bindData(AttendanceLeaveModal employee_leave_data_list) {
    StartDate_controller.text=employee_leave_data_list.workingDate??"";
    EndDate_controller.text=employee_leave_data_list.workingDate??"";
    isDateDifferenceShow.value = false;
    employee_leave_data_list.isHalfDay==1?isHalfDay.value = true:isHalfDay.value = false;
    employee_leave_data_list.isShortLeave==1?isShortLeave.value = true:isShortLeave.value = false;
    // selectedRadio = 0.obs;
    leaveCode_controller.text=employee_leave_data_list.leaveDescription??"";
    isComprehensiveLeave.value = false;
    isPaternityLeave.value = false;
    CompOffDate_controller.text=employee_leave_data_list.compOffDate??"";
    isTwinBabies_cobtroller.text=employee_leave_data_list.isTwinBabies==1?"Yes":"No";
    babyName_controller.text=employee_leave_data_list.babyName??"";
    babyGender_controller.text=employee_leave_data_list.babyGender??"";
    babyBirthDate_controller.text=employee_leave_data_list.babyBirthDate??"";
    babyLeaveRerason_controller.text=employee_leave_data_list.leaveReason??"";
  }*/
}

