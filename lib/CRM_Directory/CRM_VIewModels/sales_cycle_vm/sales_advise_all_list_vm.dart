

import 'dart:convert';

import 'package:get/get.dart';

import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/sales_advise_modal/all_sales_advise_list_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesAdviseAllListVm extends GetxController{
  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  String userType = "";
  String isAdminWritePermission = "";
  int rowsPerPage = 10;
  int total_rows = 0;
  int pageNumber = 0;

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
      "filter_sales_advice_id": "",
      "filter_quote_id": "",
      "filter_sales_cycle_id": "",
      "filter_account_code": "",
      "filter_account_name": "",
      "filter_rh_approval": "",
      "filter_cbh_approval": "",
      "filter_category_approval": "",
      "filter_gm_approval": "",
      "filter_quote_version": -1,
      "filter_quote_validity": "",
      "filter_exp_closure_date": "",
      "filter_sales_advice_status": "",
      "filter_flag": "AllSalesAdviceHeader",
      "filter_product_category": "",
      "filter_created_by": email,
      "filter_created_on": "",
      "filter_frontliner_value": "",
      "filter_branch_head_value": "",
      "filter_zone_head_value": "",
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
          } else {
            loading.value = false;
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
}