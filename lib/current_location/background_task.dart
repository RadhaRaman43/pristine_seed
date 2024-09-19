import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locat_database/databaseHelper.dart';
import '../models/common_response/common_response.dart';
import '../models/location/LocationData.dart';
import '../repository/background_service_repository/backGroundService_repository.dart';
import '../viewModel/SessionManagment/session_managment.dart';
import '../viewModel/service_managment_vm_directory/dashboard_vm/dashboard_vm.dart';

class BackgroundService {
  static SessionManagement sessionManagement=SessionManagement();

  BackgroundService(SessionManagement session){
    sessionManagement=session;
  }

  FlutterBackgroundService? service=  FlutterBackgroundService();
  FlutterBackgroundService? getServiceInstance(){
    return service;
  }
  void setServiceInstance(FlutterBackgroundService? ser){
     service=ser;
  }
  Future<void> initializeService() async {
    if(service==null)
    service = FlutterBackgroundService();
     //var service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_bg_service_small'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service!.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: true,

        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    service?.startService();
  }
  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.reload();
    final log = preferences.getStringList('log') ?? <String>[];
    log.add(DateTime.now().toIso8601String());
    await preferences.setStringList('log', log);

    return true;
  }
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("hello", "world");

    /// OPTIONAL when use custom notification
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      print("Start Service....... Second ");
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          /// OPTIONAL for use custom notification
          /// the notification id must be equals with AndroidConfiguration when you call configure() method.
          flutterLocalNotificationsPlugin.show(
            888,
            'COOL SERVICE',
            'Awesome ${DateTime.now()}',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'my_foreground',
                'MY FOREGROUND SERVICE',
                icon: 'ic_bg_service_small',
                ongoing: true,
              ),
            ),
          );
          print("nhjfgjhkfndjkhndfgjknhk");

          // if you don't using custom notification, uncomment this
          // service.setForegroundNotificationInfo(
          //   title: "My App Service ",
          //   content: "Updated at ${DateTime.now()}",
          // );
          updateLocation(service);

        }
      }
      else{
        // updateLocation(service);
      }

      showNotificationForCheckOut(service);
      /// you can see this log in logcat
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

      // test using external plugin
      final deviceInfo = DeviceInfoPlugin();
      String? device;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": device,
        },
      );
    });
  }

  static void updateLocation(ServiceInstance service) async {
    var checkin_session=await sessionManagement.getCheckIn()??'';
    print('LocationBgBack : Session =>'+checkin_session.toString());
    print("bikkuuu.....");

    try {
      print("bikkuuu.....");
      bool serviceEnabled;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("ritik......");
      print('LocationBg : '+permission.toString()+"  Location :"+serviceEnabled.toString());
      if (serviceEnabled && (permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
        if (checkin_session=="CHECKIN") {
          Position userLocation = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          print(userLocation);
          DashBoardViewModel.currentLat.value=userLocation.latitude;
          DashBoardViewModel.currentLng.value=userLocation.longitude;
          print('dash_vm:${DashBoardViewModel.currentLng.value}');
          if (service is AndroidServiceInstance) {
            service.setForegroundNotificationInfo(
              title: "Location Service",
              content:
              "Lat: ${userLocation.latitude} lon: ${userLocation.longitude}",
            );
            print("LocationBg => Lat: ${userLocation.latitude} lon: ${userLocation.longitude}");
            sendLatLng(userLocation.latitude,userLocation.longitude);
          }
        }
      }
      else {
        if (service is AndroidServiceInstance) {
          service.setForegroundNotificationInfo(
            title: "Location Service",
            content:
            "Wait For Location Permission.Updated at ${DateTime.now()}",
          );
        }
        // print("Please Allow Location Service.");
      }
    } catch (e) {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Location Service",
          content: e.toString(),
        );
      }
    }
  }

  static void sendLatLng(double latitude, double longitude)async {
    //print("LocationBg 1=> Lat: ${latitude} lon: ${longitude}");
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    LocationData ?locationData=null;
   // print("LocationBg 2=> Lat: ${latitude} lon: ${longitude}");
    if(placemarks!=null && placemarks.length>0){
      Placemark placemark = placemarks[0];
      locationData = LocationData(
        latitude: latitude,
        longitude: longitude,
        area: placemark.street ?? "",
        locality: placemark.subLocality ?? "",
        postal_code: placemark.postalCode ?? "",
        country: placemark.country ?? "",
      );
    }else{
      locationData = LocationData(
        latitude: latitude,
        longitude:longitude,
        area: "",
        locality:  "",
        postal_code: "",
        country:  "",
      );
    }
   // todo Check internet connection status
     List<LocationData> locationDataList = [];
     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
     final DatabaseHelper _databaseHelper = DatabaseHelper();

     if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection available.');
       _databaseHelper.insertLocationData(locationData);
     }
     else{
       print('internet connection available.');
       locationDataList = await _databaseHelper.getAllLocationData();
       if (locationDataList != null && locationDataList.length > 0) {
         insertLocationCoordinates(locationDataList, 'OFFLINE');
       }
       else{

         insertLocationCoordinates([locationData], '');
       }
     }
  }

  static void insertLocationCoordinates(List<LocationData> location_list, String type)async {
    String deviceId = await getUniqueDeviceId();
    int battery_per = await getBatteryPercentage();
    final SessionManagement sessionManagement = SessionManagement();
    final DatabaseHelper _databaseHelper = DatabaseHelper();
    final RxString email = "".obs;
    String curretn_date = '';
    curretn_date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    email.value = await sessionManagement.getEmail() ?? '';
    var _api = BackGroundServiceRepository();
    List<Map<String, String>> jsonList = [];
    for (var item in location_list) {
      Map<String, String> aa = {
        "start_date": curretn_date,
        "from_latitude": item.latitude.toString(),
        "from_longitude": item.longitude.toString(),
        "from_locality": item.locality!.toString() ?? '',
        "from_area": item.area!.toString() ?? '',
        "from_postal_code": item.postal_code!.toString() ?? '',
        "from_country": item.country!.toString() ?? '',
        "created_by": email.value ?? '',
        "device_id": deviceId ?? '',
        "battery_per": battery_per.toString() ?? '',
      };
      jsonList.add(aa);
    }

    _api.userLocationInsertApiHit(jsonList, sessionManagement)
        .then((value) async {
      try {

        List<CommonResponse> common_response = (json.decode(value) as List)
            .map((i) => CommonResponse.fromJson(i))
            .toList();
        if (common_response[0].condition.toString() == "True") {
          //todo delete the location table
          if (type == 'OFFLINE') {
            await _databaseHelper.deleteAllLocationData();
            print("deleted data from table :" + location_list.toString());
          }
        } else {
          print('False Message!'+ common_response[0].message.toString());
        }
      } catch (e) {
        print('False Exception!'+ e.toString());
      }
    }).onError((error, stackTrace) {
      print('False Api Exception onError!'+  error.toString());
    });

  }

 static void showNotificationForCheckOut(ServiceInstance service)async {
    Timer.periodic(Duration(hours: 1), (Timer timer)async {
      String start_time = await sessionManagement.getStartTime() ?? '';
      String end_time = await sessionManagement.getEndTime() ?? '';
      var format = DateFormat("HH:mm");
      var start = format.parse(start_time);
      var end = format.parse(end_time);
      var checkin_session=await sessionManagement.getCheckIn()??'';
      if ((start.isAfter(end) && checkin_session=='CHECKIN')) {
         print('start is big');
        showNotification(service);
        print('difference = ${start.difference(end)}');
      }
    });

  }

 static void showNotification(ServiceInstance service){
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(
      999, // Use a unique ID for each notification
      'Check Out',
      'Please Mark CheckOut',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'my_foreground',
          'MY FOREGROUND SERVICE',
          icon: 'ic_bg_service_small',
        ),
      ),
    );

  }
  //todo for device get device unique id..........
 static Future<String> getUniqueDeviceId() async {
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
//todo for device get device battery percentage..........
  static Future<int> getBatteryPercentage() async {
    var battery = Battery();
    final int level = await battery.batteryLevel;
    print(level);
    return level; // Returning the battery level directly as an integer
  }
}
