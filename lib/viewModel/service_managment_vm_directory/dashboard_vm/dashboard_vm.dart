import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';

import 'package:navigation_drawer_flutter/utils/app_utils.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'package:http/http.dart' as http;
import '../../../current_location/background_task.dart';

import '../../../locat_database/databaseHelper.dart';
import '../../../main.dart';
import '../../../models/employeeDetail/employee_details_model.dart';
import '../../../models/location/LocationData.dart';
import '../../../models/profile_upload_model/profile_upload_model.dart';
import '../../../models/service_managment_model_directory/serviceInstallationModel/service_installation_model.dart';
import '../../../reources/app_url/app_url.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../repository/profile_repository/profile_repository.dart';
import '../../../repository/service_managment_repository_directory/dashboard_repository/dashboard_repository.dart';
class DashBoardViewModel extends GetxController with WidgetsBindingObserver{
  final _api=DashBoardRepository();
  final _apiProfile=ProfileRepository();
  SessionManagement sessionManagement= SessionManagement();
  static BackgroundService? backgroundService;
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
  static RxDouble currentLat = 0.0.obs;
  static RxDouble currentLng = 0.0.obs;
  RxString checkin_response = ''.obs;
  String langLong='';
  RxString imageUrl = ''.obs;
  String? version_name='';
  String? version_code='';
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Rx<File?> pickedImagef = Rx<File?>(null);
  Rx<Uint8List> webImagef = Rx<Uint8List>(Uint8List(8));
  List<LocationData> locationDataList = [];
  List<ProfileUploadModel> profile_list = [];
  StreamSubscription<Position>? positionStream = null;

  RxString current_status = 'Fetching'.obs;
  RxList<EmployeeDetailsGetResponse> employeeList = <EmployeeDetailsGetResponse>[].obs;
  HubConnection? hubConnection;
  @override
  void onInit() async {
    email=await sessionManagement.getEmail() ?? '';
    getSerViceInstallation();
    getEmployee();
    getVersionNameAndCode();
    initCurrentLocationLatLant();
    userRole.value=await sessionManagement.getRoleName() ?? '';
    companey_id.value=await sessionManagement.getCompanyId() ?? '';
    phone.value = await sessionManagement.getPhoneNo() ?? '';
    name.value=await sessionManagement.getName() ?? '';
    imageUrl.value = await sessionManagement.getProfile() ?? '';
    WidgetsBinding.instance?.addObserver(this);


    if (imageUrl.value.isNotEmpty) {
      imageUrl.value = AppUrl.BASE_URL + '/' + imageUrl.value.toString();
      print('sessionManagement image ' + imageUrl.value.toString());
    } else {
      imageUrl.value = '';
    }

    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      fetchLocation();
      try{
        var checkin_session=await sessionManagement.getCheckIn()??'';
        print('LocationBg : init Session =>'+checkin_session.toString());
        if(checkin_session=="CHECKIN"){
          if (backgroundService == null){
            backgroundService = BackgroundService(sessionManagement);
            backgroundService!.initializeService();
          }

          // Call the onStart method on the instance.
          if (backgroundService!.getServiceInstance() != null &&
              !await backgroundService!.getServiceInstance()!.isRunning()) {
            backgroundService!.getServiceInstance()!.startService();
          }
        }

      }catch(e){}

    } else {
      print("Elseee......");
      getEmployee();
    }

    // thread
    //todo all offline data send to server.....

    locationDataList = (await _databaseHelper.getAllLocationData());
    if (locationDataList != null && locationDataList.length > 0) {
      // insertLocationCoordinates(locationDataList, 'OfflineTable');
    }
    //todo user is online the start hitting api   -- checkin session and fetch location if true
    checkGps();
  }


  Future<void> checkGps() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      try {
        await Geolocator.getCurrentPosition();
        enabled = true;
      } catch (e) {
        _handlegps();
      }
    }


  }
  Future<bool> _handlegps() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      Utils.showErrorToastification(
          "Location",
          'Location permission are  denied.'
              'Location services are disabled. Please enable the services');
      checkGps();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showErrorToastification("Location", 'Location permission are  denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.showErrorToastification("Location",
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }


  @override
  void dispose() {
    // Todo Remove the observer when your widget is disposed
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> fetchLocation() async {
    print("Fatch Loaction");
    checkin_response.value = await sessionManagement.getCheckIn() ?? '';
    print(checkin_response.value);
    if (checkin_response.value != null && checkin_response.value == 'CHECKIN') {
      final hasPermission = await _handleLocationPermission();
      print("Permission Granted");
      if (!hasPermission) return;
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        //distanceFilter: 10,
        //  timeLimit: Duration(seconds: 10)
      );
      if (positionStream == null) {
        positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position position) async {
              print(position == null
                  ? 'Unknown'
                  : '${position.latitude.toString()}, ${position.longitude.toString()}');

              //Utils.sanckBarSuccess('Location Updates :', position!.latitude.toString() + position.longitude.toString());

              //todo hit api for send gps cordinate
              List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude,
              );
              LocationData? locationData = null;
              if (placemarks != null && placemarks.length > 0) {
                print("Location Null ");
                Placemark placemark = placemarks[0];
                locationData = LocationData(
                  latitude: position.latitude,
                  longitude: position.longitude,
                  area: placemark.street ?? "",
                  locality: placemark.subLocality ?? "",
                  postal_code: placemark.postalCode ?? "",
                  country: placemark.country ?? "",
                );
              } else {
                print("AlreadyLocation Null ");
                locationData = LocationData(
                  latitude: position.latitude,
                  longitude: position.longitude,
                  area: "",
                  locality: "",
                  postal_code: "",
                  country: "",
                );
              }
              print("Get Location Null ");
              currentLat.value = locationData.latitude;
              currentLng.value = locationData.longitude;
              current_status.value = 'Fetched';
              print('currentlat' + currentLat.value.toString());
              print('currentlat' + currentLng.value.toString());
              // insertLocationCoordinates([locationData], '');
            });
      }
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return true;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.sanckBarError("Location", 'Location permission are  denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.sanckBarError("Location",
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
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

      case 'Reopen':
        return 'assests/images/Reopen.png';
    // Add more cases as needed
      default:
        return '';
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

  getEmployee() {
    Map  data= {
      "email_id":email,
    };

    try{
      loading.value=true;
      print(data);
      _api.EmployeeGetDashBoardApiHit(data, sessionManagement).then((value)async {
        print(value);
        final JsonResponse=json.decode(value);
        if(JsonResponse is List){
          List<EmployeeDetailsGetResponse> response=JsonResponse.map((e)
          =>EmployeeDetailsGetResponse.fromJson(e)).toList();
          if(response!=null && response.length>0 && response[0].condition=="True"){
            loading.value=false;
            employeeList.value=response;
            print('Check in  : ' + response[0].checkIn.toString());
            if (response[0].checkIn! > 0) {
              sessionManagement.setCheckIn('CHECKIN');
              sessionManagement.setStartTime(response[0].shiftStartTime ?? '');
              sessionManagement.setEndTime(response[0].shiftEndTime ?? '');
            } else {
              print("Else dash board");
              sessionManagement.setCheckIn('');
            }
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
            getDataFromSession();
            var checkin_session=await sessionManagement.getCheckIn()??'';
            print('LocationBg : after empdetail Session =>'+checkin_session.toString());
            if(checkin_session=="CHECKIN"){
              try {
                fetchLocation();
                //todo for avoid crash application due to start foreground service initialize after 10 second instead of at a time
                // Future.delayed(Duration(seconds: 10), () async {
                if (backgroundService == null){
                  print("Service Initilize");
                  backgroundService = BackgroundService(sessionManagement);
                  await backgroundService!.initializeService();
                }
                if (backgroundService!.getServiceInstance() != null &&
                    !await backgroundService!.getServiceInstance()!.isRunning()) {
                  print("All readyService Initilize");
                  backgroundService!.getServiceInstance()!.startService();
                  print('service is started');
                } else {
                  print('after 5 second still null service is null');
                }

                // });
              } catch (e) {
                print(e);
                print("Exception dashBoard");
              }
            }
          }else {
            print("rittkk");
            sessionManagement.clearSession();
            Get.offAllNamed(RoutesName.loginScreen);
            Utils.showErrorToastification(
                'Message', "Employee Details Not Found Of This User!");
            loading.value=false;
          }
        }else{
          loading.value=false;
          Utils.sanckBarException("Api Error!", JsonResponse);
        }
      },).onError((error, stackTrace) {
        loading.value=false;
        sessionManagement.clearSession();
        Get.offAllNamed(RoutesName.loginScreen);
        // Utils.sanckBarError(
        //     'Message', "Employee Details Not Found Of This User!");

        Utils.showErrorToastification("Api Error!", error.toString());
        print(error);
      },);
    }catch(e){
      Utils.showErrorToastification('Exception Message!', e.toString());
      print(e);

    }
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
    if (!kIsWeb){
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        var selected = File(image.path);
        pickedImagef.value = selected;
        print('mobile image path' + pickedImagef.value.toString());
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

  initCurrentLocationLatLant()async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled && (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse)) {
      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      langLong = ('${userLocation.latitude},${userLocation.longitude}') as String;
      print("gfgmkdfgkfdkgfg"+langLong.toString());
    //  getCurrentWeather();

    }

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        MyApp.app_CurrentStatus = "Stop";
        print('application is inactive');
        break;
      case AppLifecycleState.detached:
        MyApp.app_CurrentStatus = "Stop";
        print('application is detached');
        break;
      case AppLifecycleState.resumed:
        print('application is resumed');
        MyApp.app_CurrentStatus = "Running";
        break;
      case AppLifecycleState.hidden:
        MyApp.app_CurrentStatus = "Stop";
        print('application is hidden');
        break;
      case AppLifecycleState.paused:
        MyApp.app_CurrentStatus = "Stop";
        print('application is paused');
        break;
    }
  }

}