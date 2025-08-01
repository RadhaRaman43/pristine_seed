import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/dashboard_models/call_DashBoard_Model.dart';
import '../../CRM_Models/dashboard_models/call_dashboard_user_wise_Data_model.dart';
import '../../CRM_Repository/dashboard_repository/dashboard_repo.dart';

class CallDashboardVm extends GetxController{

  final _api = DashboardRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  var selectedOption = 'Employee'.obs;
  RxString formattedStartDate = "".obs;
  RxString formattedEndDate = "".obs;

  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;

  RxList<CallDashboardModel> callDashboardList = <CallDashboardModel>[].obs;
  RxList<Records> callDashboardRecordList = <Records>[].obs;
  RxList<CallDashboardUserWiseDataModel> callDashboardUserWiseDataList = <CallDashboardUserWiseDataModel>[].obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    DateRange("month");

    callDashboardData();
    //getDashboardUserWiseData(pageNumber);
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

  Future<void> callDashboardData() async {
    try {
      Map<String, String> data = {
        "flag": selectedOption.value,
        "email_id": email,
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "filter_owner_name": '',
        "filter_region_name": '',
        "filter_cluster_name": '',
        "filter_product_category": '',
        "filter_activity_status": '',
        "filter_customer_name": '',
        "filter_task_approval_status": 'All',
      };

      print(data);
      loading.value = true;

      final onValue = await _api.callDashboardGetApiHit(data, sessionManagement);
      final jsonResponse = json.decode(onValue);
      print(onValue);
      if (jsonResponse is List) {
        List<CallDashboardModel> response = jsonResponse
            .map((e) => CallDashboardModel.fromJson(e))
            .toList();

        if (response.isNotEmpty &&
            response[0].condition?.toLowerCase() == "true") {
          callDashboardList.value = response;
          callDashboardRecordList.value = response[0].records ?? [];
          print('baisgdiuasgi du${response}');
          getDashboardUserWiseData(pageNumber);
        } else {
          Utils.showErrorToastification(
              "False Message !", response[0].message.toString());
        }
      }

    } catch (e) {
      print("API error: $e");
    } finally {
      loading.value = false;
    }
  }


  getDashboardUserWiseData(int pageNumber){
    try{
      Map data={
        "flag": selectedOption.value,
        "email_id": email,
        "emp_email_id": "",
        "start_date": formattedStartDate.value,
        "end_date": formattedEndDate.value,
        "filter_type_of_call": "",
        "filter_owner_name": "",
        "filter_region_name": "",
        "filter_cluster_name": "",
        "filter_product_category": "",
        "filter_activity_status": "",
        "filter_customer_name": "",
        "filter_task_approval_status": "All",
        "rowsPerPage": rowsPerPage,
        "pageNumber": pageNumber
      };
      /* {
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
      };*/
      loading.value=true;
      _api.callDashboardUserWiseDataApiHit(data, sessionManagement).then((onValue){
        final jsonResponse = json.decode(onValue);
        print(onValue);
        if(jsonResponse is List){
          List<CallDashboardUserWiseDataModel> response = jsonResponse.map((e) => CallDashboardUserWiseDataModel.fromJson(e)).toList();
          if(response!= null && response.length>0 && response[0].condition=="True"){
            loading.value = false;
            if(pageNumber==0){
              callDashboardUserWiseDataList.clear();
            }
            callDashboardUserWiseDataList.addAll(response);
            print("${callDashboardUserWiseDataList.length}");
            total_rows=int.parse(callDashboardUserWiseDataList[0].totalRows!);
          }else {
            callDashboardUserWiseDataList.value=[];
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