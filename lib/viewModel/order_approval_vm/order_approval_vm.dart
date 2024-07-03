import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/repository/order_approval_repository/order_approval_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/api_default_entity.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../../models/order_model/order_approval_model.dart';
import '../../models/order_model/order_header_create_model.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class OrderApprovalViewModel extends GetxController{
  final _api=OrderApprovalRepository();

  RxBool loading=false.obs;
  bool isButtonEnabled = true;
  SessionManagement sessionManagement= SessionManagement();
  var filter_date_controller = TextEditingController();
  var employee_controller = TextEditingController();
  var qty_controller = TextEditingController();
  var remarks_controller = TextEditingController();
  String email="";
  String selection_type = "";
  List<OrderApprovalModel> approver_list_data = [];
  List<EmpMasterResponse> employess_List = [];

  String pending_count = "0", like_count = "0", dislike_count = "0";

  RxList<OrderHeaderCreateModel> order_detail_list = <OrderHeaderCreateModel>[].obs;


  @override
  void onInit() async  {
    email=await sessionManagement.getEmail()??"";
    getEmployeeMasterApi("");

  }


  getEmployeeMasterApi(String filter_login) {
    this.loading.value = true;
    Map data = {'email_id': email};
    _api.getEmployeeTeam(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0]?.condition.toString() == "True") {
          employess_List = emp_masterResponse;
        } else {
          employess_List = [];
        }
      } catch (e) {
         loading.value = false;
        employess_List = [];
      }finally{
         loading.value = false;
      }
    }).onError((error, stackTrace) {
      employess_List = [];
      Utils.showErrorToastification('Api Exception onError', error.toString());
    }).whenComplete(() {
      loading.value = false;
      this.getApprovalList('');
    });
  }


  getApprovalList(String flag) {
    this.loading.value = true;
    Map data = {
      'email_id': email,
      'filter_date': filter_date_controller.text.toString(),
      'filter_created_by': flag,
      'approve_status': selection_type
    };
    _api.orderApprovalListApiHit(data, sessionManagement).then((value) {

        final jsonResponse = json.decode(value);
        print(value);
        try {
        if (jsonResponse is List) {
          List<OrderApprovalModel> approver_list =
          jsonResponse.map((data) => OrderApprovalModel.fromJson(data)).toList();
          if (approver_list[0].condition.toString() == "True") {
            approver_list_data = approver_list;
            pending_count = approver_list_data[0].pendingCount!;
            like_count = approver_list_data[0].approvedCount!;
            dislike_count = approver_list_data[0].rejectedCount!;
          } else {
            approver_list_data = [];
            pending_count = approver_list[0].pendingCount!;
            like_count = approver_list[0].approvedCount!;
            dislike_count = approver_list[0].rejectedCount!;
          }
        }
      } catch (e) {
        approver_list_data = [];
        pending_count = "0";
        like_count = "0";
        dislike_count = "0";
      }
    }).onError((error, stackTrace) {
      approver_list_data = [];
      pending_count = "0";
      like_count = "0";
      dislike_count = "0";
      Utils.showErrorToastification('Api Exception onError', error.toString());
    }).whenComplete(()  {
      this.loading.value = false;
      if(flag=='GOTO_LIST'){
        Get.offAllNamed(RoutesName.order_approval_screen);
      }
    });
  }


  getOrderHeaderDetails(String orderNo){
    order_detail_list.value=[];
    loading.value = true;
    Map<String ,String> data={
      'order_no':orderNo,
      'email_id':email
    };
    _api.orderDetailGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        print(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            loading.value = false;
            order_detail_list.value=response;
            Utils.showToastification('Success Message!', response[0].message.toString());
            //Get.offAllNamed(RoutesName.orderItemCategoryScreen);
            Get.toNamed(RoutesName.order_approval_view_cart_screen);

          } else {
            loading.value = false;
            Utils.showErrorToastification('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          Utils.showErrorToastification('API Response Error', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
    });
  }


  orderApproverItemLineInsert(String orderNo,String itemNo,int qty,String tag) {
    if (!isButtonEnabled) return; // Do not proceed if the button is disabled
    isButtonEnabled = false;
    if(tag=='ADD'){
      qty+=1;
    }
    else if(tag=='REMOVE'){
      qty-=1;
    }

    Map<String, String> data ={
      "order_no": orderNo,
      "item_no": itemNo,
      "qty":qty.toString() ?? '',
      "email_id":email
    };
    loading.value = true;
    _api.orderApproverLineInsert(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            loading.value = false;
            isButtonEnabled = true;
            order_detail_list.value=response;
          } else {
            loading.value = false;
            isButtonEnabled = true;
            Utils.showErrorToastification('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          isButtonEnabled = true;
          Utils.showErrorToastification('API Response Error', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        isButtonEnabled = true;
        printError();
        Utils.showErrorToastification('Exception Message!', e.toString());
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      isButtonEnabled = true;
    }).whenComplete(()  {
      this.loading.value = false;

    });
  }


  markApproveReject(String document_no, String remarks,String approve_status) {
    this.loading.value = true;
    Map data = {
      'order_no': document_no,
      'approve_status': approve_status,
      'approve_by': email,
      'reject_reason':remarks
    };
    _api.markApproveReject(data, sessionManagement).then((value) {
      try {
        print(value);
        List<ApiDefaultEntity> approver_list = (json.decode(value) as List)
            .map((i) => ApiDefaultEntity.fromJson(i))
            .toList();
        //   print(approver_list);
        if (approver_list[0].condition == "True") {
          this.loading.value = false;
          Get.offAllNamed(RoutesName.order_approval_screen);
        //  this.getApprovalList('GOTO_LIST');
          Utils.showToastification('Message : ', approver_list[0].message);
        } else {
          this.loading.value = false;
          Utils.showErrorToastification('Message : ', approver_list[0].message);
        }
      } catch (e) {
        this.loading.value = false;
        Utils.showErrorToastification('Exception : ', e.toString());
      }
    }).onError((error, stackTrace) {
      this.loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }



}