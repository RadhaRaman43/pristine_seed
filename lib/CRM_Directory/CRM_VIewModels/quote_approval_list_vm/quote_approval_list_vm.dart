

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_quote_header_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class QuoteApprovalListVm extends GetxController{

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading=false.obs;
  String email="";
  int pageNumberForQuote = 0;
  int rowsPerPage = 10;
  int total_rows = 0;


  var filterQuoteIdController=TextEditingController().obs;
  var filterQuoteAccountNameController=TextEditingController().obs;
  var filterQuoteContactNameController=TextEditingController().obs;
  var filterQuoteValidityController=TextEditingController().obs;
  var filterExpectedClosuredateController=TextEditingController().obs;
  /*var filterQouteTatolAmtController=TextEditingController().obs;
  var filterQuoteGstAmtController=TextEditingController().obs;
  var filterQuoteGrossAmtController=TextEditingController().obs;*/
  var filterQuoteSaleCycleController=TextEditingController().obs;

  RxList<SalesCycleQuoteHeaderModal> quoteApprovalList=<SalesCycleQuoteHeaderModal>[].obs;
  @override
  Future<void> onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    getQuoteHeaderData(pageNumberForQuote);
    super.onInit();
  }

  Future<void>refreshList() async{
    getQuoteHeaderData(pageNumberForQuote);
  }


  getQuoteHeaderData(int pageNumberForQuote){
    try{
      Map data= {
        "filter_quote_id": filterQuoteIdController.value.text.isNotEmpty?filterQuoteIdController.value.text:"",
        "filter_sales_cycle_id": filterQuoteSaleCycleController.value.text.isNotEmpty?filterQuoteSaleCycleController.value.text:"" ,
        "filter_account_name": filterQuoteAccountNameController.value.text.isNotEmpty?filterQuoteAccountNameController.value.text:"",
        "filter_contact_name": filterQuoteContactNameController.value.text.isNotEmpty?filterQuoteContactNameController.value.text:"",
        "filter_quote_validity": filterQuoteValidityController.value.text.isNotEmpty?filterQuoteValidityController.value.text:"",
        "filter_contact_person_name": "",
        "filter_exp_closure_date": filterExpectedClosuredateController.value.text.isNotEmpty?filterExpectedClosuredateController.value.text:"",
        "filter_quote_status": "Under Approval",
        "filter_created_by": email,
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
              quoteApprovalList.clear();
            }
            quoteApprovalList.addAll(response);
            print("${quoteApprovalList.length}");
            total_rows=int.parse(quoteApprovalList[0].totalRows!);
          }else {
            quoteApprovalList.value=[];
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
}