

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/sales_advise_modal/all_sales_advise_list_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesAdviseAllListVm extends GetxController{
  String filterFlag="";
  SalesAdviseAllListVm([String? flag]){
    this.filterFlag = flag??"";
  }

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  String userType = "";
  String isAdminWritePermission = "";
  int rowsPerPage = 10;
  int total_rows = 0;
  int pageNumber = 0;
 var filterExpectedClosuredateController=TextEditingController().obs;
 var salesAdviseIdController=TextEditingController().obs;
 var filterQuoteValidityController=TextEditingController().obs;
 var salesAdviseStatusController=TextEditingController().obs;
 var accountNameController=TextEditingController().obs;
 var accountCodeController=TextEditingController().obs;
 var branch_head_value_controller=TextEditingController().obs;
 var cluster_head_value_controller=TextEditingController().obs;
 var productCategoryController=TextEditingController().obs;
 var createdOnCnontroller=TextEditingController().obs;

 RxString quoteValidityStartToEnd="".obs;
 RxString extClosureStartToEnd="".obs;
 RxString createdOnStartToEnd="".obs;
  RxList<String> salesAdviseStatusList = ["Draft", "Completed"].obs;

  RxList<AllSalesAdviseModal> salesAdviseList=<AllSalesAdviseModal>[].obs;

  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    getSaleCycleProductByIdList(pageNumber);
    // TODO: implement onInit
    super.onInit();
  }

  getSaleCycleProductByIdList(int pageNumber) {
    Map data = {
      "filter_sales_advice_id": salesAdviseIdController.value.text.isNotEmpty?salesAdviseIdController.value.text:"",
      "filter_quote_id": "",
      "filter_sales_cycle_id": "",
      "filter_account_code": accountNameController.value.text.isNotEmpty?accountNameController.value.text:"",
      "filter_account_name": accountCodeController.value.text.isNotEmpty?accountCodeController.value.text:"",
      "filter_rh_approval": "",
      "filter_cbh_approval": "",
      "filter_category_approval": "",
      "filter_gm_approval": "",
      "filter_quote_version": -1,
      "filter_quote_validity": quoteValidityStartToEnd.value,
      "filter_exp_closure_date": extClosureStartToEnd.value,
      "filter_sales_advice_status": salesAdviseStatusController.value.text.isNotEmpty?salesAdviseStatusController.value.text:"",
      "filter_flag": filterFlag,
      "filter_product_category": productCategoryController.value.text.isNotEmpty?productCategoryController.value.text:"",
      "filter_created_by": email,
      "filter_created_on": createdOnStartToEnd.value,
      "filter_frontliner_value": "",
      "filter_branch_head_value": branch_head_value_controller.value.text.isNotEmpty?branch_head_value_controller.value.text:"",
      "filter_zone_head_value": cluster_head_value_controller.value.text.isNotEmpty?cluster_head_value_controller.value.text:"",
      "filter_clusture_head_value": "",
      "filter_spr_no": "",
      "filter_item_code": "",
      "filter_item_name": "",
      "filter_quantity": "",
      "filter_gm_per": "",
      "filter_bm_per": "",
      "filter_sales_credit": "",
      "filter_lsp": "",
      "filter_map": "",
      "filter_btp": "",
      "filter_standard_cost": "",
      "row_per_page": rowsPerPage,
      "page_number": pageNumber
    };
    loading.value = true;
    _api.salesAdviceHeaderGetNewApiHit(data, sessionManagement).then(
          (onValue) {
        try {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<AllSalesAdviseModal> response = jsonResponse
                .map((e) => AllSalesAdviseModal.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition?.toLowerCase() == "true") {
              if (pageNumber == 0) {
                salesAdviseList.clear();
              }
              salesAdviseList.addAll(response);
              total_rows = int.parse(salesAdviseList[0].totalRows!);
            } else {
              salesAdviseList.value = [];
            }
          }
        } catch (e) {
          print(e);
        } finally {
          loading.value = false;
        }
      },
    ).onError(
          (error, stackTrace) {
        print('sjdbbsidbi${error}');
      },
    ).whenComplete(() {
      this.loading.value = false;
    });
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getSaleCycleProductByIdList(pageNumber);
  }

  void clearAllField() {
     filterExpectedClosuredateController.value.clear();
     salesAdviseIdController.value.clear();
     filterQuoteValidityController.value.clear();
     salesAdviseStatusController.value.clear();
     accountNameController.value.clear();
     accountCodeController.value.clear();
     branch_head_value_controller.value.clear();
     cluster_head_value_controller.value.clear();
     productCategoryController.value.clear();
     createdOnCnontroller.value.clear();
     extClosureStartToEnd.value="";
     quoteValidityStartToEnd.value="";
     createdOnStartToEnd.value="";

  }
}