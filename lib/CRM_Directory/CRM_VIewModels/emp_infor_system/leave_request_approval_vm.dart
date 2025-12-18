

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
  final createdBy_filter_controller=TextEditingController();
  final leave_reason_filter_controller=TextEditingController();
  final createdOn_filter_controller=TextEditingController();

  var RegionName_controller = TextEditingController().obs;
  var clusterName_controller = TextEditingController().obs;


  final reject_remarks_controller=TextEditingController();
  final approveReject_controller=TextEditingController().obs;
  final manager_remarks_controller=TextEditingController();

  RxString approveRejectFlag="Approve".obs;

  RxList<LeaveTypeModel> leaveType_data_list=<LeaveTypeModel>[].obs;
  Rx<LeaveTypeModel> leave_selection=LeaveTypeModel().obs;

  RxList<MarkLeaveRequestModal> employee_leave_data_Approval_list=<MarkLeaveRequestModal>[].obs;

  RxList<ClusterModal> clusterGetByEmailList = <ClusterModal>[].obs;
  RxList<ClusterModal> SelectedCluster_list = <ClusterModal>[].obs;
  RxList<RegionWithClusterFilterModal> regionwithclusterGetByEmailList = <RegionWithClusterFilterModal>[].obs;
  RxList<RegionWithClusterFilterModal> SelectedRegion_list = <RegionWithClusterFilterModal>[].obs;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail()??"";
    //getEmployeeLeaveRequestRejectApproveDataGet(filterStatus.value, pageNumber);
    getClustersGetByEmail();
    getLeaveTypeData();
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
            getEmployeeLeaveRequestRejectApproveDataGet(filterStatus.value, pageNumber);

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

  getEmployeeLeaveRequestRejectApproveDataGet(String status, int pageNumber){
    Map data= {
      "leave_id": leaveId_filter_controller.value.text.isNotEmpty?leaveId_filter_controller.value.text:"",
      "email": email,
      "status": status,
      "filter_start_date": StartDate_filter_controller.value.text.isNotEmpty?StartDate_filter_controller.value.text:"",
      "filter_end_date": EndDate_filter_controller.value.text.isNotEmpty?EndDate_filter_controller.value.text:"",
      "filter_leave_code": leaveCode_filter_controller.value.text.isNotEmpty?leaveCode_filter_controller.value.text:"",
      "filter_created_by": createdBy_filter_controller.value.text.isNotEmpty?createdBy_filter_controller.value.text:"",
      "filter_created_on": createdOn_filter_controller.value.text.isNotEmpty?createdOn_filter_controller.value.text:"",
      "leave_reason": leave_reason_filter_controller.value.text.isNotEmpty?leave_reason_filter_controller.value.text:"",
      "region": RegionName_controller.value.text.isNotEmpty?RegionName_controller.value.text:"",
      "clusture": clusterName_controller.value.text.isNotEmpty?clusterName_controller.value.text:"",
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

  getEmployeeLeaveRequestApproveReject(String leaveId,String status, String leaveCode){
    Map data={
      "leave_id": leaveId,
      "status": status=="Approve"?"APPROVED":"REJECTED",
      "approved_by": email,
      "reject_remarks": reject_remarks_controller.value.text.isNotEmpty?reject_remarks_controller.value.text:"",
      "leave_code": leaveCode,
      "approved_from_date": StartDate_controller.value.text.isNotEmpty?StartDate_controller.value.text:"",
      "approved_to_date": EndDate_controller.value.text.isNotEmpty? EndDate_controller.value.text:"",
      "manager_remarks": manager_remarks_controller.value.text.isNotEmpty?manager_remarks_controller.value.text:""
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
            pageNumber=0;
            getEmployeeLeaveRequestRejectApproveDataGet("pending for approval", pageNumber);
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

