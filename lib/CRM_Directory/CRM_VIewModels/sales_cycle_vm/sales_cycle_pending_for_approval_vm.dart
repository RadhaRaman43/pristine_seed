

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesCyclePendingForApprovalVm extends GetxController{

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxList<SalesCycleModal> saleCyclePendingForApprovalList = <SalesCycleModal>[].obs;
  RxList<String> SaleCycleStatusList =
      ["All", "Suspect", "Prospect", "Propose"].obs;
  RxList<String> customerNeedIdentityList = ["Yes", "No"].obs;

  var createdOnCnontroller = TextEditingController().obs;
  RxString createdOnStartToEnd = "".obs;
  RxString extClosureStartToEnd = "".obs;
  RxString quoteValidityStartToEnd = "".obs;
  var isCommitController = TextEditingController().obs;
  var branch_head_value_controller = TextEditingController().obs;
  var cluster_head_value_controller = TextEditingController().obs;
  var createdByController = TextEditingController().obs;
  var district_controller = TextEditingController().obs;
  var postalCodeController = TextEditingController().obs;
  var companyProfileTypeController = TextEditingController().obs;
  var filterTask_Id_controller = TextEditingController().obs;
  var accountCodeController = TextEditingController().obs;
  var accountNameController = TextEditingController().obs;
  var saleCycleController = TextEditingController().obs;
  var productCategoryController = TextEditingController().obs;
  var purchaseProcessController = TextEditingController().obs;
  var salesCycleOwnerController = TextEditingController().obs;
  var solutionAcceptedController = TextEditingController().obs;
  var proposedSolutionController = TextEditingController().obs;
  var SaleCycleStatusController = TextEditingController().obs;
  var ApprovalStatusController = TextEditingController().obs;
  var filterExpectedClosuredateController = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    getsalesCycleData(pageNumber);
  }

  getsalesCycleData(
      int page_no) {
    try {
      Map data = {
        "filter_sales_cycle_id":saleCycleController.value.text.isEmpty?"" : saleCycleController.value.text,
        "filter_task_id": filterTask_Id_controller.value.text.isEmpty
            ? ""
            : filterTask_Id_controller.value.text,
        "filter_account_code": accountCodeController.value.text.isEmpty
            ? ""
            : accountCodeController.value.text,
        "filter_account_name": accountNameController.value.text.isEmpty
            ? ""
            : accountNameController.value.text,
        "filter_sales_cycle_owner": salesCycleOwnerController.value.text.isEmpty
            ? (isAdminWritePermission=="1"?"":email): salesCycleOwnerController.value.text
            ,
        "filter_product_category": productCategoryController.value.text.isEmpty
            ? ""
            : productCategoryController.value.text,
        "filter_purchase_process": purchaseProcessController.value.text.isEmpty
            ? ""
            : purchaseProcessController.value.text,
        "filter_proposed_solution":
        proposedSolutionController.value.text.isEmpty
            ? ""
            : proposedSolutionController.value.text,
        "filter_expected_closure_date": extClosureStartToEnd.value.isEmpty
            ? ""
            : extClosureStartToEnd.value,
        "filter_sales_cycle_status":
        SaleCycleStatusController.value.text.isEmpty ||
            SaleCycleStatusController.value.text == 'All'
            ? ''
            : SaleCycleStatusController.value.text,
        "filter_sales_cycle_approval_status":"PENDING FOR APPROVAL",
        "filter_sales_cycle_quote_accepted":"",
        "is_commit": isCommitController.value.text.isEmpty
            ? -1
            : (isCommitController.value.text == "Yes" ? 1 : 0),
        "filter_solution_accepted":
        solutionAcceptedController.value.text.isEmpty
            ? -1
            : (solutionAcceptedController.value.text == "Yes" ? 1 : 0),
        "filter_created_by": createdByController.value.text.isEmpty
            ? ""
            : createdByController.value.text,
        "filter_approved_by": "",
        "filter_created_on":
        createdOnStartToEnd.value.isEmpty ? "" : createdOnStartToEnd.value,
        "filter_company_profile_type":
        companyProfileTypeController.value.text.isEmpty
            ? ""
            : companyProfileTypeController.value.text,
        "filter_postal_code": postalCodeController.value.text.isEmpty
            ? ""
            : postalCodeController.value.text,
        "filter_district": district_controller.value.text.isEmpty
            ? ""
            : district_controller.value.text,
        "filter_frontliner_value": "",
        "filter_branch_head_value":
        branch_head_value_controller.value.text.isEmpty
            ? ""
            : branch_head_value_controller.value.text,
        "filter_zone_head_value": "",
        "filter_clusture_head_value":
        cluster_head_value_controller.value.text.isEmpty
            ? ""
            : cluster_head_value_controller.value.text,
        "row_per_page": rowsPerPage,
        "page_number": page_no
      };
      loading.value = true;
      _api.salesCycleMstGetApihit(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<SalesCycleModal> response =
            jsonResponse.map((e) => SalesCycleModal.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              print('listSize.....${saleCyclePendingForApprovalList.length}');
              loading.value = false;
              if (page_no == 0) {
                saleCyclePendingForApprovalList.clear();
              }
              saleCyclePendingForApprovalList.addAll(response);
              total_rows = int.parse(saleCyclePendingForApprovalList[0].totalRows!);
            } else {
              loading.value = false;
              saleCyclePendingForApprovalList.value = [];
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
    saleCycleController.value.clear();
    salesCycleOwnerController.value.clear();
    filterTask_Id_controller.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    salesCycleOwnerController.value.clear();
    productCategoryController.value.clear();
    purchaseProcessController.value.clear();
    companyProfileTypeController.value.clear();
    isCommitController.value.clear();
    solutionAcceptedController.value.clear();
    proposedSolutionController.value.clear();
    postalCodeController.value.clear();
    district_controller.value.clear();
    branch_head_value_controller.value.clear();
    cluster_head_value_controller.value.clear();
    createdByController.value.clear();
    filterExpectedClosuredateController.value.clear();
    createdOnCnontroller.value.clear();
    createdOnStartToEnd.value = "";
    extClosureStartToEnd.value = "";
    SaleCycleStatusController.value.text = 'All';
    ApprovalStatusController.value.text = 'All';
  }


  Future<void> refreshList() async {
    pageNumber = 0;
    getsalesCycleData(pageNumber);
  }

}