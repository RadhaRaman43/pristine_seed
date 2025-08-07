import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/dashboard_models/call_dashboard_user_wise_Data_model.dart';
import '../../CRM_Models/dashboard_models/funnel_dashboard_model/funnel_Dashboard_model.dart';
import '../../CRM_Repository/dashboard_repository/dashboard_repo.dart';

class FunnelDashboardVm extends GetxController{

  final _api = DashboardRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool isShimmerLoading = false.obs;
  String email = "";

  RxString formattedStartDate = "".obs;
  RxString formattedEndDate = "".obs;
  RxString character = 'Month'.obs;

  RxString totalSuspectPrice = ''.obs;
  RxString totalProspectPrice = ''.obs;
  RxString totalProposePrice = ''.obs;

  int pageNumber = 0;
  int rowsPerPage = 10;
  RxInt total_rows = 0.obs;

  RxList<FunnelDashboardModel> funnelDashboardList = <FunnelDashboardModel>[].obs;
  RxList<CallDashboardUserWiseDataModel> funnelDashboardUserWiseDataList = <CallDashboardUserWiseDataModel>[].obs;

  var filterCustomDateController=TextEditingController().obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    DateRange("month");
    filterCustomDateController.value.text = '${formattedStartDate} - ${formattedEndDate}';
    funnelDashboardData();
  }

  Future<void> funnelDashboardData() async {

    try {
      Map<String, String> data = {
        "email_id": email,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
      };

      print(data);
      loading.value = true;
      isShimmerLoading.value = true;

      final onValue = await _api.funnelDashboardGetApiHit(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<FunnelDashboardModel> response = jsonResponse
            .map((e) => FunnelDashboardModel.fromJson(e))
            .toList();
        if (response.isNotEmpty && response[0].condition?.toLowerCase() == "true") {
          funnelDashboardList.value = response;
          totalProposePrice.value =  funnelDashboardList[0].totalProposePrice.toString();
          totalProspectPrice.value = funnelDashboardList[0].totalProspectPrice.toString();
          totalSuspectPrice.value = funnelDashboardList[0].totalSuspectPrice.toString();
          print('propose...${totalProposePrice}');

        } else {
          Utils.showErrorToastification(
              "False Message !", response[0].message.toString());
          funnelDashboardList.value = [];
        }
      }

    } catch (e) {
      print("API error: $e");
    } finally {
      loading.value = false;
      isShimmerLoading.value = false;
      getDashboardUserWiseData(pageNumber);
    }
  }

  getDashboardUserWiseData(int pageNumber){
    try{
      loading.value=true;
      Map data={
        "email_id": email,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "filter_type_of_call": '',
        "filter_account_code": '',
        "filter_account_name": '',
        "filter_account_owner": '',
        "filter_approved_by": '',
        "filter_branch_head_value": '',
        "filter_clusture_head_value": '',
        "filter_company_profile_type": '',
        "filter_created_by": email,
        "filter_created_on": '',
        "filter_due_date": '',
        "filter_frontliner_value": '',
        "filter_is_infra_lead": '0',
        "filter_is_sales_cycle_active": '-1',
        "filter_last_activity_status": '',
        "filter_method_of_call": '',
        "filter_postal_code": '',
        "filter_product_category": '',
        "filter_sales_cycle_id": '',
        "filter_task_id": '',
        "filter_task_status": '',
        "filter_zone_head_value": '',
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };


      _api.funnelDashboardUserWiseDataApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<CallDashboardUserWiseDataModel> response = jsonResponse.map((e) => CallDashboardUserWiseDataModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumber==0){
              funnelDashboardUserWiseDataList.clear();
            }
            funnelDashboardUserWiseDataList.addAll(response);
            print("${funnelDashboardUserWiseDataList.length}");
            total_rows.value=int.parse(funnelDashboardUserWiseDataList[0].totalRows!);
          }else {
            funnelDashboardUserWiseDataList.value=[];
            total_rows.value = 0;
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

  void DateRange(String type) {
    DateTime now = DateTime.now();
    late DateTime startDate;
    late DateTime endDate;

    switch (type.toLowerCase()) {
      case 'day':
        startDate = now;
        endDate = now;
        break;

      case 'week':
        int currentWeekday = now.weekday; // 1 (Mon) to 7 (Sun)
        startDate = now.subtract(Duration(days: currentWeekday - 1));
        endDate = now.add(Duration(days: 7 - currentWeekday));
        break;

      case 'month':
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;

      case 'quarterly':
        int currentMonth = now.month;
        if (currentMonth >= 1 && currentMonth <= 3) {
          startDate = DateTime(now.year, 1, 1);
          endDate = DateTime(now.year, 3, 31);
        } else if (currentMonth >= 4 && currentMonth <= 6) {
          startDate = DateTime(now.year, 4, 1);
          endDate = DateTime(now.year, 6, 30);
        } else if (currentMonth >= 7 && currentMonth <= 9) {
          startDate = DateTime(now.year, 7, 1);
          endDate = DateTime(now.year, 9, 30);
        } else {
          startDate = DateTime(now.year, 10, 1);
          endDate = DateTime(now.year, 12, 31);
        }
        break;

      case 'financial':
        if (now.month >= 4) {
          // Current FY: starts from April this year to March next year
          startDate = DateTime(now.year, 4, 1);
          endDate = DateTime(now.year + 1, 3, 31);
        } else {
          // Current FY: starts from April last year to March this year
          startDate = DateTime(now.year - 1, 4, 1);
          endDate = DateTime(now.year, 3, 31);
        }
        break;

      default:
        print("Invalid type passed. Use: day, week, month, or financial");
        return;
    }

    formattedStartDate.value = DateFormat('yyyy-MM-dd').format(startDate);
    formattedEndDate.value = DateFormat('yyyy-MM-dd').format(endDate);

    print("Start Date: $formattedStartDate");
    print("End Date: $formattedEndDate");

  }

}