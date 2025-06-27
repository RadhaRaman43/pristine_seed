import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Pending_Draft_Quote_Models/Pending_Draft_Quote_model.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class PendingDraftQuoteVm extends GetxController{

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  String email="";
  int pageNumberForQuote = 0;
  int rowsPerPage = 10;
  int total_rows = 0;

  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteVersionController=TextEditingController().obs;
  var filterQuoteSaleCycleController=TextEditingController().obs;
  var accountCodeController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;
  var quoteStatusController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var rh_Approval_controller=TextEditingController().obs;
  var cbh_Approval_controller=TextEditingController().obs;
  var category_Approval_controller=TextEditingController().obs;
  var gm_Approval_controller=TextEditingController().obs;
  var region_name_controller=TextEditingController().obs;
  var cluster_head_value_controller=TextEditingController().obs;
  var createdOnCnontroller=TextEditingController().obs;
  var createdByCnontroller=TextEditingController().obs;

  RxList<Pending_Draft_Quote_Model> PendingDraftQuoteList=<Pending_Draft_Quote_Model>[].obs;
  RxList<String> QuoteStatusList = ["All", "DRAFT", "PENDING FOR APPROVAL", ].obs;
  @override
  Future<void> onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    getPendingDraftQuoteList(pageNumberForQuote);
    super.onInit();
  }

  Future<void>refreshList() async{
    getPendingDraftQuoteList(pageNumberForQuote);
  }


  getPendingDraftQuoteList(int pageNumberForQuote){
    try{
      Map data={
          "filter_quote_id": filterQuoteIdController.value.text.isEmpty?"":filterQuoteIdController.value.text,
          "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isEmpty?"":filterQuoteSaleCycleController.value.text,
          "filter_account_code": accountCodeController.value.text.isEmpty?"":accountCodeController.value.text,
          "filter_account_name": accountNameController.value.text.isEmpty?"":accountNameController.value.text,
          "filter_rh_approval": rh_Approval_controller.value.text.isEmpty?"":rh_Approval_controller.value.text,
          "filter_cbh_approval": cbh_Approval_controller.value.text.isEmpty?"":cbh_Approval_controller.value.text,
          "filter_category_approval": category_Approval_controller.value.text.isEmpty?"":category_Approval_controller.value.text,
          "filter_gm_approval": gm_Approval_controller.value.text.isEmpty?"":gm_Approval_controller.value.text,
          "filter_quote_version": filterQuoteVersionController.value.text.isEmpty?"-1":filterQuoteVersionController.value.text,
          "filter_quote_validity": filterQuoteValidityController.value.text.isEmpty?"":filterQuoteValidityController.value.text,
          "filter_exp_closure_date": filterExpectedClosuredateController.value.text.isEmpty?"":filterExpectedClosuredateController.value.text,
          "filter_quote_status": quoteStatusController.value.text.isEmpty?"":quoteStatusController.value.text,
          "filter_flag": "PENDING & PENDING FOR APPROVAL",
          "filter_product_category": productCategoryController.value.text.isEmpty?"":productCategoryController.value.text,
          "filter_created_by": email,
          "filter_created_on": createdOnCnontroller.value.text.isEmpty?"":createdOnCnontroller.value.text,
          "filter_frontliner_value": "",
          "filter_branch_head_value": region_name_controller.value.text.isEmpty?"":region_name_controller.value.text,
          "filter_zone_head_value": "",
          "filter_clusture_head_value": cluster_head_value_controller.value.text.isEmpty?"":cluster_head_value_controller.value.text,
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
          "page_number": pageNumberForQuote
      };

      loading.value=true;
      _api.QuoteHeaderGetNewApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<Pending_Draft_Quote_Model> response = jsonResponse.map((e) => Pending_Draft_Quote_Model.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumberForQuote==0){
              PendingDraftQuoteList.clear();
            }
            PendingDraftQuoteList.addAll(response);
            print("${PendingDraftQuoteList.length}");
            total_rows=int.parse(PendingDraftQuoteList[0].totalRows!);
          }else {
            PendingDraftQuoteList.value=[];
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
    }catch(e){
      loading.value = false;
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  void clearAllFieldOfQuoteFilter() {
    filterQuoteIdController.value.clear();
    filterQuoteVersionController.value.clear();
    filterExpectedClosuredateController.value.clear();
    filterQuoteValidityController.value.clear();
    accountNameController.value.clear();
    accountCodeController.value.clear();
    rh_Approval_controller.value.clear();
    cbh_Approval_controller.value.clear();
    category_Approval_controller.value.clear();
    gm_Approval_controller.value.clear();
    productCategoryController.value.clear();
    createdOnCnontroller.value.clear();
    cluster_head_value_controller.value.clear();
    filterQuoteSaleCycleController.value.clear();
    createdByCnontroller.value.clear();
    region_name_controller.value.clear();
    quoteStatusController.value.clear();


  }

}