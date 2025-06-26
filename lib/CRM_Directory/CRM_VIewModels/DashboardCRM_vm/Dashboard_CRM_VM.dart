import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/app_colors.dart';
import '../../../models/employeeDetail/employee_details_model.dart';
import '../../../models/profile_upload_model/profile_upload_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_installation_model.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../repository/profile_repository/profile_repository.dart';
import '../../../repository/service_managment_repository_directory/dashboard_repository/dashboard_repository.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/SessionManagment/session_managment.dart';
import 'package:http/http.dart' as http;

class DashboardCrmVm extends GetxController{
  final _api=DashBoardRepository();
  final _apiProfile=ProfileRepository();
  SessionManagement sessionManagement= SessionManagement();
  String email="";
  RxBool loading=false.obs;
  RxList<ServiceInstallationResponse> service_installation_list=<ServiceInstallationResponse>[].obs;

  Map<String, IconData> serviceIcons = {
    'Corrective': Icons.check,
    'Installation': Icons.install_desktop_outlined,
    'Preventive': Icons.preview,
    // Add more mappings as needed
  };



  RxString phone = ''.obs;
  RxString emp_id = ''.obs;
  RxString designation = ''.obs;
  RxString department = ''.obs;
  RxString employee_id = ''.obs;
  RxString grade = ''.obs;
  RxString shift = ''.obs;
  RxString manager_id = ''.obs;
  RxString companey_id = ''.obs;
  RxString state = ''.obs;
  RxString country = ''.obs;
  RxString userRole = ''.obs;
  RxString name = ''.obs;
  final RxString picked_pic = "".obs;

  RxString imageUrl = ''.obs;
  String? version_name='';
  String? version_code='';

  Rx<File?> pickedImagef = Rx<File?>(null);
  Rx<Uint8List> webImagef = Rx<Uint8List>(Uint8List(8));

  List<ProfileUploadModel> profile_list = [];
  @override
  void onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    getSerViceInstallation();
    getEmployee();
    getVersionNameAndCode();
    userRole.value=await sessionManagement.getRoleName() ?? '';
    companey_id.value=await sessionManagement.getCompanyId() ?? '';
    phone.value = await sessionManagement.getPhoneNo() ?? '';
    name.value=await sessionManagement.getName() ?? '';
    imageUrl.value = await sessionManagement.getProfile() ?? '';


    if (imageUrl.value.isNotEmpty) {
      imageUrl.value = AppUrl.BASE_URL + '/' + imageUrl.value.toString();
      print('sessionManagement image ' + imageUrl.value.toString());
    } else {
      imageUrl.value = '';
    }




  }


  Future<void> getVersionNameAndCode()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version_name = packageInfo.version;
    version_code = packageInfo.buildNumber;
  }


  String getImagePath(String? serviceType) {
    switch (serviceType) {
      case 'Installation':
        return 'assests/images/Installation.png';
      case 'Corrective':
        return 'assests/images/corrective.png';
      case 'Preventive':
        return 'assests/images/preventive.png';
    // Add more cases as needed
      default:
        return 'assets/images/default.png';
    }
  }


  Color getColorForIndex(int index) {
    List<Color> colors = [
      AllColors.textColor,
      AllColors.redColor,
      Colors.orange,
    ];
    return colors[index % colors.length]; // Ensure it cycles through the list
  }
  getSerViceInstallation(){
    Map  data=
    {
      "email_id":email,
    };
    loading.value=true;
    print(data);
    _api.serviceInstallationDashBoardApiHit(data, sessionManagement).then((value) {
      print(value);
      final JsonResponse=json.decode(value);
      if(JsonResponse is List){
        List<ServiceInstallationResponse> response=JsonResponse.map((e)
        =>ServiceInstallationResponse.fromJson(e)).toList();
        if(response!=null && response.length>0 && response[0].condition=="True"){
          loading.value=false;
          service_installation_list.value=response;
        }else {
          loading.value=false;
          service_installation_list.value=[];
        }
      }else{
        loading.value=false;
        Utils.sanckBarException("Api Error!", JsonResponse);
      }
    },).onError((error, stackTrace) {
      loading.value=false;
      print(error);
    },);

  }

  getEmployee(){
    Map  data=
    {
      "email_id":email,
    };
    loading.value=true;
    print(data);
    _api.EmployeeGetDashBoardApiHit(data, sessionManagement).then((value) {
      print(value);
      final JsonResponse=json.decode(value);
      if(JsonResponse is List){
        List<EmployeeDetailsGetResponse> response=JsonResponse.map((e)
        =>EmployeeDetailsGetResponse.fromJson(e)).toList();
        if(response!=null && response.length>0 && response[0].condition=="True"){
          loading.value=false;
          sessionManagement.setEmpId(response[0].empId ?? '');
          sessionManagement
              .setDepartment(response[0].department ?? '');
          sessionManagement
              .setDesignation(response[0].designation ?? '');
          sessionManagement.setGrade(response[0].grade ?? '');
          sessionManagement
              .setLocationId(response[0].locationId ?? '');
          sessionManagement.setManagerId(response[0].managerId ?? '');
          sessionManagement.setShiftCode(response[0].shiftCode ?? '');
          sessionManagement.setState(response[0].state ?? '');
          sessionManagement.setCountry(response[0].country ?? '');
          sessionManagement.setIsAdminPermission(response[0].isAdminWritePermission.toString());
          sessionManagement.setUserGeoHierarchy(response[0].userGeoHierarchy ?? []);
          getDataFromSession();
          // service_installation_list.value=response;
          print("isadminwritepermission....${response[0].isAdminWritePermission.toString()}");
        }else {
          loading.value=false;
        }
      }else{
        loading.value=false;
        Utils.sanckBarException("Api Error!", JsonResponse);
      }
    },).onError((error, stackTrace) {
      loading.value=false;
      print(error);
    },);


  }
  Future<void> getDataFromSession() async {

    emp_id.value = await sessionManagement.getEmpId() ?? '';
    designation.value = await sessionManagement.getDesignation() ?? '';
    department.value = await sessionManagement.getDepartment() ?? '';
    grade.value = await sessionManagement.getGrade() ?? '';
    shift.value = await sessionManagement.getShiftCode() ?? '';
    employee_id.value = await sessionManagement.getEmployeeId() ?? '';
    manager_id.value = await sessionManagement.getManagerId() ?? '';
    state.value = await sessionManagement.getState() ?? '';
    country.value = await sessionManagement.getCountry() ?? '';


    print("Country....."+designation.value);
  }


  Future<void> openImageSource(ImageSource source) async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        var selected = File(image.path);
        pickedImagef.value = selected;
        print('moblie image path' + pickedImagef.value.toString());
        uploadImageToServer();
      } else {
        Utils.sanckBarError('Image!', 'no image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        var selected = File(image.path);
        pickedImagef.value = selected;
        var f = await image.readAsBytes();
        webImagef.value = f;
        uploadImageToServer();
      } else {
        Utils.sanckBarError('Image!', 'no image has been picked');
      }
    } else {
      Utils.sanckBarError('Image!', 'something went wrong');
    }
  }

  Future<void> uploadImageToServer() async {
    final server_uri = Uri.parse(AppUrl.profile_upload);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{"email_id": email};

    try {
      if (kIsWeb) {
        // Web platform image handling
        if (webImagef.value.isNotEmpty) {
          clint_request.files.add(http.MultipartFile.fromBytes(
              'image_url', webImagef.value,
              filename: 'web_image.jpg'));
        }
      } else {
        // mobile platform image handling
        if (pickedImagef.value != null) {
          clint_request.files.add(await http.MultipartFile.fromPath(
              'image_url', pickedImagef.value!.path));
        }
      }
      clint_request.fields.addAll(fields);

      _apiProfile.uploadImage(clint_request, sessionManagement).then((value) {
        loading.value = true;
        //print(value);
        final jsonResponse = json.decode(value);
        try {
          if (jsonResponse is List) {
            List<ProfileUploadModel> response_list = jsonResponse
                .map((data) => ProfileUploadModel.fromJson(data))
                .toList();
            if (response_list[0].condition == 'True') {
              loading.value = false;
              profile_list = response_list;
              //pickedImagef.value='';
              imageUrl.value = AppUrl.BASE_URL + '/' + response_list[0].imageUrl!;
              sessionManagement.setProfile(response_list[0].imageUrl!);
              print(imageUrl.value);

              Utils.sanckBarSuccess(
                  'True Message', response_list[0].message.toString());
            } else {
              profile_list = [];
              loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response_list[0].message.toString());
            }
          } else {
            loading.value = false;
            profile_list = [];
            Utils.sanckBarError(
                'API Error',
                jsonResponse["message"] == null
                    ? 'Invalid response format'
                    : jsonResponse["message"]);
          }
        } catch (e) {
          print(e);
          Utils.sanckBarError('Error!', "Api Response Error :" + e.toString());
        }
      }).onError((error, stackTrace) {
        profile_list = [];
        print(error);
        loading.value = false;
        Utils.sanckBarError('Error!', "Api Response Error");
      });
    } catch (e) {
      print(e);
      loading.value = false;
    }
  }

}