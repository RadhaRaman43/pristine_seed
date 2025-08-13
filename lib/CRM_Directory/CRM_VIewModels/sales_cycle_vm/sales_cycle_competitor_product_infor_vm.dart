

import 'dart:convert';

import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/sale_cycle_modal/sales_cycle_competitor_product_infor_modal.dart';
import '../../CRM_Repository/sales_cycle_repository/sales_cycle_repository.dart';

class SalesCycleCompetitorProductInforVm extends GetxController{

  RxList<SaleCycleCompetitorProductInformationModal> salesCycleCompetitorProductInformationList =
      <SaleCycleCompetitorProductInformationModal>[].obs;
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  String email = "";
  String userType = "";
  String isAdminWritePermission = "";
  RxBool loading = false.obs;

  final _api = SalesCycleRepository();
  SessionManagement sessionManagement = SessionManagement();
  @override
  void onInit() async{
    email = await sessionManagement.getEmail() ?? '';
    userType = await sessionManagement.getUserType() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    getGalesCycleCompetitorProductInformationGet(pageNumber);
    // TODO: implement onInit
    super.onInit();
  }

  getGalesCycleCompetitorProductInformationGet(int pageNumber) {
    Map data = {
      "filter_quote_id": "",
      "filter_sales_cycle_id": "",
      "filter_account_code": "",
      "filter_account_name": "",
      "filter_flag": "AllCompetitorLines",
      "filter_product_category": "",
      "filter_created_by": email,
      "filter_created_on": "",
      "filter_item_code_name": "",
      "filter_competitor_name": "",
      "filter_loss_reason": "",
      "filter_sales_cycle_status": "",
      "filter_sales_cycle_approval_status": "",
      "filter_sales_cycle_quote_accepted": "",
      "filter_expected_closure_date": "",
      "filter_postal_code": "",
      "filter_district": "",
      "filter_frontliner_value": "",
      "filter_branch_head_value": "",
      "filter_zone_head_value": "",
      "filter_clusture_head_value": "",
      "row_per_page": rowsPerPage,
      "page_number": pageNumber
    };

    loading.value = true;
    _api.salesCycleCompetitorProductInformationGetApiHit(data, sessionManagement).then(
          (onValue) {
        try {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<SaleCycleCompetitorProductInformationModal> response = jsonResponse
                .map((e) => SaleCycleCompetitorProductInformationModal.fromJson(e))
                .toList();
            if (response.isNotEmpty && response.length>0  && response[0].condition?.toLowerCase() == "true") {
              if (pageNumber == 0) {
                salesCycleCompetitorProductInformationList.clear();
              }
              salesCycleCompetitorProductInformationList.addAll(response);
              total_rows = int.parse(salesCycleCompetitorProductInformationList[0].totalRows!);
            } else {
              Utils.showErrorToastification("False Message", response[0].message.toString());
            }
          } else {
            loading.value = false;
          }
        } catch (e) {
          print(e) ;
        } finally {
          loading.value = false;
        }
      },
    ).onError(
          (error, stackTrace) {
      },
    ).whenComplete(() {
      this.loading.value = false;
    });
  }

}