import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../main.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../viewModel/services/splash_services.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  SplashServices splashServices = SplashServices();



  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  // Added to track whether images are loading
  late ImageProvider backgroundImage, logoImage;

  @override
  void didChangeDependencies() async {
   backgroundImage = AssetImage("assests/images/splash.png");
    logoImage = AssetImage("assests/images/pristine_pfulfill.png");
    logoImage = AssetImage("assests/images/pristine_pfulfill.png");
    await precacheImage(backgroundImage, context);
    await precacheImage(logoImage, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _enableRotation();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      print("Success");

      bool locationPermissionGranted = await checkLocationPermission();
      bool notificationPermissionGranted = await checkNotificationPermission();
      bool cameraPermissionGranted = await checkCameraPermission();
      if (!locationPermissionGranted || !notificationPermissionGranted ||
          !cameraPermissionGranted) {
        print("Success2222222");
        showDisclosureDialog(context);
        // showDisclosureDialog(context);
      }else{

        print("Success444444444");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20, // Adjust this as needed
              ),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(image: logoImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text(
                  "Welcome To Our Company!",
                  style: TextStyle(
                    fontSize:20,
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Powered By: Pristine Business Solutions",
                  style: TextStyle(
                    fontSize: 12,
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.loginScreen);
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize:20),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AllColors.whiteColor,
                    side: BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(121, 22, 100, 33),
                    ),
                    backgroundColor: Color.fromARGB(121, 22, 60, 33),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void showDisclosureDialog(BuildContext context) async {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button pop
          child: AlertDialog(
            title: Text(
              "Background Location Access Required",
              style: TextStyle(color: AllColors.primaryDark1),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Our app requires access to your location in the background to if we create check-in and check-out, then we need the Geolocation for Coordinate on user route menu. We Collect Your Device's precise location when the app is running in the foreground  and when the app is running in the background from the time you request a ride until it ends. Users may use the app without enabling it to collect precise location data..",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w400,
                      ),
                      /*textAlign: TextAlign.start*/),
                    // leading: Icon(Icons.circle,size: 10, color: AllColors.primaryDark1,),
                  ),

                  /* ListTile(
                  title:  Text(
                    'Location Information: These permissions are typically requested to provide location-based services within the app, such as displaying nearby points of interest, providing location-based recommendations, or navigation services. If You download and/or use the Platform through your mobile, tablet, and/or any other computer sources or electronic devices, we may receive information about Your location and your IP address, including a unique identifier number for Your device. The information You provide may be used to provide You with location-based Services including but not limited to search results and other personalized content',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,),


                  *//*Text(
                    'When the user checks in on CheckIn page then user needs to location after paused the application.',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,),*//*


                  leading: Icon(Icons.circle,size: 10, color: AllColors.primaryDark1,),
                ),
                ListTile(
                  title: Text(
                    'When the user checks out then user can check route on User Route Page.',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,),
                  leading: Icon(Icons.circle,size: 10, color: AllColors.primaryDark1,),
                ),*/
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Utils.sanckBarError("Location Services: ", "All permissions are required for this app to function properly. Please enable all permissions.");
                  //  Navigator.of(context).pop();
                },
                child: Text(
                  "Decline",
                  style: TextStyle(color: AllColors.redColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  requestPermission();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Allow",
                  style: TextStyle(color: AllColors.primaryDark1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> checkLocationPermission() async {
    var permissionLocation = Permission.location;
    return await permissionLocation.isGranted;
  }



  Future<bool> checkNotificationPermission() async {
    var permissionLocation = Permission.notification;
    return await permissionLocation.isGranted;
  }


  Future<bool> checkCameraPermission() async {
    var permissionLocation = Permission.camera;
    return await permissionLocation.isGranted;
  }

  Future<void> requestPermission() async {
    var permission_location = Permission.location;

    if (await permission_location.isDenied) {
      await permission_location.request();
    }

    var permission_notification = Permission.notification;

    if (await permission_notification.isDenied) {
      await permission_notification.request();
    }

    var permission_camera = Permission.camera;

    if (await permission_camera.isDenied) {
      await permission_camera.request();
    }

    _isAndroidPermissionNotificationGranted();
    _requestPermissions_forNotification();
  }
  Future<bool> _isAndroidPermissionNotificationGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      return granted;
    }
    return false;
  }
  Future<void> _requestPermissions_forNotification() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      // final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();
      // setState(() {
      //   _notificationsEnabled = grantedNotificationPermission ?? false;
      // });
    }
  }

}




