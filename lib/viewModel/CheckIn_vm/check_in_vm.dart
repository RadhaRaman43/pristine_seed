import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/repository/checkIn_repository/checkIn_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import 'package:http/http.dart' as http;
import '../../constants/static_methods.dart';
import '../../current_location/current_location.dart';
import '../../models/checkInModel/checkIn_model.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../../models/checkInModel/vehicleType_model.dart';
import '../../models/checkInModel/vehicle_no_model.dart';
import '../../reources/app_url/app_url.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class CheckInViewModel extends GetxController{

  final _api=CheckInRepository();

  SessionManagement sessionManagement= SessionManagement();
  //RxBool loading=false .obs;
  RxBool loading=true .obs;
  RxBool isVehicle = true.obs;
  var typeAheadControllerVehicle = TextEditingController();
  var place_edit_controller = TextEditingController().obs;
  var vehicle_no_controller = TextEditingController();
  RxBool isCheckBoxChecked = false.obs;
  var checkin_opening_km_controller = TextEditingController().obs;
  RxBool isvehicleNo=true.obs;
  RxInt isManiTainKm = 0.obs;
  RxInt isExpend_line_posion = (-1).obs;
  RxBool isExpend = false.obs;
  RxString inFront_image_path = ''.obs;
  RxString outFront_image_path = ''.obs;
  RxString inBack_image_path = ''.obs;
  RxString outBack_image_path = ''.obs;
  var opening_km_controller = TextEditingController();
  var closing_km_controller = TextEditingController();
  var da_controller = TextEditingController();
  var remarks_controller = TextEditingController();
  var typeAheadControllerEmployee = TextEditingController();
  RxBool isVehicleHiding=false.obs;
  RxBool isShowCustomerDetails = false.obs;

  final ImagePicker _picker_checkout = ImagePicker();

  List<CheckInResponse> current_checkIn_response = [];
  String dateTime = '';
  RxBool isvisible = false.obs;
  static String device_id='0';
  static int battery_level=0;

  RxString place = ''.obs;

  final ImagePicker _picker = ImagePicker();
  RxList<VehicleTypeResponse> vehicleTypeList = <VehicleTypeResponse>[].obs;

  String email="";
  int expense_current_index = -1.obs;

  List<EmpMasterResponse> employeeTypeList = [];
  RxList<VehicleNoResponse> vehicleNoList = <VehicleNoResponse>[].obs;
  Rx<VehicleTypeResponse>? selected_vehicle_type=VehicleTypeResponse().obs;

  double from_latitude = 0.0; // Variable to store latitude
  double from_longitude = 0.0;
  String from_locality = '';
  String from_area = '';
  String from_postal_code = '';
  String from_country = '';
  String curretn_date = '';
  RxString curretn_time = ''.obs;
  RxString total_work_time = ''.obs;
  RxString grade = ''.obs;
  final RxString name = ''.obs;
  late Timer _timer;
  LocationData locationData = LocationData();

//todo add expenses...

  RxBool isAddExpense = false.obs;




  @override
  void onInit() async {
    email=await sessionManagement.getEmail()?? "";
    device_id=await getUniqueDeviceId();
    battery_level=await getBatteryPercentage();
    name.value = await sessionManagement.getName() ?? '';
    grade.value = await sessionManagement.getGrade() ?? '';
    print(grade.value);
    currentRunningCheckInData();
    //todo for get current date and time...............
    curretn_date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    //todo Start a timer to update the current time every second
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      curretn_time.value = DateFormat('HH:mm:ss').format(DateTime.now());
      try {
        DateTime parsedDate = DateTime.parse(
            current_checkIn_response[0].createdOn.toString());
        Duration diff = DateTime.now().difference(parsedDate);
        int diffrence_in_hour = diff.inHours;
        int day_diffrence = (diffrence_in_hour / 24).toInt();
        int day_difference_hour = (diffrence_in_hour % 24).toInt();

        if(day_diffrence<=0)
          total_work_time.value =
              day_difference_hour.toString() + " Hours ";
        else
          total_work_time.value =
              day_diffrence.toString() + " Day " + day_difference_hour.toString() + " Hours ";
        print( total_work_time.value);
      }catch(e){
        print(e);
      }
      update();

    });

    //todo for get current location.................
    await locationData.getCurrentLocation();
    from_latitude = locationData.latitude;
    from_longitude = locationData.longitude;
    from_locality = locationData.locality;
    from_area = locationData.area;
    from_country = locationData.country;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer!=null && _timer.isActive)
      _timer?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    if(_timer!=null && _timer.isActive)
      _timer?.cancel();
    super.onClose();
  }



  //todo for device get device unique id..........
  Future<String> getUniqueDeviceId() async {
    String uniqueDeviceId = '';
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId = iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
      print(uniqueDeviceId);
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = androidDeviceInfo.id; // unique ID on Android
      print(uniqueDeviceId);
    }
    return uniqueDeviceId;
  }
  Future<int> getBatteryPercentage() async {
    var battery = Battery();
    final int level = await battery.batteryLevel;
    print(level);
    return level; // Returning the battery level directly as an integer
  }
  Future<void> currentRunningCheckInData() async {
    loading.value = true;
    Map data = {
      'document_no': '',
      'created_by': email,
    };

    _api.currentRunningCheckInDataApiHit(data, sessionManagement).then((value) {
      try {
        List<CheckInResponse> response_list = (json.decode(value) as List)
            .map((i) => CheckInResponse.fromJson(i))
            .toList();
        if (response_list!=null && response_list.length>0 && response_list[0].condition.toString() == "True") {
          current_checkIn_response=response_list;
          loading.value = false;
          dateTime = current_checkIn_response[0].createdOn.toString();
          Get.toNamed(RoutesName.checkout_screen);
          getAndSetData();
          getVehicleNumber(current_checkIn_response[0].vehileType.toString(),'');
        } else {
          current_checkIn_response=[];
          loading.value = false;
          //Utils.sanckBarError('Message', current_checkIn_response[0].message.toString());
          getVehicletype();
          getEmployeeMasterApi();
          getAndSetData();
        }
      } catch (e) {
        current_checkIn_response=[];
        loading.value = false;
        Utils.showErrorToastification('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      current_checkIn_response=[];
      loading.value = false;
      Utils.showErrorToastification('Api Exception onError', error.toString());
    });
  }

  Future getFrontImage(String flag,String path) async {
    // final image=await _picker.getImage(source: ImageSource.camera,maxHeight:50,maxWidth:50,imageQuality: 80);
    var image = null;
    try {
      if (flag == 'CheckIn') {
        image = await _picker.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
        if (image != null) {
          inFront_image_path.value = image.path.toString();
        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any front image");
        }
      } else if (flag == 'CheckOut') {
        image = await _picker_checkout.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
        if (image != null) {
          outFront_image_path.value = image.path.toString();
        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any front image");
        }
      }
      else if (flag == 'Expense') {
        image = await _picker_checkout.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
        if (image != null) {
          if(path=='image_one'){
            //file_path1.value = image.path.toString();
          current_checkIn_response[0].lines![expense_current_index].local_image_path1=image.path.toString();
          }
          else if(path=='image_two'){
            current_checkIn_response[0].lines![expense_current_index].local_image_path2=image.path.toString();
          }
          else if(path=='image_three'){
            current_checkIn_response[0].lines![expense_current_index].local_image_path3=image.path.toString();
          }
          else if(path=='image_four'){
           current_checkIn_response[0].lines![expense_current_index].local_image_path4=image.path.toString();
          }

        //  this.isAddExpense.value = false;
        //  this.isAddExpense.value = true;

        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any front image");
        }
      }
    } catch (e) {
      Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  Future getBackImage(String flag) async {
    var image = null;
    try {
      if (flag == 'CheckIn') {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 500,
          maxWidth: 500,
          imageQuality: 70,
        );
        if (image != null) {
          inBack_image_path.value = image.path;
        } else {
          Utils.sanckBarError(
            "Image Error!",
            "You have not selected any front image",
          );
        }
      }

      /*if (flag == 'CheckIn') {
        image = await _picker.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
        if (image != null) {
          inBack_image_path.value = image.path.toString();
        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any back image");
        }
      } */




      else if (flag == 'CheckOut') {
        image = await _picker_checkout.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
        if (image != null) {
          outBack_image_path.value = image.path.toString();
        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any back image");
        }
      }
    } catch (e) {
      Utils.sanckBarError("Image Exception!", e.toString());
    }
  }


  getVehicletype() {
    if(vehicleTypeList==null || vehicleTypeList.isEmpty){
      Map data = {
        'flag': 'Get',
        'email_id': email
      };

      _api.vehileTypeGetInsert(data, sessionManagement).then((value) {
        print("vehicle list is1 ::$value");
        try {
          loading.value = false;
          List<VehicleTypeResponse> response_list= (json.decode(value) as List)
              .map((i) => VehicleTypeResponse.fromJson(i))
              .toList();

          if (response_list!=null && response_list.length>0 && response_list[0].condition.toString() == "True") {
            vehicleTypeList.value=response_list;

          } else {
            vehicleTypeList.value=[];
            Utils.sanckBarError('Message', (response_list!=null && response_list.length>0)?response_list[0].message.toString():"Record Not Found.");
          }
        } catch (e) {
          vehicleTypeList.value=[];
          print(e);
          Utils.sanckBarException('Exception Vehicle Type :', e.toString());
        }
      }).onError((error, stackTrace) {
        vehicleTypeList.value=[];
        Utils.sanckBarError('Api Exception onError', error.toString());
      });
    }
  }


  Future<void> getAndSetData()async {
    if(current_checkIn_response!=null && current_checkIn_response.length>0){
      vehicle_no_controller.text =await current_checkIn_response[0].vehicleNo!.isNotEmpty?
      current_checkIn_response[0].vehicleNo!:'';

      opening_km_controller.text = await current_checkIn_response[0].openingKm!>0?
      current_checkIn_response[0].openingKm.toString():'0';

      closing_km_controller.text = await current_checkIn_response[0].closingKm!>0?
      current_checkIn_response[0].closingKm.toString():'0';

      remarks_controller.text = await (current_checkIn_response[0].remarks!.isNotEmpty?
      current_checkIn_response[0].remarks:"")!;

      da_controller.text = await (current_checkIn_response[0].daCode!.isNotEmpty?
      current_checkIn_response[0].daCode:"")!;
    }else{
      vehicle_no_controller.text ='';
      opening_km_controller.text = '0';
      closing_km_controller.text = '0';
      remarks_controller.text = "";
      da_controller.text ="";
    }

  }


  Future<void> submitCheckInDataApi1(TextEditingController place) async {

    if (typeAheadControllerVehicle.text==null || typeAheadControllerVehicle.text.isEmpty) {
      Utils.sanckBarError('Error : ', 'Please Select Vehicle Type.');
      return;
    }

    if (place.value.text == null || place.value.text == "") {
      Utils.sanckBarError('Error : ', 'Please Enter Place Of Visit.');
      return;
    }

    if(isCheckBoxChecked.value && typeAheadControllerEmployee.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Working With Email.');
      return;
    }

    if(selected_vehicle_type!.value.isMaintainKm!=null && selected_vehicle_type!.value.isMaintainKm!>0 && isCheckBoxChecked==false){
      if(vehicle_no_controller.text.isEmpty && checkin_opening_km_controller.value.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select Vehicle No.');
        return;
      }
    }
    /* if(vehicle_no_controller.text==null || vehicle_no_controller.text=="")
    {
      Utils.sanckBarError('Message : ', 'Vehicle No. can not be empty');
      return;
    }*/

    if( inFront_image_path.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Front Image.');
      return;
    }
    if(isManiTainKm.value>0){
      if(!isCheckBoxChecked.value && inFront_image_path.isEmpty && inBack_image_path.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select Front And Back Images.');
        return;
      }



      if(!isCheckBoxChecked.value && inBack_image_path.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select Back Image.');
        return;
      }
      if(isCheckBoxChecked.value && typeAheadControllerEmployee.text.toLowerCase()==email.toLowerCase()){
        Utils.sanckBarError('Error : ', 'Please Select Another Email,Because This Is Your Mail Id.');
        return;
      }

    }

    loading.value = true;
    final server_uri = Uri.parse(AppUrl.markCheckIn);
    final clint_request = http.MultipartRequest('POST', server_uri);

    var fields = <String, String>{
      "vehicle_no": vehicle_no_controller.text.isEmpty?'0':vehicle_no_controller.text,
      "opening_km": checkin_opening_km_controller.value.text.isEmpty?'0':checkin_opening_km_controller.value.text,
      "vehile_type_id": selected_vehicle_type!.value.id.toString(),
      "is_universal": selected_vehicle_type!.value.isUniversal.toString(),
      "place_to_visit": place.value.text,
      "is_working_with": isCheckBoxChecked.value ? "1" : "0",
      "working_with_email": typeAheadControllerEmployee.text,
      "created_by": email,
      'location_data.start_date': curretn_date,
      'location_data.from_latitude': from_latitude.toString(),
      'location_data.from_longitude': from_longitude.toString(),
      'location_data.from_locality': from_locality,
      'location_data.from_area': from_area,
      'location_data.from_postal_code': from_postal_code,
      'location_data.from_country': from_country,
      'location_data.created_by': email,
      "location_data.device_id": device_id,
      "location_data.battery_per": battery_level.toString(),
    };
    clint_request.fields.addAll(fields);
    if (inFront_image_path.isNotEmpty) {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'front_image', inFront_image_path.value));
    }
    if (inBack_image_path.isNotEmpty && !isCheckBoxChecked.value) {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'back_image', inBack_image_path.value));
    }
    //--hit api
    _api.SubmitCheckinpostFormApi(clint_request, sessionManagement)
        .then((value) {
      print(value);
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<CheckInResponse> checkInResponses =
        jsonResponse.map((data) => CheckInResponse.fromJson(data)).toList();
        if (checkInResponses[0].condition == 'True') {
          Utils.sanckBarSuccess('True Message',checkInResponses[0].message!);
          current_checkIn_response=[];
          loading.value = false;
          typeAheadControllerVehicle.clear();
          place_edit_controller.value.clear();
          typeAheadControllerEmployee.clear();
          isCheckBoxChecked.value = false;
          inFront_image_path.value = '';
          inBack_image_path.value = '';
          sessionManagement.setCheckIn('CHECKIN');
          //currentRunningCheckInData();
          Get.offAllNamed(RoutesName.homeScreen);
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', checkInResponses[0].message.toString());
        }
      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }


  Future<void> SubmitCheckOutDataApi(TextEditingValue vehivle, TextEditingValue opening, TextEditingValue remarks) async {
    double total_km = 0.0;
    double travelling_amt = 0.0;
    double opening_km=0.0;
    double closing_km=0.0;
    try {
      opening_km = double.parse(opening.text);
      closing_km = double.parse(closing_km_controller.value.text);
      total_km = closing_km - opening_km;
      double? rate_per_km = current_checkIn_response[0].ratePerKm;
      travelling_amt = total_km * rate_per_km!;
    } catch (e) {
      opening_km=0;
      closing_km=0;
      total_km=0;
      travelling_amt=0;
    }

    if (current_checkIn_response[0].isMaintainKm!>0 && current_checkIn_response[0].isWorkingWith==0 && (vehivle.text==null || vehivle.text=='')) {
      Utils.sanckBarError('Error : ', 'Please Select Vehicle No.');
      loading.value = false;
      return;
    }
    if (current_checkIn_response[0].isMaintainKm!>0 &&  current_checkIn_response[0].isWorkingWith==0 && (opening.text==null || opening.text=='')) {
      Utils.sanckBarError('Error : ', 'Please Enter Closing Km.');
      loading.value = false;
      return;
    }

    if (current_checkIn_response[0].isMaintainKm!>0 &&  current_checkIn_response[0].isWorkingWith==0 && (closing_km_controller.text==null || closing_km_controller.text=='')) {
      Utils.sanckBarError('Error : ', 'Please Enter Closing Km.');
      loading.value = false;
      return;
    }
    if (current_checkIn_response[0].isMaintainKm!>0 &&  current_checkIn_response[0].isWorkingWith==0 && (opening_km>=closing_km)) {
      Utils.sanckBarError('Error : ', 'opening km can not Greater than closing km.');
      loading.value = false;
      return;
    }
    /*if ((da_controller.text==null || da_controller.text=='')) {
      Utils.sanckBarError('Error : ', 'Please Enter Da Amount .');
      loading.value = false;
      return;
    }*/

    if ((remarks.text==null || remarks.text=='')) {
      Utils.sanckBarError('Error : ', 'Please Enter Remarks.');
      loading.value = false;
      return;
    }
    if(outFront_image_path.isEmpty &&  current_checkIn_response[0].checkOutImages!.frontImage!.contains('no_image_placeholder.png')){
      Utils.sanckBarError('Error : ', 'Please Select Front Image.');
      loading.value = false;
      return;
    }

    if (current_checkIn_response[0].isMaintainKm!>0 && current_checkIn_response[0].isWorkingWith==0
        && (outBack_image_path.toString()==null || outBack_image_path.toString()=='')
        &&(current_checkIn_response[0].checkOutImages!.backImage==null ||current_checkIn_response[0].checkOutImages!.backImage!.contains('no_image_placeholder.png'))) {
      Utils.sanckBarError('Error : ', 'Check Out Back Image can not Blank.');
      loading.value = false;
      return;
    }

    loading.value = true;
    final server_uri = Uri.parse(AppUrl.markCheckOutSaveData);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var openingKm = opening.text.toString();
    var closingKm = closing_km_controller.value.text;

// Check if opening_km is empty or blank, and set it to 0 if true
    if (openingKm.isEmpty) {
      openingKm = '0';
    }

// Check if closing_km is empty or blank, and set it to 0 if true
    if (closingKm.isEmpty) {
      closingKm = '0';
    }
    var fields = <String, String>{
      "document_no": current_checkIn_response[0].documentNo.toString(),
      "vehicle_no": vehivle.text.toString(),
      "opening_km":openingKm,
      "closing_km": closingKm,
      "total_km": total_km.toString(),
      'travelling_amount': travelling_amt.toString(),
      "da_code": '',//da_controller.text.toString(),
      'da_name': '',
      'remarks': remarks.text.toString(),
      'expense_date': curretn_date.toString()
    };
    clint_request.fields.addAll(fields);
    if (outFront_image_path!=null && outFront_image_path!='') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'front_image', outFront_image_path.value));
    }

    if (outBack_image_path!=null && outBack_image_path!='') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'back_image', outBack_image_path.value));
    }
    //--hit api
    _api.SubmitCheckOutpostFormApi(clint_request, sessionManagement)
        .then((value) {
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<CheckInResponse> checkInResponses =
        jsonResponse.map((data) => CheckInResponse.fromJson(data)).toList();
        if (checkInResponses[0].condition == 'True') {
          loading.value = false;
          current_checkIn_response=checkInResponses;
          Get.toNamed(RoutesName.addExpanseScreen, preventDuplicates: false);
          print(
              'travelling amount+${current_checkIn_response[0].travellingAmount}');
          Utils.sanckBarSuccess('Message!', checkInResponses[0].message.toString());

        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', checkInResponses[0].message.toString());
          print('messagefalse+${checkInResponses[0].message.toString()}');
        }

        Get.delete<CheckInResponse>();
      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }


  checkOutComplete() {
    Map data = {
      'document_no': current_checkIn_response[0].documentNo.toString(),
      'email_id': current_checkIn_response[0].createdBy.toString(),
    };
    _api.checkOutComplete(data, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<CheckInResponse> api_response =
        jsonResponse.map((data) => CheckInResponse.fromJson(data)).toList();
        if (api_response[0].condition == 'True') {
          loading.value = false;
          Utils.sanckBarSuccess('Message!', api_response[0].message.toString());
          current_checkIn_response = [];
          sessionManagement.setCheckIn('');
          //todo stop background service
          StaticMethod.stopBackgroundService();

          //Get.toNamed(RoutesName.checkInScreen, preventDuplicates: false);
          Get.offAllNamed(RoutesName.homeScreen);
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', api_response[0].message.toString());
        }
      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }


  getVehicleNumber(String filter_vehileType,String filter_vehicle_no) {
    Map data = {
      'vehicle_type': filter_vehileType,
      'assign_person_email': email,
      'vehicle_no': filter_vehicle_no,
    };

    _api.getVehicleDetails(data, sessionManagement).then((value) {
      try {
        loading.value = false;
        List<VehicleNoResponse> response_data = (json.decode(value) as List)
            .map((i) => VehicleNoResponse.fromJson(i))
            .toList();
        if (response_data[0].condition.toString() == "True") {
          vehicleNoList.value=response_data;
        } else {
          vehicleNoList.value=[];
          //Utils.sanckBarError('Message', vehicleTypeList[0].message.toString());
        }
      } catch (e) {
        vehicleNoList.value=[];
        print(e);
        //  Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      vehicleNoList.value=[];
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }


  Future<Iterable<EmpMasterResponse>> searchCustomer(String query) async {
    if (query == '') {
      return const Iterable<EmpMasterResponse>.empty();
    }
    Map data = {
      'filter_name': '',
      'filter_email': query,
      'filter_location_id': '',
      'email_id': email,
      'rowsPerPage': 10,
      'pageNumber': 0,
    };
    /* Map data = {
      'customer_no': '',
      'customer_name': query,
      'customer_type': 'customer',
      "email_id": email_id,
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude": lng.value==0.0? "" : (lng.toString()),
      'row_per_page': 10,
      'page_number': 0
    };*/


    /*  _api.getEmployeeMasterApiHit(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0].condition.toString() == "True") {
          employeeTypeList=emp_masterResponse;
        } else {
          employeeTypeList=[];
          Utils.sanckBarError(
              'Message', emp_masterResponse[0].message.toString());
        }
      } catch (e) {
        employeeTypeList=[];
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      employeeTypeList=[];
      Utils.sanckBarError('Api Exception onError', error.toString());
    });*/


    String employee_response =await _api.getEmployeeMasterApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(employee_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<EmpMasterResponse> response =
        jsonResponse.map((data) => EmpMasterResponse.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          employeeTypeList = response;

        } else {
          // Utils.sanckBarException('False!', response[0].message!);
          employeeTypeList = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        employeeTypeList = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      employeeTypeList = [];
    }
    return employeeTypeList;
  }





  getEmployeeMasterApi() {
    Map data = {
      'filter_name': '',
      'filter_email': '',
      'filter_location_id': '',
      'email_id': email,
      'rowsPerPage': '100',
      'pageNumber': '0',
    };
    _api.getEmployeeMasterApiHit(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0].condition.toString() == "True") {
          employeeTypeList=emp_masterResponse;
        } else {
          employeeTypeList=[];
          Utils.sanckBarError(
              'Message', emp_masterResponse[0].message.toString());
        }
      } catch (e) {
        employeeTypeList=[];
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      employeeTypeList=[];
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }


  Future<void> expense_line_save_DataApi(String expense_amt,) async {
    final server_uri = Uri.parse(AppUrl.expanseLineSaveSaveData);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{
      "document_no": current_checkIn_response[0]
          .lines![expense_current_index]
          .documentNo
          .toString(),
      "expense_name": current_checkIn_response[0]
          .lines![expense_current_index]
          .expenseName
          .toString(),
      "expense_amount": expense_amt.isEmpty?'0':expense_amt.toString(),
    };
    clint_request.fields.addAll(fields);
    if (current_checkIn_response[0]
        .lines![expense_current_index]
        .local_image_path1 !=
        null &&
        current_checkIn_response[0]
            .lines![expense_current_index]
            .local_image_path1 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image',
          current_checkIn_response[0]
              .lines![expense_current_index]
              .local_image_path1
              .toString()));
    }
    if (current_checkIn_response[0]
        .lines![expense_current_index]
        .local_image_path2 !=
        null &&
        current_checkIn_response[0]
            .lines![expense_current_index]
            .local_image_path2 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image2',
          current_checkIn_response[0]
              .lines![expense_current_index]
              .local_image_path2
              .toString()));
    }
    if (current_checkIn_response[0]
        .lines![expense_current_index]
        .local_image_path3 !=
        null &&
        current_checkIn_response[0]
            .lines![expense_current_index]
            .local_image_path3 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image3',
          current_checkIn_response[0]
              .lines![expense_current_index]
              .local_image_path3
              .toString()));
    }
    if (current_checkIn_response[0]
        .lines![expense_current_index]
        .local_image_path4 !=
        null &&
        current_checkIn_response[0]
            .lines![expense_current_index]
            .local_image_path4 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image4',
          current_checkIn_response[0]
              .lines![expense_current_index]
              .local_image_path4
              .toString()));
    }
    loading.value = true;
    //--hit api
    _api.submitExpLinepostFormApi(clint_request, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<CheckInResponse> response_data =
        jsonResponse.map((data) => CheckInResponse.fromJson(data)).toList();

        if (response_data[0].condition == 'True') {
          current_checkIn_response=response_data;
          loading.value = false;
          this.isAddExpense.value = false;
          this.isAddExpense.value = true;
          this.isExpend.value=false;
          Utils.sanckBarSuccess(
              'Message!', current_checkIn_response[0].message.toString());
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', response_data[0].message.toString());
        }

      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }




}