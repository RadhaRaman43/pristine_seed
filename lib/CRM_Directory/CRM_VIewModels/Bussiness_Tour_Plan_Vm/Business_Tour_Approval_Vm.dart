import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessTourApprovalModel.dart';
import '../../CRM_Repository/BusinessTourPlan_Repository/business_tour_plan_repo.dart';

class BusinessTourApprovalVm extends GetxController{

  final _api = BusinessTourPlanRepo();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;

  RxList<BusinessTourApprovalModel> BusinessTourApprovalList = <BusinessTourApprovalModel>[].obs;

  var filterCreatedByController = TextEditingController().obs;
  var filterTourIdController = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    clearAllFieldOfFilter();
    getBusinessTourApprovalListData(pageNumber);
    super.onInit();
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getBusinessTourApprovalListData(pageNumber);
  }

  void clearAllFieldOfFilter() {
    print("Clear Filed");
    filterCreatedByController.value.clear();
    filterTourIdController.value.clear();

  }



  getBusinessTourApprovalListData(int page_no) {
    try {
      Map data = {
        "filter_created_by": filterCreatedByController.value.text.isEmpty?"":filterCreatedByController.value.text,
        "email_id": email,
        "approve_status": "PENDING FOR APPROVAL",
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no,
        "tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,

      };
      loading.value = true;
      _api.BusinessTourPlanApprovalGet(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BusinessTourApprovalModel> response =
            jsonResponse.map((e) => BusinessTourApprovalModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if (page_no == 0) {
                BusinessTourApprovalList.clear();
              }
              BusinessTourApprovalList.addAll(response);
              print('listSize.....${BusinessTourApprovalList.length}');
              total_rows = int.parse(BusinessTourApprovalList[0].totalRows!.toString());

            } else {
              loading.value = false;
              BusinessTourApprovalList.value = [];
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