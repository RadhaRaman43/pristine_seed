
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
void main() async{

  // todo for Trust all certificates for network requests (for testing only).
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);//todo lock landscape mode
  HttpOverrides.global = MyHttpOverrides();
  await _initLocalNotifications();
  runApp(const MyApp());

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

Future<void> _initLocalNotifications() async {
  // ANDROID
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  // iOS / macOS (REQUIRED)
  const DarwinInitializationSettings iosSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // COMBINED SETTINGS
  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,     // ✅ REQUIRED
    macOS: iosSettings,  // ✅ RECOMMENDED
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

  // ANDROID notification channel (Android 8+ only)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'basic_channel',
    'Basic notifications',
    description: 'Notification channel for basic tests',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}


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

