
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BussinessTourPlanModel.dart';
import '../../CRM_Repository/BusinessTourPlan_Repository/business_tour_plan_repo.dart';

class BusinessPlanTourViewModel extends GetxController{

  final _api = BusinessTourPlanRepo();
  SessionManagement sessionManagement = SessionManagement();
  String email = "";
  String isAdminWritePermission = "";
  int pageNumber = 0;
  int rowsPerPage = 10;
  int total_rows = 0;
  RxBool loading = false.obs;
  RxString filterStatusFlag = 'PENDING'.obs;
  RxList<BussinessTourPlanModel> BusinessTourPlanList = <BussinessTourPlanModel>[].obs;

  var filterCreatedByController = TextEditingController().obs;
  var filterTourIdController = TextEditingController().obs;
  var filterTouringRegionController = TextEditingController().obs;

  var touringRegionController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
   // clearAllFieldOfFilter();
    getBusinessTourPlanData(pageNumber);
    super.onInit();
  }

  Future<void> refreshList() async {
    pageNumber = 0;
    getBusinessTourPlanData(pageNumber);
  }

  getBusinessTourPlanData(int page_no) {
    try {
      Map data = {
        "created_by": filterCreatedByController.value.text.isEmpty?"":filterCreatedByController.value.text,
        "tour_id": filterTourIdController.value.text.isEmpty?"":filterTourIdController.value.text,
        "touring_region": filterTouringRegionController.value.text.isEmpty?"":filterTouringRegionController.value.text,
        "email_id": email,
        "status": filterStatusFlag.value,
        "rowsPerPage": rowsPerPage,
        "pageNumber": page_no
      };
      loading.value = true;
      _api.businessPlanListGetApiHit(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              if (page_no == 0) {
                BusinessTourPlanList.clear();
              }
              BusinessTourPlanList.addAll(response);
              print('listSize.....${BusinessTourPlanList.length}');
              total_rows = int.parse(BusinessTourPlanList[0].totalRows!);

            } else {
              loading.value = false;
              BusinessTourPlanList.value = [];
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

  BusinessTourPlanHeaderCreate() {
    try {
      Map data = {
        "touring_region": touringRegionController,
        "start_date": startDateController,
        "end_date": endDateController,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanHeaderCreate(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification(
                  "Message !", response[0].message.toString());

            } else {
              loading.value = false;
              Utils.showErrorToastification(
                  "Error !", response[0].message.toString());
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
    filterCreatedByController.value.clear();
    filterTourIdController.value.clear();
    filterTouringRegionController.value.clear();

  }

}