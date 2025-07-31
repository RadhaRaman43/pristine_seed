import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';

import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/dashboard_models/call_DashBoard_Model.dart';
import '../../CRM_Repository/dashboard_repository/dashboard_repo.dart';

class CallDashboardVm extends GetxController{

  final _api = DashboardRepo();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  String email = "";
  var selectedOption = 'Employee'.obs;

  RxList<CallDashboardModel> callDashboardList = <CallDashboardModel>[].obs;
  RxList<Records> callDashboardRecordList = <Records>[].obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    email = await sessionManagement.getEmail() ?? '';
    callDashboardData();
  }

  Future<void> callDashboardData() async {
    try {
      Map<String, String> data = {
        "flag": selectedOption.value,
        "email_id": email, // use email.value if it's RxString
        "start_date": '2025-07-01',
        "end_date": '2025-07-31',
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


}