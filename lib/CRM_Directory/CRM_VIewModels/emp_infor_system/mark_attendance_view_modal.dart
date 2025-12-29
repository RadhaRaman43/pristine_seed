

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/emp_infor_modal/annual_holiday_modal.dart';
import '../../CRM_Models/emp_infor_modal/leave_type_modal.dart';
import '../../CRM_Models/emp_infor_modal/mark_leave_modal.dart';
import '../../CRM_Models/emp_infor_modal/short_leave_modal.dart';
import '../../CRM_Repository/emp_informa_repository/emp_infor_repo.dart';

class MarkAttendanceViewmodel extends GetxController{
  var _api=EmpInforRepository();
  RxBool loading=false.obs;
  RxString filterStatus="Pending".obs;
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
  final babyLeaveRerason_controller=TextEditingController();


  //todo filter..
  final StartDate_filter_controller=TextEditingController();
  final EndDate_filter_controller=TextEditingController();
  final leaveCode_filter_controller=TextEditingController();

  RxList<AttendanceLeaveModal> employee_leave_data_list=<AttendanceLeaveModal>[].obs;
  RxList<AttendanceLeaveModal> employee_leave_mark=<AttendanceLeaveModal>[].obs;
  RxList<LeaveTypeModel> leaveType_data_list=<LeaveTypeModel>[].obs;

  Rx<LeaveTypeModel> leave_selection=LeaveTypeModel().obs;

  RxList<ShortLeaveTimeModel> ShortleaveTime_list=<ShortLeaveTimeModel>[].obs;
  RxList<AnnualHolidaysModel> Annual_Holidays_list=<AnnualHolidaysModel>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail()??"";
    getEmployeeLeaveData(filterStatus.value);
  }


  getEmployeeLeaveData(String status){
    Map data={
      "created_by": email,
      "leave_code": ""/*leaveCode_filter_controller.value.text.isEmpty?"":leaveCode_filter_controller.value.text*/,
      "status": status,
      "start_date":""/* StartDate_filter_controller.value.text.isEmpty?"":StartDate_filter_controller.value.text*/,
      "end_date": ""/*EndDate_filter_controller.value.text.isEmpty?"":EndDate_filter_controller.value.text*/,

    };
    print(data);
    loading.value=true;
    _api.employeeLeaveDataGetApihit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<AttendanceLeaveModal> response=Jsonresponse.map((e) =>
              AttendanceLeaveModal.fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condition=="True"){
            employee_leave_data_list.value = response;
            print('leaveList...${employee_leave_data_list.length}');

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

  void onHalfDayChanged(bool? value) {
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
  }


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
          if (response.isNotEmpty && response[0].condition == "True") {
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
      Utils.sanckBarSuccess('Start Date!', "Please Select Start Date");
      return;
    }
     if(EndDate_controller.value.text.isEmpty){
      Utils.sanckBarSuccess('End Date!', "Please Select End Date");
      return;
    }
     if(isShortLeave.value && selectedRadio.value == 0 ){
      Utils.sanckBarSuccess('Short Leave', 'Please Select Short Leave Timing');
      return;
    }
     if(isShortLeave.value && Datedifference > 1 ){
      Utils.sanckBarSuccess('Short Leave', 'Short Leave Apply for Only One Day');
      return;
    }
     if(leaveCode_controller.value.text.isEmpty){
      Utils.sanckBarSuccess('Leave Type!', "Please Select Type of Leave");
      return;
    }
     if(leaveCode_controller.value.text == 'Comprehensive Leave (COMPL)' && CompOffDate_controller.value.text.isEmpty ){
      Utils.sanckBarSuccess('Comp Off Date!', "Please Enter Comp Off Date");
      return;
    }
     if(leaveCode_controller.value.text == 'Comprehensive Leave (COMPL)' && CompOffDate_controller.value.text.isNotEmpty && Datedifference > 1 ){
      Utils.sanckBarSuccess('Comp Off Date!', "You can't apply comprehensive leave more than one day");
      return;
    }
     if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && isTwinBabies_cobtroller.value.text.isEmpty ){
      Utils.sanckBarSuccess('Is Twin Babies!', "Please Enter Is twin Babies");
      return;
    }
     if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyName_controller.value.text.isEmpty ){
      Utils.sanckBarSuccess('Baby Name!', "Please Enter Baby Name");
      return;
    }
     if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyGender_controller.value.text.isEmpty ){
      Utils.sanckBarSuccess('Baby Gender!', "Please Enter Baby Gender");
      return;
    }
     if(leaveCode_controller.value.text == 'Paternity Leave (PAL)' && babyBirthDate_controller.value.text.isEmpty ){
      Utils.sanckBarSuccess('Baby Birth Date!', "Please Enter Baby Birth Date");
      return;
    }
     if(babyLeaveRerason_controller.value.text.isEmpty){
      Utils.sanckBarSuccess('Leave Reason!', "Please Enter Leave Reason");
      return;
    }
    Map data={
      "leaveDetails": [
        {
          "leave_start_date": StartDate_controller.value.text,
          "leave_end_date": EndDate_controller.value.text,
          "leave_code": leave_selection.value.leaveCode,
          "leave_reason": babyLeaveRerason_controller.value.text,
          "is_half_day": isHalfDay.value?1:0,
          "is_short_leave": isShortLeave.value?1:0,
          "short_leave_time": ShortLeaveTiming == ""?"":ShortLeaveTiming.toString(),
          "is_twin_babies": isTwinBabies_cobtroller.value.text=="Yes"?1:0,
          "is_comp_off": leave_selection.value.leaveCode == 'COMPL'?1:0,
          "comp_off_date": CompOffDate_controller.value.text.isEmpty?"":CompOffDate_controller.value.text,
          "baby_name": babyName_controller.value.text.isEmpty?"":babyName_controller.value.text,
          "baby_gender": babyGender_controller.value.text.isEmpty?"":babyGender_controller.value.text,
          "baby_birth_date": babyBirthDate_controller.value.text.isEmpty?"":babyBirthDate_controller.value.text
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
          List<AttendanceLeaveModal> response=Jsonresponse.map((e) =>
              AttendanceLeaveModal.fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condition=="True"){
            employee_leave_mark.value = response;
            Utils.sanckBarSuccess('Success', '${response[0].message}');
            clearField();
            Get.offAllNamed(RoutesName.empMarkLeaveScreen);
          }else{
            employee_leave_mark.value=[];
            Utils.sanckBarError('Error!', '${response[0].message}');
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
    babyLeaveRerason_controller.clear();
  }

  Future<void> refreshList() async {
    getEmployeeLeaveData(filterStatus.value);
  }

  void bindData(AttendanceLeaveModal employee_leave_data_list) {
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
  }
}

