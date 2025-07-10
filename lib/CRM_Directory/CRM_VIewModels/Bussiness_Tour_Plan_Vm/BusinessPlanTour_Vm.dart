
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BusinessTourPlanDetailsModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/BussinessTourPlanModel.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TourPlanAccount_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TouringDistrictModel.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
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
  String StartDate = '', EndDate = '';
  RxString filterStatusFlag = 'PENDING'.obs;
  RxList<BussinessTourPlanModel> BusinessTourPlanList = <BussinessTourPlanModel>[].obs;
  RxList<BusinessTourPlanDetailsModel> BusinessTourPlanDetails_list = <BusinessTourPlanDetailsModel>[].obs;
  RxList<Lines> BusinessTourHourLines = <Lines>[].obs;
  RxList<AlongWithPersonModel> AlongPersonWith_list = <AlongWithPersonModel>[].obs;
  RxList<AlongWithPersonModel> SelectedAlongPersonWith_list = <AlongWithPersonModel>[].obs;
  RxList<TouringDistrictModel> TouringDistirct_list = <TouringDistrictModel>[].obs;
  RxList<TouringDistrictModel> TourType_List = <TouringDistrictModel>[].obs;
  RxList<TourPlanAccountModel> TourPlanAccount_List = <TourPlanAccountModel>[].obs;
  RxList<TourPlanAccountModel> TourPlanContact_List = <TourPlanAccountModel>[].obs;

  var filterCreatedByController = TextEditingController().obs;
  var filterTourIdController = TextEditingController().obs;
  var filterTouringRegionController = TextEditingController().obs;

  var touringRegionController = TextEditingController().obs;
  var startDateController = TextEditingController().obs;
  var endDateController = TextEditingController().obs;

  var AlongPersonWith_controller = TextEditingController();
  var TourPlanDistrict_Controller = TextEditingController();
  var TourPlanAccount_Controller = TextEditingController();
  var MeetingWith_controller = TextEditingController();
  var TourPlanRemarks_Controller = TextEditingController();
  var TourPlanObjective_Controller = TextEditingController();
  var tourDate_Controller = TextEditingController();
  var TourType_Controller = TextEditingController();

  @override
  Future<void> onInit() async {
    email = await sessionManagement.getEmail() ?? '';
    isAdminWritePermission = await sessionManagement.getIsAdminPermission() ?? '';
    clearAllFieldOfFilter();
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
        "touring_region": touringRegionController.value.text,
        "start_date": startDateController.value.text,
        "end_date": endDateController.value.text,
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
              Utils.showToastification("Message !", response[0].message.toString());
              getBusinessTourPlanDetailsApi(response[0].tourId);

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

  BusinessTourPlanHeaderDelete(String TourId) {
    try {
      Map data = {
        "tour_id": TourId,
        "email_id": email
      };
      loading.value = true;
      _api.BusinessTourPlanHeaderDelete(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<BussinessTourPlanModel> response =
            jsonResponse.map((e) => BussinessTourPlanModel.fromJson(e)).toList();
            if (response.length > 0 && response[0].condition == "True") {
              loading.value = false;
              Utils.showToastification("Message !", response[0].message.toString());
              pageNumber = 0;
              getBusinessTourPlanData(pageNumber);
              Get.toNamed(RoutesName.BusinessTourPlanScreen);

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

  getBusinessTourPlanDetailsApi(String? TourId) {
    Map<String , String> data = {
      "tour_id": TourId??""
    };
    loading.value = true;
    _api.BusinessTourPlanDetailsGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<BusinessTourPlanDetailsModel> response =
            JsonResponse.map((e) => BusinessTourPlanDetailsModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              BusinessTourPlanDetails_list.value=response;
              BusinessTourHourLines.value = response[0].lines??[];
              StartDate = BusinessTourPlanDetails_list[0].startDate??"";
              EndDate = BusinessTourPlanDetails_list[0].endDate??"";
              Get.toNamed(RoutesName.BusinessTourPlanDetails);


            } else {
              BusinessTourPlanDetails_list.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
              //service_installation_details_list.value=[];
            }
          } else {

            // service_indent_header_list.value = [];
            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  getEmpMstEmailByApi() {
    Map<String , String> data = {
      "email_id": email
    };
    print(data);
    loading.value = true;
    _api.EmpMstEmailByGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<AlongWithPersonModel> response =
            JsonResponse.map((e) => AlongWithPersonModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              AlongPersonWith_list.value=response;


            } else {
              AlongPersonWith_list.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
            }
          } else {

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  getTourTypeApi() {
    Map<String , String> data = {
      "type": ""
    };
    print(data);
    loading.value = true;
    _api.BusinessTourTypeGet(data, sessionManagement).then(
          (value) {
        print(value);
        final JsonResponse = json.decode(value);
        try{
          if (JsonResponse is List) {
            List<TouringDistrictModel> response =
            JsonResponse.map((e) => TouringDistrictModel.fromJson(e))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              TourType_List.value=response;


            } else {
              TourType_List.value=[];
              Utils.showErrorToastification(
                  "Error!", "No Data Found");
            }
          } else {

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        }catch(e){
          print(e);
        }finally{
          loading.value = false;

        }

      },
    ).onError(
          (error, stackTrace) {
        loading.value = false;
        print(error);
        //service_indent_header_list.value = [];
      },
    ).whenComplete(() {
      loading.value = false;
    },);
  }

  Future<Iterable<TouringDistrictModel>> getTourPlanDistrictTypeApi(String text) async {
    loading.value=true;
    Map data = {
      "filter_district": text,
      "rowsPerPage":50 ,
      "pageNumber": 0
    };
    print("Complany Data....${data}");
    String customer_response =await  _api.TourPlanDistrictApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<TouringDistrictModel> response =
        jsonResponse.map((data) => TouringDistrictModel.fromJson(data)).toList();
        if (response[0].condition == 'True') {
          TouringDistirct_list.value = response;

        } else {

          TouringDistirct_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        TouringDistirct_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      TouringDistirct_list.value = [];
    }
    finally{
      loading.value=false;
    }
    return  TouringDistirct_list.value;
  }

  Future<Iterable<TourPlanAccountModel>> getTourPlanAccountTypeApi(String text) async {
    loading.value=true;
    Map data = {
      "filter_account_name": text,
      "filter_account_owner": "",
      "filter_is_active": 1,
      "rowsPerPage":50 ,
      "pageNumber": 0
    };
    String customer_response =await  _api.TourPlanAccountApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<TourPlanAccountModel> response =
        jsonResponse.map((data) => TourPlanAccountModel.fromJson(data)).toList();
        if (response[0].condition == 'True') {
          TourPlanAccount_List.value = response;

        } else {

          TourPlanAccount_List.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        TourPlanAccount_List.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      TourPlanAccount_List.value = [];
    }
    finally{
      loading.value=false;
    }
    return  TourPlanAccount_List.value;
  }

  BusinessTourPlanContactGet(String accountCode) {
    try {
      Map data = {
        "account_code": accountCode,
        "contact_filter": ''
      };
      loading.value = true;
      _api.BusinessTourPlanContactsGet(data, sessionManagement).then(
            (onValue) {
          final jsonResponse = json.decode(onValue);
          print(onValue);
          if (jsonResponse is List) {
            List<TourPlanAccountModel> response =
            jsonResponse.map((e) => TourPlanAccountModel.fromJson(e)).toList();
            if (response[0].condition == 'True') {
              TourPlanContact_List.value = response;

            } else {

              TourPlanContact_List.value= [];
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