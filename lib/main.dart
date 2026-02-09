//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/constants/theme.dart';
import 'package:navigation_drawer_flutter/reources/routes/app_routes.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final navigatorKey=GlobalKey<NavigatorState>();
void main() async{
  /*AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        playSound: true,
        importance: NotificationImportance.High,

      )
    ],
    //debug: true
  );

  AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedNotification) async {
        print("Received Notification Action: ${receivedNotification.buttonKeyPressed}");
        if (receivedNotification.buttonKeyPressed == 'OPEN_FILE') {
          final filePath = receivedNotification.payload?['filePath'];
          if (filePath != null) {
            await OpenFile.open(filePath);
          }
        }
        return;
      }
  );*/
  // todo for Trust all certificates for network requests (for testing only).
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);//todo lock landscape mode
  HttpOverrides.global = MyHttpOverrides();
  await _initLocalNotifications();
  runApp(const MyApp());

}

Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  const DarwinInitializationSettings iosSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
    macOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (response) async {
      final payload = response.payload;
      if (payload != null) {
        await OpenFile.open(payload);
      }
    },
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'download_channel',
    'File Downloads',
    description: 'Notifications for downloaded files',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}


/*Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  final InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final String? payload = response.payload;
      if (payload != null && payload.contains('filePath=')) {
        final filePath = Uri.splitQueryString(payload)['filePath'];
        if (filePath != null) {
          await OpenFile.open(filePath);
        }
      }
    },
  );

  // Create notification channel (required for Android 8.0+)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'basic_channel',
    'Basic notifications',
    description: 'Notification channel for basic tests',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}*/

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget{
  static String app_CurrentStatus="Running";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)   {
      /// requestPermission();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pristine Seeds',
      theme: theme(),
      //home: ShowRoutesScreen(),
      getPages: AppRoutes.appRoutes(),
    );

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
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}*/

/*
class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    bool _isPasswordVisible = false;
    final loginVM = Get.put(LoginViewModel());

    final _formKey = GlobalKey<FormState>();

    final List<String?> errors = [];
    Size size = Get.size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  height: size.height * 0.4,
                  child: Image.asset(
                    "assests/images/login_backgound.png",
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  //top: 40,
                  top: size.height * .05,
                  left: 15.0,
                  child: Visibility(
                    visible: false,
                    child: CircleBackButton(
                      press: () {
                        Get.back();
                      },
                    ),
                  )),
              Positioned(
                //top: 300,
                top: size.height * 0.42,
                child: Column(
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: 'Ageo Persona'),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text("Login to your account",
                        style: GoogleFonts.roboto(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.normal)),
                  ],
                ),
              ),
              Positioned(
                top: size.height * .43,
                right: 0,
                child: Image.asset(
                  "assests/images/leaves_img.png",
                  // Replace with your image path
                  width: 60.0, // Adjust width as needed
                  height: 70.0,
                  // Adjust height as needed
                ),
              ),
              Positioned(
                //top: 370, // Adjust the vertical position as needed
                top: size.height * 0.53,
                // Adjust the vertical position as needed
                left: 20,
                right: 20,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: loginVM.emailController.value,
                        focusNode: loginVM.emailFocusNode.value,
                        cursorColor: AllColors.primaryDark1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can't be blank";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // Clear the error when the user enters a value
                          if (value.isNotEmpty) {
                            _formKey.currentState?.validate();
                          }
                        },
                        onFieldSubmitted: (value) {
                          // Utils.fieldFocusChange(context, loginVM.emailFocusNode.value, loginVM.passFocusNode.value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AllFontSize.ten,
                              horizontal: AllFontSize.ten),
                          hintText: "Enter your email",
                          labelText: 'Email',
                          hintStyle: TextStyle(color: AllColors.primaryDark1),
                          labelStyle: TextStyle(color: AllColors.primaryDark1),
                          suffix: Icon(
                            Icons.person,
                            color: AllColors.primaryDark1,
                            size: AllFontSize.eighteen,
                          ),
                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                          // Add a clear icon if needed
                          filled: true,
                          fillColor: Colors.grey[50],
                          // Light gray background
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between text fields
                      TextFormField(
                        controller: loginVM.passController.value,
                        obscureText: !_isPasswordVisible,
                        cursorColor: AllColors.primaryDark1,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be blank";
                          }
                          return null;
                        },

                        onChanged: (value) {
                          // Clear the error when the user enters a value
                          if (value.isNotEmpty) {
                            _formKey.currentState?.validate();
                          }
                        },

                        onFieldSubmitted: (value) {
                          //Utils.fieldFocusChange(context, loginVM.passFocusNode.value, loginVM.emailFocusNode.value);
                        },
                        // Password field
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AllFontSize.ten,
                              horizontal: AllFontSize.ten),
                          hintText: "Enter your password",
                          labelText: 'Password',
                          hintStyle: TextStyle(color: AllColors.primaryDark1),
                          labelStyle: TextStyle(color: AllColors.primaryDark1),
                          suffix: Icon(
                            Icons.lock,
                            color: AllColors.primaryDark1,
                            size: AllFontSize.eighteen,
                          ),
                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                          */

/* suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AllColors.primaryDark1,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),*/
/*
                          // Add an eye icon for password visibility
                          filled: true,
                          fillColor: Colors.grey[50],
                          // Light gray background
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      GestureDetector(
                        onTap: () => {
                          //  Get.toNamed(RoutesName.forgotPasswordScreen)
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 6.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Ageo Persona'
                                // Change text color as needed
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Obx(() {
                        return DefaultButton(
                          text: "Login",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              loginVM.loading.value = true;
                              loginVM.loginApi();
                            }
                          },
                          loading: loginVM.loading.value,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    */
/*  Get.to(RegisterScreen(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(seconds: 1));*/
/*
                  },
                  child: Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Ageo Persona',
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                //fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

