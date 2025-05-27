import 'dart:convert';
import 'dart:io';
import 'dart:math';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../main.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/Address_Master_Model/address_master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/Task_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/task_category_model.dart';
import '../../CRM_Models/sale_cycle_modal/ItemMasterSalesId_Model.dart';
import '../../CRM_Models/sale_cycle_modal/Item_qoute_with_report_modal.dart';
import '../../CRM_Models/sale_cycle_modal/SalesCycleById_Model.dart';
import '../../CRM_Models/sale_cycle_modal/approval_person_model.dart';
import '../../CRM_Models/sale_cycle_modal/item_quote_modal.dart';
import '../../CRM_Models/sale_cycle_modal/productCategoryWiseAmtModel.dart';
import '../../CRM_Models/sale_cycle_modal/quoteWonModel.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_approve_reject_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_header_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_information_modal.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_update_status_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesCycleVm extends GetxController{

  static String _displayCustomerNeedIdentityStatusForOption(String option) => option;

/*  static String _displayDecisionMakerForOption(String option) => option;

  static String _displayPurchaseProcessForOption(CustomList option) => option.value!;

  static String _displayPurchaseTimeFrameForOption(CustomList option) => option.value!;


  static String _displayUpdateSalesCycleForOption(String option) => option;*/

  Size size=Get.size;

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  var selectedItem = (-1).obs;
  RxString accountCode="".obs;
  RxString contactCode="".obs;
  RxString ProductCategoryCode="".obs;
  RxString Total_Budget_Amount="0".obs;
  RxString Total_Expected_Amount="0".obs;
  RxBool loading=false.obs;
  String email="";
  String consigneeId="";
  RxString FromPage="Sales".obs;
  RxString quoteApprovalPage="".obs;
  int pageNumber = 0;
  int pageNumberForItem = 0;
  int pageNumberForQuote = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  int total_rows_items = 0;
  int total_rows_sales = 0;
  int total_rows_sale_cyle_item = 0;
  RxBool isDeleteBtn=true.obs;
  RxBool isApprovalVisible=false.obs;
  RxBool isPropectfieldVisible=false.obs;
  RxBool ischackValueofSolution=false.obs;
  RxBool isApprove=false.obs;
  RxBool isChooseQuote=false.obs;
  RxBool isReject=false.obs;
  var isCheck = (-1).obs;
  RxBool BusinessTerm=false.obs;
  RxString filter="Sales cycle".obs;
  RxList<SalesCycleModal> saleCycleList=<SalesCycleModal>[].obs;
  RxList<ProductCategoryWiseAmtModel> budgetAmountList=<ProductCategoryWiseAmtModel>[].obs;
  RxList<SalesCycleQuoteHeaderModal> quoteList=<SalesCycleQuoteHeaderModal>[].obs;
  RxList<QuoteWonModel> quoteWonList=<QuoteWonModel>[].obs;
  RxList<getApprovalPersonMadol> approvalPersonList=<getApprovalPersonMadol>[].obs;
  RxList<SalesCycleQuoteInformationModal> quoteHeaderdata=<SalesCycleQuoteInformationModal>[].obs;
  RxList<QuoteItems> quoteLinedata=<QuoteItems>[].obs;
  RxList<ItemQuoteModal> itemMstGetByQuoteIdList=<ItemQuoteModal>[].obs;
  RxList<ItemMasterBySalesId_Model> itemMstGetBySalesIdList=<ItemMasterBySalesId_Model>[].obs;
  RxList<SalesCycleUpdateStatusModal> quoteLineCreate=<SalesCycleUpdateStatusModal>[].obs;
  RxList<SalesCycleQuoteHeaderModal> Quote_Selected_list=<SalesCycleQuoteHeaderModal>[].obs;
  RxList<ItemCategoryMstModel> productCategoryList=<ItemCategoryMstModel>[].obs;
  RxList<ItemCategoryMstModel> itemCategorySelectedlist = <ItemCategoryMstModel>[].obs;
  RxList<ItemQouteWithReportModal> itemQuoteReportList = <ItemQouteWithReportModal>[].obs;
  RxList<AddressMasterModel> address_master_list = <AddressMasterModel>[].obs;
  RxList<CustomList> get_PurchaseProcess_list=<CustomList>[].obs;
  RxList<CustomList> get_PurchaseTimeFrame_list=<CustomList>[].obs;
  RxList<SalesCycleByIdModel> get_SalesCycleProductById_List=<SalesCycleByIdModel>[].obs;


  var closureDateController=TextEditingController().obs;
  var budgetAmountController=TextEditingController().obs;
  var expectedAmountController=TextEditingController().obs;
  var rejectReasonController=TextEditingController().obs;


  var customerNeedIdetityController=TextEditingController().obs;
  var solutionAcceptedController=TextEditingController().obs;
  var proposedSolutionController=TextEditingController().obs;
  var solutionRejectedRemarkController=TextEditingController().obs;
  var accountNameController=TextEditingController().obs;
  var saleCycleController=TextEditingController().obs;
  var contactNameController=TextEditingController().obs;
  var quoteValidityController=TextEditingController().obs;
  var expectedClosuredateController=TextEditingController().obs;
  var contactQuoteCommitController=TextEditingController().obs;

  var QuoteSubmittedController=TextEditingController().obs;
  var ConfirmDecisionDateController=TextEditingController().obs;
  var ConfirmExpectedRevenueController=TextEditingController().obs;

  var updatecontactpersonNameController=TextEditingController().obs;
  var activeController=TextEditingController().obs;
  var quoteStatusController=TextEditingController().obs;
  var quoteCommitController=TextEditingController().obs;
  var SaleCycleStatusController=TextEditingController().obs;
  var ApprovalStatusController=TextEditingController().obs;
  var rejectreasonQuoteController=TextEditingController().obs;
  var updateQuoteAccetedCycleController=TextEditingController().obs;
  var competitorNameController=TextEditingController().obs;
  var selectedQuotationIdController=TextEditingController().obs;
  var quoteRejectReasonController=TextEditingController().obs;
  var updateExpectedClosureDateController=TextEditingController().obs;
  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteStatusController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  var updateQuoteValidityController=TextEditingController().obs;
  var identifyDecisionMakerController=TextEditingController().obs;
  var saleCycleCommitController=TextEditingController().obs;
  var purchaseProcessController=TextEditingController().obs;
  var purchasTimeFrameController=TextEditingController().obs;
  var salesCycleOwnerController=TextEditingController().obs;
  var updatesalesCycleBudgetAmountController=TextEditingController().obs;

  RxString saleCycleOwnerSelected="".obs;
  RxBool showUpdateBtnApproveQuoteItem=false.obs;
  RxBool showBranchHead=false.obs;
  RxBool showClusterHead=false.obs;
  RxBool showGeneralManager=false.obs;

  // todo update quote controller
  var updateItemDescriptionController=TextEditingController().obs;
  var updateItemDescription2Controller=TextEditingController().obs;
  var updateManualPriceController=TextEditingController().obs;
  var updateDiscountPerController=TextEditingController().obs;
  var qtyUpdateLineController=TextEditingController().obs;
  var updateUnitPriceController=TextEditingController().obs;
  var updateDiscountAmountController=TextEditingController().obs;
  var salesCreditPerContoller=TextEditingController().obs;
  var updateAmountController=TextEditingController().obs;
  var gmDiscountPerContoller=TextEditingController().obs;
  var updateTaxPerLineController=TextEditingController().obs;
  var updateTaxAmountLineController=TextEditingController().obs;
  var updateGrossAmountLineController=TextEditingController().obs;
  var productCategoryController=TextEditingController().obs;

  //todo update business terms
  var installationChargesController=TextEditingController().obs;
  var otherChargesController=TextEditingController().obs;
  var warrentyPeriodController=TextEditingController().obs;
  var deliveryWeeksController=TextEditingController().obs;
  var advncPaymentPerController=TextEditingController().obs;
  var quoteTotAmountController=TextEditingController().obs;
  var advncPaymentAmountController=TextEditingController().obs;
  var finalAmountController=TextEditingController().obs;
  var pendingAmountController=TextEditingController().obs;
  var quoteRemarkController=TextEditingController().obs;

  //todo Item list
  var itemCodeController=TextEditingController().obs;
  var nameController=TextEditingController().obs;
  var categoryNameController=TextEditingController().obs;
  var categoryCodeController=TextEditingController().obs;
  var gstGrpCodeController=TextEditingController().obs;
  var hsnCodeController=TextEditingController().obs;

  //todo Sales Item list
  var itemSalesCodeController=TextEditingController().obs;
  var nameSalesController=TextEditingController().obs;
  var categoryNameSalesController=TextEditingController().obs;
  var categoryCodeSalesController=TextEditingController().obs;
  var gstGrpCodeSalesController=TextEditingController().obs;
  var hsnCodeSalesController=TextEditingController().obs;

  //todo shipping address
  var shippingController=TextEditingController().obs;
  var shippingAddress2Controller=TextEditingController().obs;
  var Shipping_PostCode_Controller=TextEditingController().obs;
  var Shipping_City_Controller=TextEditingController().obs;
  var Shipping_District_Controller=TextEditingController().obs;
  var Shipping_State_Controller=TextEditingController().obs;
  var Shipping_phone_Controller=TextEditingController().obs;
  var Shipping_email_Controller=TextEditingController().obs;


  //todo update sales cycle product competitor name, loss reason etc ...
  var updateCompetitorNameProductController=TextEditingController().obs;
  var updateCompetitorPriceProductController=TextEditingController().obs;
  var updateLossReasonProductController=TextEditingController().obs;

  //todo update quote item list data on approval page
  var bmDiscountPerController=TextEditingController().obs;



  RxInt index=0.obs;
  final qtyFocusNode = FocusNode();
  RxString quoteId="".obs;
  RxString salesCycleId="".obs;
  RxList<String> customerNeedIdentityList =["Yes", "No"].obs;
  RxList<String> quoteAcceptedList =["WON", "LOSS"].obs;
  RxList<String> statusList =["Approve", "Reject"].obs;
  RxList<String> SaleCycleStatusList =["All", "Suspect", "Prospect", "Propose"].obs;
  RxList<String> ApprovalStatusList =["All", "PENDING", "PENDING FOR APPROVAL", "APPROVED", "REJECTED"].obs;

  RxBool ischangeNeedIdentity=false.obs;
  RxBool ischangesolutionAccepted=false.obs;
  RxBool isnextbtn=false.obs;

  @override
  Future<void> onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    getsalesCycleData(pageNumber, "", "",'');
    itemCategorySelectedlist.value=[];
    super.onInit();

  }

  Future<void>refreshList() async{
    getsalesCycleData(pageNumber, "", "",'');
  }


  void toggleCheckbox(int index) {
    var item = itemMstGetByQuoteIdList[index];
    print("Check1");
    item.isSelected = item.isSelected == 1 ? 0 : 1;
    print("Check2");
    if(item.isSelected==1)
      {
        quoteLineCreateFunction(itemMstGetByQuoteIdList[index].itemCode!, "CheckBox");
        itemMstGetByQuoteIdList[index] = item;
      }
    else{
      quoteLineDeleteApiHit(itemMstGetByQuoteIdList[index].lineNo!, "fromCheckBox");
      itemMstGetByQuoteIdList[index] = item;
    }
   // itemMstGetByQuoteIdList[index] = item;

  }

  void toggleSalesCheckbox(int index) {
    var item = itemMstGetBySalesIdList[index];
    item.isSelected = item.isSelected == 1 ? 0 : 1;
    if(item.isSelected==1)
    {
      SalesCycleLineCreateApiHit(itemMstGetBySalesIdList[index].itemCode!,
          salesCycleId.value, 0,"Add");
      itemMstGetBySalesIdList[index] = item;
    }
    else{
      SalesCycleLineDeleteApiHit(itemMstGetBySalesIdList[index].lineNo!, salesCycleId.value);
      itemMstGetBySalesIdList[index] = item;
    }
    // itemMstGetByQuoteIdList[index] = item;

  }



  getsalesCycleData(int page_no, String saleCycleId, String flag, String fromPage){
    FromPage.value = fromPage;
    print("frompage${FromPage.value}");
    print("frompage${fromPage}");
    try{
      Map data={
        "filter_sales_cycle_id": saleCycleId.isNotEmpty?saleCycleId:saleCycleController.value.text,
        "filter_task_id": "",
        "filter_account_name": accountNameController.value.text.isEmpty?"":accountNameController.value.text,
        "filter_contact_name": contactNameController.value.text.isEmpty?'':contactNameController.value.text,
        "filter_sales_cycle_status": SaleCycleStatusController.value.text.isEmpty || SaleCycleStatusController.value.text == 'All'?'':SaleCycleStatusController.value.text,
        "filter_sales_cycle_approval_status": ApprovalStatusController.value.text.isEmpty || ApprovalStatusController.value.text == 'All'?'':ApprovalStatusController.value.text,
        "filter_created_by": email,
        "filter_approved_by": "",
        "row_per_page": rowsPerPage,
        "page_number": page_no
  };
      loading.value=true;
      _api.salesCycleMstGetApihit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleModal> response = jsonResponse.map((e) => SalesCycleModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            print('listSize.....${saleCycleList.length}');
            loading.value = false;
            if(page_no==0){
              saleCycleList.clear();
            }
            saleCycleList.addAll(response);
            print('listSize.....${saleCycleList.length}');
            total_rows_sales=int.parse(saleCycleList[0].totalRows!);
            if(flag=="ViewHeader"){
              Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
                saleCycleList[0].isCustomerNeedIdentify==0?customerNeedIdetityController.value.text="No":customerNeedIdetityController.value.text="Yes";
                saleCycleList[0].isSolutionAccepted==0? solutionAcceptedController.value.text="No":solutionAcceptedController.value.text="Yes";
                proposedSolutionController.value.text=saleCycleList[0].proposedSolution==null?"":saleCycleList[0].proposedSolution.toString();
                solutionRejectedRemarkController.value.text=saleCycleList[0].rejectReason.toString().isNotEmpty?saleCycleList[0].rejectReason.toString():"";
                closureDateController.value.text=saleCycleList[0].estClosureDate.toString();
                saleCycleList[0].isDecisionMaker==0?identifyDecisionMakerController.value.text="No":identifyDecisionMakerController.value.text="Yes";
                saleCycleList[0].commit==0?saleCycleCommitController.value.text="No":saleCycleCommitController.value.text="Yes";
                saleCycleList[0].quoteSubmitted==0?QuoteSubmittedController.value.text="No":QuoteSubmittedController.value.text="Yes";
                saleCycleList[0].confirmDecisionDate==0?ConfirmDecisionDateController.value.text="No":ConfirmDecisionDateController.value.text="Yes";
                saleCycleList[0].confirmExpectedRevenue==0?ConfirmExpectedRevenueController.value.text="No":ConfirmExpectedRevenueController.value.text="Yes";
                purchaseProcessController.value.text=saleCycleList[0].purchaseProcess==null?"":saleCycleList[0].purchaseProcess.toString();
                purchasTimeFrameController.value.text=saleCycleList[0].purchaseTimeFrame==null?"":saleCycleList[0].purchaseTimeFrame.toString();
                budgetAmountController.value.clear();
                expectedAmountController.value.clear();
                productCategoryController.value.clear();

                if(customerNeedIdetityController.value.text=="Yes"){
                  ischangeNeedIdentity.value=true;
                }
                else{
                  ischangeNeedIdentity.value=false;
                }

              if(solutionAcceptedController.value.text=="Yes"){
                ischangesolutionAccepted.value=true;
              }
              else{
                ischangesolutionAccepted.value=false;
              }
              print("change .... ${ischangeNeedIdentity.value} && ${ischangesolutionAccepted.value}");

            }
            if(saleCycleList[0].salesCycleStatus=="Suspect") {
              itemCategorySelectedlist.value = [];
              getItemCategoryMstApi(saleCycleList[0].salesCycleId! ,saleCycleList[0].taskId! );
              ProductCategoryWiseAmtGet(0, saleCycleList[0].salesCycleId!);

            }
            if(saleCycleList[0].salesCycleStatus=="Propose") {
              print("Sales cycle status..${saleCycleList[0].salesCycleId}");
              getQuoteHeaderData(pageNumberForQuote,saleCycleList[0].salesCycleId!, '');
              getQuoteWonData(saleCycleList[0].salesCycleId!);
            }
           /* accountNameController.value.text=saleCycleList[0].accountName??"";
            contactNameController.value.text=saleCycleList[0].contactName??"";
*/
          }else {
            loading.value = false;
            saleCycleList.value=[];

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
    }catch(e){
      loading.value = false;
      print(e);
    }
  }

  ProductCategoryWiseAmtGet(int page_no, String saleCycleId){
    try{
      Map data={
        "sale_cycle_id": saleCycleId.isNotEmpty?saleCycleId:saleCycleController.value.text,
      };
      loading.value=true;
      _api.SaleCycleProductCategoryWiseAmtGet(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ProductCategoryWiseAmtModel> response = jsonResponse.map((e) => ProductCategoryWiseAmtModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            budgetAmountList.value = response;
            print('budgetAmt...${budgetAmountList.value}');
            Total_Budget_Amount.value=response[0].totalBudgetAmount??"";
            Total_Expected_Amount.value=response[0].totalEstimatedAmount??"";
            //total_rows=int.parse(budgetAmountList[0].totalRows!);
          }else {
            loading.value = false;
            budgetAmountList.value=[];

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
    }catch(e){
      loading.value = false;
      print(e);
    }
  }



  salesCycleMstUpdateApiHit(SalesCycleModal saleCycleList, String proposedSolution,
      String quote_accepted, String competitor_name, String quote_rejected_reason, String flag ){
  //  List<SalesCycleUpdateStatusModal> lines = Quote_Selected_list.map((item) => SalesCycleUpdateStatusModal(quoteId: item.quoteId!)).toList();

    loading.value = true;
      Map data={
        "sales_cycle_id": saleCycleList.salesCycleId,
        "est_closure_date": closureDateController.value.text.isEmpty?saleCycleList.estClosureDate:closureDateController.value.text,
        "budget_amount": flag==""?updatesalesCycleBudgetAmountController.value.text:saleCycleList.budgetAmount,
        "is_decision_maker": identifyDecisionMakerController.value.text=="No"?0:1,
        "purchase_process": purchaseProcessController.value.text.isEmpty?'':purchaseProcessController.value.text,
        "purchase_time_frame": purchasTimeFrameController.value.text.isEmpty?'':purchasTimeFrameController.value.text,
        "commit": saleCycleList.salesCycleStatus!.toLowerCase()=="propose"?1:0,
        "sales_cycle_owner": flag==""?saleCycleOwnerSelected.value:saleCycleList.salesCycleOwner,
        "created_by": email
      };
      try{
        _api. salesCycleMstUpdateApiHit(data, sessionManagement).then((onValue){
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if(jsonResponse is List){
            List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
            if(response[0].condition=="True"){
              Utils.showToastification("Message !", response[0].message.toString());

             /* if(flag != ''){
                salesCycleMstApprovereject(saleCycleList, solutionRejectedRemarkController.value.text.isNotEmpty?solutionRejectedRemarkController.value.text:rejectReasonController.value.text, flag);
              }*/
              if(flag=="Pending For Approval"){
                getSalesCycleMstStatusChange(saleCycleList);
              }
              pageNumber = 0;
               getsalesCycleData(pageNumber, saleCycleList.salesCycleId!, "ViewHeader", 'Sales');
              Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
              loading.value = false;
            }else {
              loading.value = false;
              Utils.sanckBarError("False Message !", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        },
        ).onError(
              (error, stackTrace) {
                loading.value = false;
            print(error);
          },
        );
      }catch(e){
        Utils.sanckBarException("Message !", e.toString());
        loading.value = false;
        print(e);
      }


  }

  salesCycleMstApprovereject(SalesCycleModal saleCycleList, String reason, String saleCycleapprovalStatus){
    print(saleCycleapprovalStatus);
    print("Reason Of reject..${reason}");

    print("est date ${closureDateController.value.text}");
    loading.value = true;
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "sales_cycle_status": saleCycleList.salesCycleStatus,
      "sales_cycle_approval_status": saleCycleapprovalStatus.toString(),
      "reject_reason": reason.isNotEmpty?reason:"",
      "created_by": email
    };
    try{
      _api.salesCycleMstApproveRejectApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            getsalesCycleData(0, saleCycleList.salesCycleId.toString(), "", FromPage.value);
            isApprovalVisible.value=false;
            Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
            loading.value = false;
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  getQuoteHeaderData(int pageNumberForQuote, String saleCycleId, String status){
    try{
      Map data= {
        "filter_quote_id": filterQuoteIdController.value.text.isNotEmpty? filterQuoteIdController.value.text:"",
        "filter_sales_cycle_id": saleCycleId.isNotEmpty?saleCycleId:"" ,
        "filter_account_name": "",
        "filter_contact_name": "",
        "filter_quote_validity": filterQuoteValidityController.value.text.isNotEmpty? filterQuoteValidityController.value.text:"",
        "filter_contact_person_name": "",
        "filter_exp_closure_date": filterExpectedClosuredateController.value.text.isNotEmpty? filterExpectedClosuredateController.value.text:"",
        "filter_quote_status": filterQuoteStatusController.value.text.isNotEmpty? filterQuoteStatusController.value.text:status,
        "filter_created_by": FromPage=="QuoteApprovalPage"?"":email,
        "filter_approved_by": "",
        "row_per_page": rowsPerPage,
        "page_number": pageNumberForQuote
  };
      loading.value=true;
      _api.quoteHeaderGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleQuoteHeaderModal> response = jsonResponse.map((e) => SalesCycleQuoteHeaderModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumberForQuote==0){
              quoteList.clear();
            }
            quoteList.addAll(response);
            total_rows=int.parse(quoteList[0].totalRows!);
          }else {
            quoteList.value=[];
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
  }

  getQuoteWonData(String saleCycleId){
    try{
      Map data= {
        "sale_cycle_id":saleCycleId.isNotEmpty?saleCycleId:"" ,
        "quote_id":  "",
        //"rowsPerPage": rowsPerPage,
        //"pageNumber": pageNumberForQuote
      };
      loading.value=true;
      _api.quoteWonDataGetApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<QuoteWonModel> response = jsonResponse.map((e) => QuoteWonModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumberForQuote==0){
              quoteWonList.clear();
            }
            quoteWonList.addAll(response);
            total_rows=int.parse(quoteWonList[0].totalRows!);
          }else {
            quoteWonList.value=[];
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
  }

  getApprovalPersonList(String QuoteId){
      Map data= {
        "filter_quote_id": QuoteId,
        "filter_sales_cycle_id": "" ,
        "filter_account_name": "",
        "filter_contact_name": "",
        "filter_quote_validity": "",
        "filter_contact_person_name": "",
        "filter_exp_closure_date": "",
        "filter_quote_status": "GET APPROVAL PERSON",
        "filter_created_by": '',
        "filter_approved_by": "",
        "row_per_page": 0,
        "page_number": 0
      };
      loading.value=true;
      _api.quoteHeaderGetApiHit(data, sessionManagement).then((onValue){
        try{
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if(jsonResponse is List){
            List<getApprovalPersonMadol> response = jsonResponse.map((e) => getApprovalPersonMadol.fromJson(e)).toList();
            if(response!= null && response.length>0 && response[0].condition=="True"){
              approvalPersonList.value = response;
              print("Index..${index.value}");
              findquotationUserType(approvalPersonList.value);
              //Get.toNamed(RoutesName.approvalPersonList);
              /*if(pageNumberForQuote==0){
              approvalPersonList.clear();
            }
            approvalPersonList.addAll(response);
            total_rows=int.parse(approvalPersonList[0].totalRows!);*/
            }else {
              Utils.showErrorToastification("Else!", "No Record Found");
              approvalPersonList.value=[];

            }
          } else {
            loading.value = false;
            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", jsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      ).whenComplete((){
        this.loading.value = false;
      });
  }

  getSaleCycleProductByIdList(int pageNumber,String SalesId){
    Map data= {
      "sales_cycle_id": SalesId,
      "created_by": email,
      "item_code": itemCodeController.value.text.isNotEmpty?itemCodeController.value.text:"",
      "item_description": updateItemDescriptionController.value.text.isNotEmpty?updateItemDescriptionController.value.text:"",
      "category_name": categoryNameController.value.text.isNotEmpty?categoryNameController.value.text:"",
      "competitor_name": updateCompetitorNameProductController.value.text.isNotEmpty?updateCompetitorNameProductController.value.text:"",
      "loss_reason": updateLossReasonProductController.value.text.isNotEmpty?updateLossReasonProductController.value.text:"",
      "rowsPerPage": rowsPerPage,
      "pageNumber": pageNumber
    };
    loading.value=true;
    _api.SalesCycleProductGetBySalesCycleId(data, sessionManagement).then((onValue){
      try{
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleByIdModel> response = jsonResponse.map((e) => SalesCycleByIdModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            if(pageNumber==0){
              get_SalesCycleProductById_List.clear();
            }
            get_SalesCycleProductById_List.addAll(response);
            print('listSize.....${saleCycleList.length}');
            total_rows_sale_cyle_item=int.parse(get_SalesCycleProductById_List[0].totalRows!);

          }else {
           // Utils.showErrorToastification("Else!", "No Record Found");
            get_SalesCycleProductById_List.value=[];


          }
        } else {
          loading.value = false;
          // service_indent_header_list.value = [];
         // Utils.showExceptionToastification("Api Error!", jsonResponse);
        }
      }catch(e){
        print(e);
      }finally{
        loading.value = false;

      }

    },
    ).onError(
          (error, stackTrace) {
        print('sjdbbsidbi${error}');
      },
    ).whenComplete((){
      this.loading.value = false;
    });
  }



  saleCycleQuoteCreate(String saleCycleId){
    try{
      Map data={
        "sales_cycle_id": saleCycleId.toString(),
        "account_code": accountCode.value.isNotEmpty?accountCode.value:"",
        "account_name": accountNameController.value.text,
        "contact_code": contactCode.value.isNotEmpty?contactCode.value:"",
        "contact_name": contactNameController.value.text,
        "quote_validity":quoteValidityController.value.text,
        "exp_closure_date": expectedClosuredateController.value.text,
        "quote_commit": contactQuoteCommitController.value.text=="Yes"?1:0,
        "consignee_id": consigneeId,
        "created_by": email
      };

      loading.value=true;
      _api.quoteHeaderCreateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            ProductCatCreateApiHit(response[0].quoteId!);
            /*getQuoteHeaderData(0,  saleCycleList[0].salesCycleId!);
            Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);

            quoteValidityController.value.clear();
            expectedClosuredateController.value.clear();
            productCategoryController.value.clear();*/
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  TaskSaleCatCreateApiHit(String SalesId, String TaskID) async {

    List<TaskSalesProductCategoryLinesModel> lines = itemCategorySelectedlist.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();


    Map<String, dynamic> data = {
      "created_by": email,
      "task_id": TaskID,
      "lines": lines.map((line) => line.toJson()).toList(),
    };

    print(data);
    loading.value = true;

    try {
      final value = await _api.TaskSaleCatCreateApiHit(data, sessionManagement);
      print(value);
      final JsonResponse = json.decode(value);

      if (JsonResponse is List) {
        List<SalesCycleQuoteInformationModal> response =
        JsonResponse.map((e) => SalesCycleQuoteInformationModal.fromJson(e)).toList();

        if (response != null && response.isNotEmpty && response[0].condition == "True") {
          loading.value = false;
          Utils.showToastification("Success!", response[0].message.toString());
          getItemCategoryMstApi(SalesId,TaskID);
          pageNumber = 0;
          getsalesCycleData(pageNumber, SalesId, "ViewHeader", 'Sales');
          Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);

        } else {
          loading.value = false;
          Utils.showErrorToastification("Error!", "Please select at least single product category");
          getItemCategoryMstApi(SalesId, TaskID);
        }
      } else {
        loading.value = false;
        Utils.showExceptionToastification("Api Error!", JsonResponse.toString());
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  QuoteHeaderDupicateCreate(String quoteId){
    try{
      Map data={
        "quote_id": quoteId.toString(),
        "created_by": email
      };

      loading.value=true;
      _api.quoteHeaderDuplicateCreateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            getQuoteHeaderData(0,  saleCycleList[0].salesCycleId!, '');
            //Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }


  void getQuoteHeaderInformation(String? quoteId, String flag) {
    try{
      Map<String, String> data= {
          "quote_id": quoteId.toString(),
          "created_by": email
      };
      loading.value=true;
      _api.quoteHeaderGetByQuoteIdApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleQuoteInformationModal> response = jsonResponse.map((e) => SalesCycleQuoteInformationModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            quoteHeaderdata.value=response;
            quoteLinedata.value=quoteHeaderdata[0].quoteItems ?? [];
            if(quoteLinedata.length > 0){
              print('InsideAPI...${quoteLinedata[index.value].itemDescription}');
              updateItemDescriptionController.value.text=  quoteLinedata[index.value].itemDescription??"";
              print('ItemDesc...${updateItemDescriptionController.value.text}');
              print('ItemDescList...${quoteLinedata[index.value].itemDescription.toString()}');
              qtyUpdateLineController.value.text=  quoteLinedata[index.value].qty.toString();
              updateUnitPriceController.value.text=  quoteLinedata[index.value].unitPrice.toString();
              updateManualPriceController.value.text=  quoteLinedata[index.value].quoteLinePrice.toString();
              updateDiscountPerController.value.text= quoteLinedata[index.value].discountPer.toString();

              updateDiscountAmountController.value.text=  quoteLinedata[index.value].discountAmt.toString();
              gmDiscountPerContoller.value.text=  quoteLinedata[index.value].gmDiscountPer.toString();
              salesCreditPerContoller.value.text=  quoteLinedata[index.value].salesCredit.toString();

              updateAmountController.value.text=  quoteLinedata[index.value].mrpPrice.toString();
              updateTaxPerLineController.value.text=  quoteLinedata[index.value].sgstPer.toString();
              updateTaxAmountLineController.value.text=  quoteLinedata[index.value].sgstAmt.toString();
              updateGrossAmountLineController.value.text=  quoteLinedata[index.value].grossAmount.toString();
            }

            if(flag==""){
              quoteApprovalPage.value=flag;
              Get.toNamed(RoutesName.quoteInformationScreen);
            }else if(flag=="approvedQuotationScreen"){
              quoteApprovalPage.value=flag;
              Get.toNamed(RoutesName.quoteInformationScreen);
            }
            else if(flag=="quoteApprovalScreen"){
              print("Approver person");
               getApprovalPersonList(quoteHeaderdata[0].quoteId!);
               quoteApprovalPage.value=flag;
               Get.toNamed(RoutesName.quoteInformationScreen);
            }
            else if(flag=="QuoteDashboard"){
              quoteApprovalPage.value=flag;
              Get.toNamed(RoutesName.quoteInformationScreen);}
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }


  void itemMstGetByQuoteIdApiHit(int pageNumber,String? quoteId, String flag, String pipeProdCate) {
    try{
      Map data= {
        "quote_id": quoteId,
        "item_code": itemCodeController.value.text.isEmpty?"":itemCodeController.value.text,
        "name": nameController.value.text.isEmpty?"":nameController.value.text,
        "description": "",
        "category_code": categoryCodeController.value.text.isEmpty?pipeProdCate:categoryCodeController.value.text,
        "category_name": categoryNameController.value.text.isEmpty?"":categoryNameController.value.text,
        "gst_group_code": gstGrpCodeController.value.text.isEmpty?"":gstGrpCodeController.value.text,
        "hsn_code": hsnCodeController.value.text.isEmpty?"":hsnCodeController.value.text,
        "location_code": "",
        "active": -1,
        "is_bulky": -1,
        "is_expiry_mandatory": -1,
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };

      loading.value=true;
      _api.itemMstGetByQuoteIdApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print("ondata....${onValue}");
        if(jsonResponse is List){
          List<ItemQuoteModal> response = jsonResponse.map((e) => ItemQuoteModal.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumber==0){
              itemMstGetByQuoteIdList.clear();
            }
            itemMstGetByQuoteIdList.addAll(response);
            total_rows=int.parse(itemMstGetByQuoteIdList[0].totalRows!);
            print('Total rows ${total_rows}');
            if(flag=="Add"){
              Get.toNamed(RoutesName.quoteItemList);
            }

          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
            if(flag=="Add"){
              Get.toNamed(RoutesName.quoteItemList);
            }
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
  }

  void itemMstGetBySalesIdApiHit(int pageNumber,String? SalesId, String pipeProdCate) {
    try{
      Map data= {
        "sales_cycle_id": SalesId,
        "item_code": itemSalesCodeController.value.text.isEmpty?"":itemSalesCodeController.value.text,
        "name": nameSalesController.value.text.isEmpty?"":nameSalesController.value.text,
        "description": "",
        "category_code": categoryCodeController.value.text.isEmpty?pipeProdCate:categoryCodeController.value.text,
        "category_name": categoryNameSalesController.value.text.isEmpty?"":categoryNameSalesController.value.text,
        "gst_group_code": gstGrpCodeSalesController.value.text.isEmpty?"":gstGrpCodeSalesController.value.text,
        "hsn_code": hsnCodeSalesController.value.text.isEmpty?"":hsnCodeSalesController.value.text,
        "location_code": "",
        "active": -1,
        "is_bulky": -1,
        "is_expiry_mandatory": -1,
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };

      loading.value=true;
      _api.ItemMstGetBySalesCycleId(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print("ondata....${onValue}");
        if(jsonResponse is List){
          List<ItemMasterBySalesId_Model> response = jsonResponse.map((e) => ItemMasterBySalesId_Model.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumber==0){
              itemMstGetBySalesIdList.clear();
            }
            itemMstGetBySalesIdList.addAll(response);
            total_rows_items=int.parse(itemMstGetBySalesIdList[0].totalRows!);
            print('Total rows ${total_rows_items}');
            Get.toNamed(RoutesName.ItemListBySalesCycle_Screen);

          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }



  void quoteLineCreateFunction(String item_code, String flag){
    print("Index ${index}");
    loading.value = true;
    Map data={
      "quote_id": quoteHeaderdata[0].quoteId/*quoteId.value*/,
      "sales_cycle_id":quoteHeaderdata[0].salesCycleId,
      "created_by": email,
      "lines": [
          {
            "line_no":  flag=="CheckBox"?-1:quoteLinedata[index.value].lineNo,
            "item_code": item_code.toString(),
            "item_description": flag=="CheckBox"?"":(updateItemDescription2Controller.value.text.isNotEmpty?updateItemDescription2Controller.value.text:quoteLinedata[index.value].itemDescription??""),
            "qty": flag=="CheckBox"?0 :(qtyUpdateLineController.value.text.isNotEmpty?qtyUpdateLineController.value.text:quoteLinedata[index.value].qty),
            "quote_line_price": flag=="CheckBox"?0:(updateManualPriceController.value.text.isNotEmpty?updateManualPriceController.value.text:quoteLinedata[index.value].quoteLinePrice),
            "discount_per": flag=="CheckBox"?0:(updateDiscountPerController.value.text.isNotEmpty?updateDiscountPerController.value.text:quoteLinedata[index.value].discountPer),
            "bm_discount_per": flag=="CheckBox"?0:bmDiscountPerController.value.text.isNotEmpty?bmDiscountPerController.value.text:quoteLinedata[index.value].bmDiscountPer,
            "gm_discount_per": flag=="CheckBox"?0:(gmDiscountPerContoller.value.text.isNotEmpty?gmDiscountPerContoller.value.text:quoteLinedata[index.value].gmDiscountPer),
            "gm_discount_amount": flag=="CheckBox"?0:quoteLinedata[index.value].gmDiscountAmount,
            "approved_discount_per": flag=="CheckBox"?0:(updateDiscountAmountController.value.text.isNotEmpty?updateDiscountAmountController.value.text:quoteLinedata[index.value].approvedDiscountPer),
            "sales_credit": flag=="CheckBox"?0:(salesCreditPerContoller.value.text.isNotEmpty?salesCreditPerContoller.value.text:quoteLinedata[index.value].salesCredit),
            "line_status": flag=="CheckBox"?"Pending":quoteHeaderdata[0].quoteStatus,
          }
        /*  "line_no":
          "item_code":
         // "warranty_period": warrentyPeriodController.value.text.isEmpty?'0 Months':warrentyPeriodController.value.text + ' Months',
         // "delivery_in_weeks": deliveryWeeksController.value.text.isEmpty?'0 Weeks':deliveryWeeksController.value.text + ' Weeks',
          "item_description":
          "qty":
          "quote_line_price":
          "discount_per":
          "gm_discount_per":
          "approved_discount_per":
          "sales_credit":
          "line_status": "Pending"*/

      ]
    };
    try{
      _api. quoteLineCreateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            if(flag=="BmGMUpdate"){
              getQuoteHeaderInformation(quoteHeaderdata[0].quoteId, "Add");
            }else{
              pageNumber=0;
              itemMstGetByQuoteIdApiHit(pageNumber,quoteHeaderdata[0].quoteId, "", '');
              getQuoteHeaderInformation(quoteHeaderdata[0].quoteId, "Add");
            }


            /*if(flag=="Update"){
              Get.toNamed(RoutesName.quoteInformationScreen);
            }*/
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
              Utils.showErrorToastification("Error Message !", error.toString());
              loading.value = false;
          print(error);
        },
      );
    }catch(e){
     // Utils.sanckBarException("Message !", e.toString());
      Utils.showErrorToastification("Message !", e.toString());
      loading.value = false;
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  void quoteLineDeleteApiHit(int lineNo, String flag) {
    try{
      Map data= {
        "quote_id": quoteId.toString(),
        "line_no": lineNo.toString(),
        "sales_cycle_id": salesCycleId.toString(),
        "created_by": email
      };
      loading.value=true;
      _api.quoteLineDeleteApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if( response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            pageNumber=0;
            itemMstGetByQuoteIdApiHit(pageNumber,quoteHeaderdata[0].quoteId, "", '');
            getQuoteHeaderInformation(quoteHeaderdata[0].quoteId, flag);
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  void ProductCategoryWiseAmtCreateApiHit(int id) {
    try{
      Map data= {
        "id": id,
        "sale_cycle_id": salesCycleId.toString(),
        "product_category": ProductCategoryCode.value.isEmpty?"":ProductCategoryCode.value,
        "estimated_amount": expectedAmountController.value.text,
        "created_by": email
      };
      loading.value=true;
      _api.SaleCycleProductCategoryWiseAmtCreate(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if( response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber = 0;
            ProductCategoryWiseAmtGet(pageNumber, salesCycleId.value);
            productCategoryController.value.clear();
            budgetAmountController.value.clear();
            expectedAmountController.value.clear();
            loading.value = false;
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  void ProductCategoryWiseAmtDeleteApiHit(int id) {
    try{
      Map data= {
        "id": id,
        "sale_cycle_id": salesCycleId.toString(),
        "product_category": ProductCategoryCode.value.isEmpty?"":ProductCategoryCode.value,
        "created_by": email
      };
      loading.value=true;
      _api.SaleCycleProductCategoryWiseAmtDelete(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if( response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber = 0;
            ProductCategoryWiseAmtGet(pageNumber, salesCycleId.value);
            productCategoryController.value.clear();
            budgetAmountController.value.clear();
            expectedAmountController.value.clear();
            loading.value = false;
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  void quoteLineCreateDuplicateApiHit(int lineNo) {
    try{
      Map data= {
        "quote_id": quoteId.toString(),
        "line_no": lineNo.toString(),
        "created_by": email
      };
      loading.value=true;
      _api.quoteLineDuplicateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ItemQuoteModal> response = jsonResponse.map((e) => ItemQuoteModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            getQuoteHeaderInformation(quoteId.value, "");
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  void quoteHeaderUpdateApiHit() {

    try{
      Map data= {
        "quote_id": quoteId.value,
        "quote_validity": updateQuoteValidityController.value.text,
        "quote_commit": quoteCommitController.value.text=='Yes'?1:0,
        "exp_closure_date": updateExpectedClosureDateController.value.text,
        "is_active": activeController.value.text=="Yes"?1:0,
        "created_by": email,
        "consignee_id": consigneeId
      };
      loading.value=true;
      _api.quoteHeaderUpdateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ItemQuoteModal> response = jsonResponse.map((e) => ItemQuoteModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            getQuoteHeaderInformation(quoteId.value, "");
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }


  void quoteBussinessTermlApiHit() {
    try{
      Map data= {
        "quote_id": quoteId.value,
        "installation_charges": installationChargesController.value.text.isEmpty?'0':installationChargesController.value.text,
        "other_charges": otherChargesController.value.text.isEmpty?'0':otherChargesController.value.text,
        "warranty_period": warrentyPeriodController.value.text.isEmpty?'0':warrentyPeriodController.value.text,
        "delivery_in_weeks": deliveryWeeksController.value.text.isEmpty?'0':deliveryWeeksController.value.text,
        "advance_payment_per": advncPaymentPerController.value.text.isEmpty?'0':advncPaymentPerController.value.text,
        "advance_payment_amt": advncPaymentAmountController.value.text.isEmpty?'0':advncPaymentAmountController.value.text,
        "other_remarks": quoteRemarkController.value.text.isEmpty?'':quoteRemarkController.value.text,
        "created_by": email
      };
      loading.value=true;
      _api.UpdateBusinessTermsApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ItemQuoteModal> response = jsonResponse.map((e) => ItemQuoteModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            quoteSendForApprovalApiHit();
            getQuoteHeaderInformation(quoteId.value, "");
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }


  void quoteSendForApprovalApiHit() {
    try{
      Map data= {
        "quote_id": quoteId.value,
        "created_by": email
      };
      loading.value=true;
      _api.quoteSendForApprovalApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ItemQouteWithReportModal> response = jsonResponse.map((e) => ItemQouteWithReportModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            itemQuoteReportList.value=response;
            print('isSPROut...${itemQuoteReportList[0].isSpr}');
            fileDownload(itemQuoteReportList[0].quoteReportUrl!, "quoteReport").then((_){
              if(itemQuoteReportList[0].isSpr=="1"){
                print('isSPR...${itemQuoteReportList[0].isSpr}');
                fileDownload(itemQuoteReportList[0].quoteSpecialPriceReportUrl!, "reportSpr");
              }
            });
            getQuoteHeaderInformation(quoteId.value ,"");
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }
  void quoteApprovalRejectApiHit(String quoteStatus, String quoteId) {
    try{
      Map data= {
        "quote_id": quoteId,
        "created_by": email,
        "quote_status": quoteStatus.toString(),
        "reject_reason": rejectreasonQuoteController.value.text
      };
      loading.value=true;
      _api.quoteApproveRejectApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<ItemQuoteModal> response = jsonResponse.map((e) => ItemQuoteModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            loading.value = false;
            pageNumber=0;
            Get.offAllNamed(RoutesName.quoteApprovalListScreen);
           // getQuoteHeaderInformation(quoteId, "quoteApprovalScreen");
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }
  getItemCategoryMstApi(String salesId, String taskID) {
    this.loading.value = true;
    Map<String, String> data = {
      'task_id': taskID ,
      'filter_category': "",
      'sales_cycle_id':  salesId,
      'quote_id':''
    };
    print(data);

    _api.getItemCategoryMstApiHit(data, sessionManagement).then((value) {
      print(value);
      try {
        List<ItemCategoryMstModel> Response =
        (json.decode(value) as List<dynamic>)
            .map((i) => ItemCategoryMstModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (Response.isNotEmpty && Response[0]?.condition.toString() == "True") {
          productCategoryList.value = Response!;
          itemCategorySelectedlist.value = [];
          for(int i = 0; i < Response.length; i++){
            if(Response[i].isSelected == 1){
              itemCategorySelectedlist.add(Response[i]);
              print('SelectedList...${itemCategorySelectedlist.length}');
            }
          }

        } else {
          productCategoryList.value = [];
          itemCategorySelectedlist.value = [];
        }
      } catch (e) {
        productCategoryList.value = [];
        itemCategorySelectedlist.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      productCategoryList.value = [];
      itemCategorySelectedlist.value = [];
      Utils.showErrorToastification('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }


  ProductCatCreateApiHit(String quoteId) async {
    List<TaskSalesProductCategoryLinesModel> lines = itemCategorySelectedlist.map((item) => TaskSalesProductCategoryLinesModel(productCategoryCode: item.categoryCode!)).toList();
    Map<String, dynamic> data = {
      "created_by": email,
      "quote_id": quoteId.toString(),
      "lines": lines.map((line) => line.toJson()).toList(),
    };

    print(data);
    loading.value = true;

    try {
      final value = await _api.taskSaleCatCreateApiHit(data, sessionManagement);
      print(value);
      final JsonResponse = json.decode(value);
      if (JsonResponse is List) {
        List<TaskMasterGetModel> response =
        JsonResponse.map((e) => TaskMasterGetModel.fromJson(e)).toList();
        if (response != null && response.isNotEmpty && response[0].condition == "True") {
          loading.value = false;
          Utils.showToastification("Success!", response[0].message.toString());
          getQuoteHeaderData(0,  saleCycleList[0].salesCycleId!, '');
          Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
          //getQuoteHeaderData(0,  saleCycleList[0].salesCycleId!, '');
          quoteValidityController.value.clear();
          expectedClosuredateController.value.clear();
          productCategoryController.value.clear();

        } else {
          loading.value = false;
          Utils.showErrorToastification("Error!", "Unsuccessful");
        }
      } else {
        loading.value = false;
        Utils.showExceptionToastification("Api Error!", JsonResponse.toString());
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      print("Exception....");
    }
  }

  void SalesCycleLineCreateApiHit(String item_code, String SalesId,int lineNo, String flag){
    print("Index ${index}");
    loading.value = true;
    Map data={
      "sales_cycle_id":SalesId,
      "created_by": email,
      "lines": [
        {
          "line_no": flag=="Add"?-1:lineNo.toString(),
          "item_code": item_code.toString(),
          "item_description":"",
          "qty": qtyUpdateLineController.value.text.isNotEmpty? qtyUpdateLineController.value.text:0,
          "line_status": "Pending"
        }
      ]
    };
    try{
      _api.SalesProductLineCreate(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
             pageNumber=0;
            getSaleCycleProductByIdList(pageNumber,SalesId);
            loading.value = false;

          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  void SalesCycleLineDeleteApiHit(int LineNo, String SalesCycleid) {
    try{
      Map data= {
        "line_no": LineNo,
        "sales_cycle_id": SalesCycleid,
        "created_by": email
      };
      loading.value=true;
      _api.SalesProductLineDelete(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleUpdateStatusModal> response = jsonResponse.map((e) => SalesCycleUpdateStatusModal.fromJson(e)).toList();
          if( response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber=0;
            getSaleCycleProductByIdList(pageNumber,SalesCycleid);
            loading.value = false;
          }else {
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
  }

  /*void fileDownload(List<ItemQouteWithReportModal> value) async {
    try {
      final response = await http.get(
          Uri.parse(value[0].quoteReportUrl!,
          )
      );
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        print("Bytes: ${bytes.length}");
        var dir = await getTemporaryDirectory();

        String baseName = 'quoteReport${quoteHeaderdata[0].quoteId}';
        String extension = '.pdf';
        String filePath = '${dir.path}/$baseName$extension';
        int counter = 1;

        // Check if the file already exists and create a unique file name
        while (await File(filePath).exists()) {
          filePath = '${dir.path}/$baseName($counter)$extension';
          counter++;
        }

        File file = File(filePath);
        await file.writeAsBytes(bytes);
        await OpenFile.open(file.path);
        // Get.toNamed(RoutesName.quoteInformationScreen);

        print("File saved to: ${file.path}");
      } else {
        print("Failed to download file: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }*/

 Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }



  /*  Future<void> fileDownload(String url) async {
    try {
      // Request storage permissions
      if (await _requestPermission(Permission.storage)) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          print("Bytes: ${bytes.length}");

          var dir = await getDownloadsDirectory();
          if (dir != null) {
            final path = '${dir.path}/downloaded_file.pdf';
            File file = File(path);
            print("Saving file to: $path");
            await file.writeAsBytes(bytes);
            showNotification(file.path);
          } else {
            print("Could not get the downloads directory.");
          }
        } else {
          print("Failed to download file: ${response.statusCode}");
        }
      } else {
        print("Storage permission denied.");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  Future<Directory?> getDownloadsDirectory() async {
    // This method should provide the correct path for the downloads directory
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    }
    // Add handling for other platforms if needed
    return null;
  }
*/

  Future<void> checkPermissions() async {
    //await _requestPermission(Permission.storage
    if (await _requestPermission(Permission.storage)) {
      print("Storage permission grant.");
    } else {
      print("Storage permission is required to save the file.");
    }
  }

  Future<void> fileDownload(String url, String flag) async {
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
        String baseName="";
        if(flag=="quoteReport"){
          baseName = 'Report${quoteHeaderdata[0].quoteId}';
        }
        else if(flag=="reportSpr"){
          baseName = 'SPRReport${quoteHeaderdata[0].quoteId}';
        }
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
          File file = File('${dir.path}/QuoteReport.pdf');
          if(flag=="quoteReport"){
             file = File('${dir.path}/QuoteReport.pdf');
          }
          else if(flag=="reportSpr"){
             file = File('${dir.path}/SrpReport.pdf');
          }
          //File file = File('${dir.path}/QuoteReport.pdf');

          // Write the bytes to the file
          await file.writeAsBytes(bytes);

          // Show notification
          showNotification(file.path, flag);
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


  void showNotification(String path, String flag) async {
    String title = (flag == 'quoteReport') ? 'Quote Report Notification' : 'Quote SPR Report Notification';
    int notificationId = Random().nextInt(100000);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
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
  }



/*  showNotification(String path, String flag){
    String Title = '';
    if(flag == 'quoteReport'){
      Title = 'Quote Report Notification';
    }else{
      Title = 'Quote SPR Report Notification';
    }
    int notificationId = Random().nextInt(100000);
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        icon: 'resource://mipmap/launcher_icon',
        channelKey: 'basic_channel',
        title: Title,
        body: "Report Download Successfully",
        payload: {'filePath': path},),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN_FILE',
          label: 'Open File',
        ),
      ],
    );
  }*/


  /*Future<void> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      print('peermission requrest');
      return;
    }

    if (await Permission.storage.isDenied) {
      print('peermission requrest1');
      await Permission.storage.request();
    }

    if (await Permission.storage.isPermanentlyDenied) {
      print('peermission requrest2');
      openAppSettings();
    }
  }

  Future<void> fileDownload(List<ItemQouteWithReportModal> value) async {
    try {
      // Request storage permission
      await requestStoragePermission();
      if (await Permission.storage.isGranted) {
        final response = await http.get(Uri.parse(value[0].quoteReportUrl!));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          print("Bytes: ${bytes.length}");

          // Get the public Downloads directory
          Directory downloadsDir = Directory("/storage/emulated/0/Download");
          if (!downloadsDir.existsSync()) {
            downloadsDir.createSync();
          }
          String downloadsPath = downloadsDir.path;

          String baseName = 'quoteReport${quoteHeaderdata[0].quoteId}';
          String extension = '.pdf';
          String filePath = '$downloadsPath/$baseName$extension';
          int counter = 1;

          // Check if the file already exists and create a unique file name
          while (await File(filePath).exists()) {
            filePath = '$downloadsPath/$baseName($counter)$extension';
            counter++;
          }

          File file = File(filePath);
          await file.writeAsBytes(bytes);
          await OpenFile.open(file.path);

          print("File saved to: ${file.path}");
        } else {
          print("Failed to download file: ${response.statusCode}");
        }
      } else {
        // Handle the case when permission is not granted
        print("Storage permission denied");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }*/

  Future<void> reportDownload(String flag) async {
    try{
      var company_id = await sessionManagement.getCompanyId();
      Map<String, String> data = {
        "company_id":company_id.toString(),
        "quote_id":quoteHeaderdata[0].quoteId!,
        "user_name":email,
      };
      print(data);
      loading.value=true;
      _api.getquoteReportApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          print('ifff......');
          List<ItemQouteWithReportModal> response = jsonResponse.map((e) => ItemQouteWithReportModal.fromJson(e)).toList();
          if(response.isNotEmpty && response.length>0 && response[0].condition=="True"){
           // Utils.sanckBarSuccess("Message !", response[0].message.toString());
            loading.value = false;
            itemQuoteReportList.value=response;

            fileDownload(itemQuoteReportList[0].quoteReportUrl!, "quoteReport");

          }else {
            print("Else....");
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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

  Future<void> reportSprDownload(String flag ,String quoteId) async {
    try{
      var company_id = await sessionManagement.getCompanyId();
      Map<String, String> data = {
        "company_id":company_id.toString(),
        "quote_id":quoteId.toString() ,
        "spr_no":quoteHeaderdata[0].sprNo.toString(),
        "user_name":"",
      };
      print(data);
      loading.value=true;
      _api.specialPriceRequestReportApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          print('ifff......');
          List<ItemQouteWithReportModal> response = jsonResponse.map((e) => ItemQouteWithReportModal.fromJson(e)).toList();
          if(response.isNotEmpty && response.length>0 && response[0].condition=="True"){
           // Utils.sanckBarSuccess("Message !", response[0].message.toString());
            loading.value = false;
            itemQuoteReportList.value=response;
            fileDownload(itemQuoteReportList[0].quoteSpecialPriceReportUrl!, "reportSpr");

            //fileDownload(itemQuoteReportList.value);

          }else {
            print("Else....");
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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

  calculateFinalAmt() {
    final installationChangs = installationChargesController.value.text;
    double installIntAmt = double.tryParse(installationChangs)??0;
    final OtherChangs = otherChargesController.value.text;
    final trimmedOtherChangs = OtherChangs.trim();
    double? OtherChangsInt = double.tryParse(trimmedOtherChangs)??0;
    double? quoteAmtInt = quoteHeaderdata[0].quoteTotalAmount;
    if (quoteAmtInt == null) {
      quoteAmtInt = 0.0;
    }
    double finalQuoteAmt = (installIntAmt + OtherChangsInt + quoteAmtInt);

    finalAmountController.value.text = finalQuoteAmt.toString();

    double? advcAmount = double.tryParse(advncPaymentAmountController.value.text);
    double? finalAmount = double.tryParse(finalAmountController.value.text);
    if (advcAmount == null) {
      advcAmount = 0.0;
    }
    double totAmount = finalAmount! - advcAmount;
    pendingAmountController.value.text = totAmount.toString();
    print('Installationchagr..${installationChargesController.value.text}');
    print('OthersC..${otherChargesController.value.text}');
    print('quoteAmtInt..${quoteAmtInt}');
    print('finalAmt..${finalAmount}');
    print('advcAmt..${advncPaymentAmountController.value.text}');
    print('advc..${advcAmount}');
    print('PendingAmt..${pendingAmountController.value.text}');


  }

  SetBusinessTerm(){
    installationChargesController.value.text = quoteHeaderdata[0].installationCharges.toString();
    otherChargesController.value.text = quoteHeaderdata[0].otherCharges.toString();
    //saleCycleController.warrentyPeriodController.value.text = saleCycleController.quoteHeaderdata[0].warrantyPeriod.toString();
    //saleCycleController.deliveryWeeksController.value.text = saleCycleController.quoteHeaderdata[0].deliveryInWeeks.toString();
    advncPaymentPerController.value.text = quoteHeaderdata[0].advancePaymentPer.toString();
    quoteTotAmountController.value.text = quoteHeaderdata[0].quoteTotalAmount.toString();
    advncPaymentAmountController.value.text = quoteHeaderdata[0].advancePaymentAmt.toString();
    quoteRemarkController.value.text = quoteHeaderdata[0].otherRemarks.toString();
  }

  clearBusinessTerm(){
    installationChargesController.value.clear();
    otherChargesController.value.clear();
    //saleCycleController.warrentyPeriodController.value.clear();
    //saleCycleController.deliveryWeeksController.value.clear();
    advncPaymentPerController.value.clear();
    advncPaymentAmountController.value.clear();
    pendingAmountController.value.clear();
    quoteRemarkController.value.clear();
    finalAmountController.value.clear();
  }

  clearSaleProductListController(){
    itemCodeController.value.clear();
    categoryNameController.value.clear();
    updateItemDescriptionController.value.clear();
    updateCompetitorNameProductController.value.clear();
    updateCompetitorPriceProductController.value.clear();
    updateLossReasonProductController.value.clear();
  }


  void showDialogForsalescycleUpdate(BuildContext context, SalesCycleModal saleCycleList, ) {
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update Sales Cycles',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
              /*height: size.height*.3,
                width: size.width*4,*/
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    bindUpdateSalesCycle(context),
                    SizedBox(height: 10,),
                    Obx(() {
                      return Visibility(
                        visible: isApprove.value && Quote_Selected_list.length>0,
                        child: Container(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical, // Allows vertical scrolling
                            child: Wrap(
                              spacing: 3.0,
                             // runSpacing: 3.0, // Optional: Adds space between rows
                              children: Quote_Selected_list.map((category) {
                                return Chip(
                                  label: Text(category.quoteId!),
                                  onDeleted: () {
                                    int index = quoteList.indexWhere((item) => item.quoteId == category.quoteId);
                                    Quote_Selected_list.remove(category);
                                    checkBoxValues[index] = false;
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 8,),

                    Obx((){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: isChooseQuote.value,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  AllColors.greenblue,
                                ),
                              ),
                              onPressed: ()  {
                                pageNumberForQuote = 0;
                                getQuoteHeaderData(pageNumberForQuote,saleCycleList.salesCycleId!, "Approved");
                                Get.toNamed(RoutesName.approvedQuotationListScreen);
                              },
                              child: Container(
                                child: Text('Select Quotation',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx((){
                            return Visibility(
                              visible: isApprove.value && Quote_Selected_list.isNotEmpty?true:false,
                              // visible: saleCycleController.selectedQuotationIdController.value.text == '' ? false:true,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AllColors.greenblue,
                                  ),
                                ),
                                onPressed: ()  {
                                  navigator?.pop(context);
                                  showWonLossConfirmationDialog(context, saleCycleList, "propose");

                                },
                                child: Container(
                                  child: Text('Approve Quotation',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),

                        ],
                      );
                    }),

                    Obx((){
                      return   Visibility(
                        visible: isReject.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            competitorname( context),
                            SizedBox(height: 10),
                            bindQuoteRejectreason(context),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      AllColors.redColor,
                                    ),
                                  ),
                                  onPressed: ()  {
                                    if(competitorNameController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Competitor Name');
                                      return;
                                    }else if(quoteRejectReasonController.value.text.isEmpty){
                                      Utils.showErrorToastification('Error', 'Please Enter Reject Reason Name');
                                      return;
                                    }
                                    showWonLossConfirmationDialog(context, saleCycleList,saleCycleList.salesCycleStatus!);

                                   // Get.back();

                                  },
                                  child: Container(
                                    child: Text('Loss',
                                      style: GoogleFonts.poppins(
                                        color: AllColors.blackColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),


                  ],
                )
            ),
          );

        });
  }

  void showConsigneeAddressList(BuildContext context, RxList<AddressMasterModel> address_master_list) {
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Select Address',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Container(
                height: size.height*.6,
                width: size.width*45,
              child: Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.only(left: 2.0, top: 5.0, right: 2.0, bottom: 5.0),
                      child: Obx(() {
                        return BindAddressListView(context);
                      }),
                    ),
                  ),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Obx((){
                        return Visibility(
                          visible: address_master_list.value.length > 0 ?true :false,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              selectedItem.value = -1;
                              shippingController.value.text=saleCycleList[0].shippingAddress??"";
                              shippingAddress2Controller.value.text=saleCycleList[0].shippingAddress2??"";
                              Shipping_PostCode_Controller.value.text=saleCycleList[0].shippingPostCode??"";
                              Shipping_City_Controller.value.text=saleCycleList[0].shippingCity??"" ;
                              Shipping_District_Controller.value.text=saleCycleList[0].shippingDistrict??"" ;
                              Shipping_State_Controller.value.text=saleCycleList[0].shippingStateCode??"";
                              Shipping_phone_Controller.value.text=saleCycleList[0].shippingPhoneNo??"";
                              Shipping_email_Controller.value.text=saleCycleList[0].shippingEmailId??"";
                              consigneeId = '';

                              // shippingController.value.text=('${saleCycleList[0].shippingAddress??""} ${saleCycleList[0].shippingStateCode??"" } ${saleCycleList[0].shippingPostCode??"" }');
                              Get.back();
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Discard'
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files'*/,
                                style: GoogleFonts.poppins(
                                  color: AllColors.customDarkerWhite,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      Obx((){
                        return Visibility(
                          visible: address_master_list.value.length > 0 ?true :false,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.primaryDark1,
                              ),
                            ),
                            onPressed: ()  {
                              shippingController.value.text=address_master_list[selectedItem.value].address??"";
                              shippingAddress2Controller.value.text=address_master_list[selectedItem.value].address2??"";
                              Shipping_PostCode_Controller.value.text=address_master_list[selectedItem.value].postCode??"";
                              Shipping_City_Controller.value.text=address_master_list[selectedItem.value].city??"" ;
                              Shipping_District_Controller.value.text=address_master_list[selectedItem.value].district??"" ;
                              Shipping_State_Controller.value.text=address_master_list[selectedItem.value].stateName??"";
                              Shipping_phone_Controller.value.text=address_master_list[selectedItem.value].phoneNo??"";
                              Shipping_email_Controller.value.text=address_master_list[selectedItem.value].emailId??"";
                              consigneeId = address_master_list[selectedItem.value].consigneeId??"";
                              Get.back();
                            },
                            child: Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text('Save',
                                style: GoogleFonts.poppins(
                                  color: AllColors.customDarkerWhite,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      })

                    ],)
                ],
              ),
            ),
          );

        });
  }

  Widget BindAddressListView(context) {
    if (address_master_list.value.isNotEmpty && address_master_list.value.length > 0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (total_rows /
              rowsPerPage).toInt();
          if ((total_rows %
              rowsPerPage) >
              0) total_page += 1;

          //print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (pageNumber + 1 < total_page) {
            getAddressMasterList(pageNumber, accountCode.value,);
            this.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: address_master_list.value.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    return Obx((){
      return  Card(
        margin: EdgeInsets.all(5),
        color: selectedItem.value == position ? AllColors.grayColor : Colors.white,
        child: ListTile(
          onTap: () {
            selectedItem.value = position;

          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    "Consignee Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: size.width * .25,
                    child: Tooltip(
                      message:address_master_list[position]
                          .consigneeId?? "",
                      child: Text(
                        address_master_list[position]
                            .consigneeId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 3),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .25,
                    child: Tooltip(
                      message: address_master_list[position]
                          .contactName?? "",
                      child: Text(
                        address_master_list[position]
                            .contactName?? "",
                        overflow: TextOverflow.ellipsis,
                        style:GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone No. : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: address_master_list[position]
                          .phoneNo?? "",
                      child: Text(
                        address_master_list[position]
                            .phoneNo?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message: address_master_list[position]
                          .emailId?? "",
                      child: Text(
                        address_master_list[position]
                            .emailId?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:"${address_master_list[position].address ??""}",
                      child: Text("${address_master_list[position].address ??""} ",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "City : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:address_master_list[position].city??"",
                      child: Text(address_master_list[position].city??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "State : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .35,
                    child: Tooltip(
                      message:address_master_list[position].stateName??"",
                      child: Text(address_master_list[position].stateName??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Post Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .2,
                    child: Tooltip(
                      message:address_master_list[position].postCode??"",
                      child: Text(address_master_list[position].postCode??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.twelve,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),

            ],
          ),



        ),
      );
    });


  }


  showWonLossConfirmationDialog(context, SalesCycleModal saleCycleList, String salesCycleStatusFlag){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update!',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do you want to update Sales Cycle ?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();
                              /*saleCycleController.salesCycleMstUpdateApiHit(saleCycleList,
                                  saleCycleController.proposedSolutionController.value.text, saleCycleController.updateQuoteAccetedCycleController.value.text
                                  , saleCycleController.competitorNameController.value.text, saleCycleController.quoteRejectReasonController.value.text, "");
*/

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              if(salesCycleStatusFlag!.toLowerCase()=="propose"){
                                getSalesCycleMstUpdatePropose(saleCycleList,updateQuoteAccetedCycleController.value.text);
                              }else{
                                getSalesCycleMstUpdateSuspect(saleCycleList,
                                    updateQuoteAccetedCycleController.value.text
                                    ,competitorNameController.value.text, quoteRejectReasonController.value.text);
                              }

                             /* getSalesCycleMstUpdateSuspect(saleCycleList,
                                  updateQuoteAccetedCycleController.value.text
                                  ,competitorNameController.value.text, quoteRejectReasonController.value.text);*/
                              Get.back();
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }

  Widget bindQuoteRejectreason(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: quoteRejectReasonController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Quote Reject Reason',
          labelText: 'Quote Reject Reason',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget competitorname(BuildContext context) {
    return  TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: competitorNameController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Competitor Name',
          labelText: 'Competitor Name',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }


  Widget selectedQuotation(BuildContext context) {
    return  TextField(
      readOnly: true,
      cursorColor:AllColors.primaryDark1 ,
      controller: selectedQuotationIdController.value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Selected Quotation',
          labelText: 'Selected Quotation',
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }



  Widget bindUpdateSalesCycle(BuildContext context) {

    return Autocomplete<String>(
      displayStringForOption: _displayCustomerNeedIdentityStatusForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return quoteAcceptedList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return quoteAcceptedList
            .where((String option) {
          return option
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        print(selection);
        updateQuoteAccetedCycleController.value.text =
            _displayCustomerNeedIdentityStatusForOption(selection!).toString();
      //  print('IsActive.....${saleCycleController.updateQuoteAccetedCycleController.value.text}');
        if(updateQuoteAccetedCycleController.value.text=="WON"){
         selectedQuotationIdController.value.clear();
          isChooseQuote.value = true;
          isApprove.value=true;
          isReject.value=false;
        }
        else if(updateQuoteAccetedCycleController.value.text=="LOSS"){
         competitorNameController.value.clear();
          quoteRejectReasonController.value.clear();
          isReject.value=true;
          isApprove.value=false;
          isChooseQuote.value = false;
        }
        else{
          isApprove.value=false;
          isReject.value=false;
          isChooseQuote.value = false;
        }
        FocusNode().unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: saleCycleList[0].salesCycleStatus !="Propose"?true:false,
          onTap: (){
            updateQuoteAccetedCycleController.value.clear();
          },
          onChanged: (value){
            if(updateQuoteAccetedCycleController.value.text=="WON"){
              selectedQuotationIdController.value.clear();
              isChooseQuote.value = true;
              isApprove.value=true;
              isReject.value=false;
            }
            else if(updateQuoteAccetedCycleController.value.text=="LOSS"){
              competitorNameController.value.clear();
              quoteRejectReasonController.value.clear();
              isReject.value=true;
              isApprove.value=false;
              isChooseQuote.value = false;
            }
            else{
              isApprove.value=false;
              isReject.value=false;
              isChooseQuote.value = false;
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text =  updateQuoteAccetedCycleController.value.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Quote Accepted',
              labelText: 'Quote Accepted',
              hintStyle: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.ten),
              labelStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.sisxteen),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              width: size.width*.5,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

  }

  getPurchaseProcessApi() {
    this.loading.value = true;
    Map<String, String> data = {'flag': "purchase_process"};

    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          get_PurchaseProcess_list.value = emp_masterResponse[0].list!;
          print('master list....${get_PurchaseProcess_list.length.toString()}');
        } else {
          get_PurchaseProcess_list.value = [];
          print('master listelsse....${get_PurchaseProcess_list.length.toString()}');
        }
      } catch (e) {
        get_PurchaseProcess_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_PurchaseProcess_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }

  getPurchaseTimeFrameApi() {
    this.loading.value = true;
    Map<String, String> data = {'flag': "purchase_time_frame"};

    _api.getMasterTypeApiHit(data, sessionManagement).then((value) {
      try {
        List<GetMasterTypeModel> emp_masterResponse =
        (json.decode(value) as List<dynamic>)
            .map((i) => GetMasterTypeModel.fromJson(i as Map<String, dynamic>))
            .toList();

        if (emp_masterResponse.isNotEmpty && emp_masterResponse[0]?.condition.toString() == "True") {
          get_PurchaseTimeFrame_list.value = emp_masterResponse[0].list!;
          print('master list....${get_PurchaseTimeFrame_list.length.toString()}');
        } else {
          get_PurchaseTimeFrame_list.value = [];
          print('master listelsse....${get_PurchaseTimeFrame_list.length.toString()}');
        }
      } catch (e) {
        get_PurchaseTimeFrame_list.value = [];
        print('catch....${e.toString()}');
      }
    }).onError((error, stackTrace) {
      get_PurchaseTimeFrame_list.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
      print('catchEx....${error.toString()}');
    }).whenComplete(() {
      this.loading.value = false;
    });
  }


  void getAddressMasterList(int pageNumber, String account_Code) {
    try{
      Map data={
        "consignee_id": "",
        "account_code":account_Code,
        "account_name": "",
        "contact_name": "",
        "email_id": "",
        "phone_no": "",
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };
      loading.value=true;
      print("data is ${data}");
      _api.ConsigneeAddMstGet(data, sessionManagement).then((onValue){
        print('value...${onValue}');
        final jsonResponse = json.decode(onValue);
        if(jsonResponse is List){
          List<AddressMasterModel> response = jsonResponse.map((e) => AddressMasterModel.fromJson(e)).toList();
          if(response.length>0 && response[0].condition=="True"){
            loading.value = false;
            address_master_list.value=[];
            address_master_list.value=response;

           // Get.toNamed(RoutesName.viewAddress_screen);

          }else {
            loading.value = false;
            address_master_list.value=[];
           // Get.toNamed(RoutesName.viewAddress_screen);
            Utils.showToastification('No date', 'No Data Found');

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
  }

  //todo checkbox indexex select variable...
  var checkBoxValues = <int, bool>{}.obs;
//todo chip button visible function...
  get isAnyCheckboxSelected {
    return checkBoxValues.values.any((value) => value == true);
  }


 /* void toggleMultiCheckbox(int index) {
    final bool isChecked = checkBoxValues[index] ?? false;
    if (isChecked) {
      Quote_Selected_list.remove(quoteList[index]);
      checkBoxValues[index] = false;
      print('Selectedlist1...${Quote_Selected_list.length}');
    } else {
      if (!Quote_Selected_list.contains(quoteList[index])) {
        Quote_Selected_list.add(quoteList[index]);
        checkBoxValues[index] = true;
        print('Selectedlist2...${Quote_Selected_list.length}');
      }
    }
    print('Selectedlist...${Quote_Selected_list.length}');
  }*/

  void toggleMultiCheckbox(int index) {
    final bool isChecked = checkBoxValues[index] ?? false;
    if (isChecked) {
      Quote_Selected_list.removeWhere((item) => item.quoteId == quoteList[index].quoteId);
      checkBoxValues[index] = false;
    } else {
      if (!Quote_Selected_list.any((item) => item.quoteId == quoteList[index].quoteId)) {
        Quote_Selected_list.add(quoteList[index]);
      }
      checkBoxValues[index] = true;
    }

  }


 /* void showDialogForSalesCyclePurchaseUpdate(BuildContext context, SalesCycleModal saleCycleList, ) {
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Update Sales Cycles Details',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bindClosureDate(context),
                  SizedBox(height: 10,),
                  bindIdentifyDecisionMaker(context),
                  SizedBox(height: 10,),
                  *//* bindSaleCycleCommit(context),
                  SizedBox(height: 10,),*//*
                  bindPurchaseProcessDropDown(context),
                  SizedBox(height: 10,),
                  bindPurchaseTimeFrameDropDown(context),
                  SizedBox(height: 10,),
                  bindBudgetAmount(context),
                  SizedBox(height: 10,),
                  bindSalesCycleOwner(context),
                  SizedBox(height: 10,),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AllColors.greenblue,
                      ),
                    ),
                    onPressed: ()  {
                      SalesCycleMstPurchaseByUpdateAPI(saleCycleList);
                      Get.back();
                      // pageNumberForQuote = 0;
                      //getQuoteHeaderData(pageNumberForQuote,salesCycleId.value, "Approved");
                      // Get.toNamed(RoutesName.approvedQuotationListScreen);
                    },
                    child: Container(
                      child: Text('UPDATE',
                        style: GoogleFonts.poppins(
                          color: AllColors.blackColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),




                ],
              ),
            ),
          );

        });
  }*/




  SalesCycleMstPurchaseByUpdateAPI(SalesCycleModal saleCycleList){
    loading.value = true;
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "est_closure_date":  closureDateController.value.text.isEmpty?saleCycleList.estClosureDate:closureDateController.value.text,
      "commit": 0,
      "is_decision_maker": identifyDecisionMakerController.value.text=="No"?0:1,
      "purchase_process": purchaseProcessController.value.text.isEmpty?'':purchaseProcessController.value.text,
      "purchase_time_frame": purchasTimeFrameController.value.text.isEmpty?'':purchasTimeFrameController.value.text,
      "created_by": email
    };
    try{
      _api.SalesCycleMstPurchaseByUpdate(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            getsalesCycleData(0, saleCycleList.salesCycleId.toString(), "", FromPage.value);
            loading.value = false;
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
    }catch(e){
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  getSalesCycleMstStatusChange(SalesCycleModal saleCycleList){
    loading.value = true;
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "created_by": email
    };
    try{
      _api.SalesCycleMstStatusChangeApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition!.toLowerCase()=="true"){
            Utils.showToastification("Message !", response[0].message.toString());
            getsalesCycleData(0, saleCycleList.salesCycleId.toString(), "", FromPage.value);
            loading.value = false;
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  getSalesCycleMstUpdateSuspect(SalesCycleModal saleCycleList, String quote_accepted,String competitor_name, String quote_rejected_reason){
    loading.value = true;
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "quote_accepted": quote_accepted,
      "competitor_name": competitor_name,
      "quote_rejected_reason": quote_rejected_reason,
      "created_by": email
    };
    try{
      _api.SalesCycleMstUpdateSuspectApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition!.toLowerCase()=="true"){
            Utils.showToastification("Message !", response[0].message.toString());
            getsalesCycleData(0, saleCycleList.salesCycleId.toString(), "", FromPage.value);
            loading.value = false;
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  getSalesProductLineCompetitorCreate(String sales_cycle_id,
      String flagLineAll, RxList<SalesCycleByIdModel> get_salesCycleProductById_List
      ,int? selectedIndex){
    loading.value = true;
    List<Map<String, dynamic>> lineData = [];

    if (flagLineAll == "All") {
      for (int i = 0; i < get_salesCycleProductById_List.length; i++) {
        final item = get_salesCycleProductById_List[i];
        lineData.add({
          "line_no": item.lineNo ?? "",
          "item_code": item.itemCode ?? "",
          "item_description": item.itemDescription ?? "",
          "qty": item.qty ?? 0,
          "line_status": item.lineStatus ?? "",
          "competitor_name": item.competitorName??"",
          "competitor_price": item.competitorPrice??0.0,
          "loss_reason": item.lossReason??"",
        });
      }
    } else if (selectedIndex != null && selectedIndex >= 0 && selectedIndex < get_salesCycleProductById_List.length) {
      final item = get_salesCycleProductById_List[selectedIndex];
      lineData.add({
        "line_no": item.lineNo ?? "",
        "item_code": item.itemCode ?? "",
        "item_description": item.itemDescription ?? "",
        "qty": item.qty ?? 0,
        "line_status": item.lineStatus ?? "",
        "competitor_name": updateCompetitorNameProductController.value.text,
        "competitor_price": updateCompetitorPriceProductController.value.text,
        "loss_reason": updateLossReasonProductController.value.text,
      });
    }

    Map<String, dynamic> data = {
      "sales_cycle_id": sales_cycle_id,
      "quote_accepted": "Loss",
      "created_by": email,
      "flag": flagLineAll,
      "lines": lineData,
    };
    try{
      print(data);
      _api.SalesProductLineCompetitorCreateApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition!.toLowerCase()=="true"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber=0;
            clearSaleProductListController();
            getSaleCycleProductByIdList(pageNumber, sales_cycle_id);
            loading.value = false;
          }else {
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
    finally{
      loading.value = false;
    }
  }

  UpdateProposeConfirmDecisionApiHit(String salesId){
    loading.value = true;
    Map data={
      "sales_cycle_id": salesId,
      "quote_submitted": QuoteSubmittedController.value.text == 'Yes'?1:'0',
      "confirm_decision_date": ConfirmDecisionDateController.value.text == 'Yes'?1:'0',
      "confirm_expected_revenue": ConfirmExpectedRevenueController.value.text == 'Yes'?1:'0',
      "created_by": email
    };
    try{
      _api.SalesCycleMstUpdateProposeConfirmDecision(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition!.toLowerCase()=="true"){
            Utils.showToastification("Success !", response[0].message.toString());
            loading.value = false;
            pageNumber = 0;
            getsalesCycleData(pageNumber, salesId, "ViewHeader", 'Sales');
            Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
          }else {
            print("message ${response[0].message.toString()}");
            loading.value = false;

            Utils.showErrorToastification("False Message !", response[0].message.toString());

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
      Utils.sanckBarException("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  FetchSalesProductApiHit(String salesId, String quoteId){
    loading.value = true;
    Map data={
      "quote_id": quoteId,
      "sales_cycle_id": salesId,
      "created_by": email

    };
    try{
      _api.QuoteLineCreateFromPropectStageApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleQuoteInformationModal> response = jsonResponse.map((e) => SalesCycleQuoteInformationModal.fromJson(e)).toList();
          if(response[0].condition!.toLowerCase()=="true"){
            Utils.showToastification("Success !", response[0].message.toString());
            loading.value = false;
            getQuoteHeaderInformation(quoteId, '');
            print("message ${response[0].message.toString()}");
            loading.value = false;

            Utils.showToastification("Success !", response[0].message.toString());

          }else {
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());
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
      Utils.showErrorToastification("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }


  getSalesCycleMstUpdateProposedSolution(SalesCycleModal saleCycleList,String approRejeStatus){
    loading.value = true;
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "is_customer_need_identify": customerNeedIdetityController.value.text=="Yes"?1:0,
      "proposed_solution": proposedSolutionController.value.text,
      "is_solution_accepted": solutionAcceptedController.value.text=="Yes"?1:0,
      "solution_rejected_remarks": solutionRejectedRemarkController.value.text,
      "created_by": email
    };
    try{
      _api. SalesCycleMstUpdateProposedSolutionApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber = 0;
            salesCycleMstApprovereject(saleCycleList,solutionRejectedRemarkController.value.text,approRejeStatus);
            //getsalesCycleData(pageNumber, saleCycleList.salesCycleId!, "ViewHeader", 'Sales');
            //Get.toNamed(RoutesName.viewSalesCycleHeaderScreen);
            loading.value = false;
          }else {
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());
          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
          loading.value = false;
          print(error);
        },
      );
    }catch(e){
      Utils.showErrorToastification("Message !", e.toString());
      loading.value = false;
      print(e);
    }


  }


  getSalesCycleMstUpdatePropose(SalesCycleModal saleCycleList,String quote_accepted ){
    loading.value = true;
    List<Map<String, dynamic>> lineData = [];
    if(Quote_Selected_list.isNotEmpty){
      for(int i=0; i<Quote_Selected_list.length; i++){
        var item=Quote_Selected_list[i];
        lineData.add({
          "quote_id":item.quoteId
        });
      }
    }
    Map data={
      "sales_cycle_id": saleCycleList.salesCycleId,
      "quote_accepted": quote_accepted,
      "created_by": email,
      "lines": lineData
    };
    try{
      _api.SalesCycleMstUpdateProposeApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<SalesCycleApproveRejectModal> response = jsonResponse.map((e) => SalesCycleApproveRejectModal.fromJson(e)).toList();
          if(response[0].condition=="True"){
            Utils.showToastification("Message !", response[0].message.toString());
            pageNumber = 0;
            getsalesCycleData(pageNumber, saleCycleList.salesCycleId.toString(), "", FromPage.value);
            //salesCycleMstApprovereject(saleCycleList,solutionRejectedRemarkController.value.text,approRejeStatus);
            loading.value = false;
          }else {
            loading.value = false;
            Utils.showErrorToastification("False Message !", response[0].message.toString());
          }
        } else {
          loading.value = false;
        }
      },
      ).onError(
            (error, stackTrace) {
          loading.value = false;
          print(error);
        },
      );
    }catch(e){
      Utils.showErrorToastification("Message !", e.toString());
      loading.value = false;
      print(e);
    }
  }

  void findquotationUserType(List<getApprovalPersonMadol> approvalPersonList){
    try{
      for(int i=0; i<approvalPersonList.length; i++){
        if(email.toLowerCase()==approvalPersonList[i].approvedBy?.toLowerCase()){
          if(approvalPersonList[i].userType?.toLowerCase() =='branch head'){
            showBranchHead.value=true;
          }else{
            showBranchHead.value=false;
          }
          if(approvalPersonList[i].userType?.toLowerCase() =='cluster head') {
            showClusterHead.value=true;
          }
          else{
            showClusterHead.value=false;
          }
          if(approvalPersonList[i].userType?.toLowerCase() =='general manager') {
            showGeneralManager.value=true;
          }
          else{
            showGeneralManager.value=false;
          }
          //saleCycleController.showUpdateBtnApproveQuoteItem.value=true;
        }
      }
      print("Branch Head ..${showBranchHead.value}");
    }catch(e){
      print("Catch Block exception Exception ..${e}");
    }
  }
}