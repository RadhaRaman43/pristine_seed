

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
import '../../CRM_Models/emp_infor_modal/mark_leave_request_modal.dart';
import '../../CRM_Models/emp_infor_modal/short_leave_modal.dart';
import '../../CRM_Repository/emp_informa_repository/emp_infor_repo.dart';
import '../../CRM_Repository/emp_informa_repository/emp_mark_leave_request_repo.dart';

class LeaveRequestApprovalVm extends GetxController{
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

  RxList<String> approveRejectList=["Approve", "Reject"].obs;

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
  final leaveCode_filter_controller=TextEditingController();
  final leaveId_filter_controller=TextEditingController();


  final reject_remarks_controller=TextEditingController();
  final approveReject_controller=TextEditingController().obs;
  final manager_remarks_controller=TextEditingController();
  RxString approveRejectFlag="Approve".obs;

  RxList<LeaveTypeModel> leaveType_data_list=<LeaveTypeModel>[].obs;
  Rx<LeaveTypeModel> leave_selection=LeaveTypeModel().obs;

  RxList<MarkLeaveRequestModal> employee_leave_data_Approval_list=<MarkLeaveRequestModal>[].obs;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail()??"";
    getEmployeeLeaveRequestRejectApproveDataGet(filterStatus.value, pageNumber);
    getLeaveTypeData();
  }




  getEmployeeLeaveRequestRejectApproveDataGet(String status, int pageNumber){
    Map data= {
      "leave_id": "",
      "email": email,
      "status": status,
      "filter_start_date": "",
      "filter_end_date": "",
      "filter_leave_code": "",
      "filter_created_by": "",
      "leave_reason": "",
      "pageNumber": pageNumber,
      "rowsPerPage": rowsPerPage
    };

    print(data);
    loading.value=true;
    _api.employeeLeaveRequestRejectApproveDataGetApiHit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<MarkLeaveRequestModal> response=Jsonresponse.map((e) =>
              MarkLeaveRequestModal.fromJson(e)).toList();
          print("response...${response.length}");
          if(response!=null && response.length>0 && response[0].condition?.toLowerCase()=="true"){
            print("hhh...${employee_leave_data_Approval_list.value.length}");
            if(pageNumber==0){
              employee_leave_data_Approval_list.clear();
            }
            employee_leave_data_Approval_list.addAll(response);
            total_rows=int.parse(employee_leave_data_Approval_list[0].rowCount!.toString());
            //employee_leave_data_Approval_list.value = response;
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

  getEmployeeLeaveRequestApproveReject(String leaveId){
    Map data={
      "leave_id": leaveId,
      "status": "pending for approval",
      "approved_by": "",
      "reject_remarks": reject_remarks_controller.value.text.isNotEmpty?reject_remarks_controller.value.text:"",
      "leave_code": "",
      "approved_from_date": "",
      "approved_to_date": "",
      "manager_remarks": ""
    } ;

    print(data);
    loading.value=true;
    _api.employeeLeaveRequestApproveRejectApiHit(data, sessionManagement).then((value) {
      print(value);
      final Jsonresponse=json.decode(value);
      try{
        if(Jsonresponse is List){
          List<MarkLeaveRequestModal> response=Jsonresponse.map((e) =>
              MarkLeaveRequestModal.fromJson(e)).toList();
          if( response[0].condition?.toLowerCase()=="true"){
          Utils.showToastification("Success", response[0].message.toString());
          }else{
            Utils.showErrorToastification("Error Message!", response[0].message.toString());
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



  Future<void> refreshApprovalList() async{
    pageNumber=0;
    getEmployeeLeaveRequestRejectApproveDataGet(filterStatus.value, pageNumber);
  }


}

