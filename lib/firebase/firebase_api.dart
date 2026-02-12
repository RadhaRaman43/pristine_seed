import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../main.dart';
class FirebaseApi {
  final messaging=FirebaseMessaging.instance;

  Future<String> initNotification() async {
    await  messaging.requestPermission();
    String? token=await messaging.getToken();
    if(kDebugMode){
      print('Token : ${token}');
    }



    initPushNotification();
    return token??'';
  }


  void handleMessage(RemoteMessage? remoteMessage){
    if(remoteMessage==null)return;
    navigatorKey.currentState?.pushNamed(
        '/notification_screen',
        arguments: remoteMessage
    );
  }





  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  }

  void deleteToken(){
    FirebaseMessaging.instance.deleteToken();
  }




}
