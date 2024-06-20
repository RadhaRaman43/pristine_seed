import 'dart:convert';

import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/repository/notification_repository/notification_repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/notification_model/notification_model.dart';
import '../../utils/app_utils.dart';

class NotificationViewModel extends GetxController{
  final _api=NotificationRepository();
  SessionManagement sessionManagement= SessionManagement();
  RxBool loading =false.obs;
  var selectedIndex = RxInt(0);
  RxInt acknowledgement_id=0.obs;
  RxString flag="".obs;
  RxInt totalUnacknowledgedCount = 0.obs;
  var show_notification = true.obs;
  String email="";
  RxList<NotificationListResponse> notification_list=<NotificationListResponse>[].obs;
  @override
  void onInit() async {
    email=await sessionManagement.getEmail() ?? "";
    getNotificationList("get","");
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  getNotificationList(String flag,String id) {
    Map data = {
      "flag": flag,
      "id":id,
      "email_id": email
    };
    print(data);
    loading.value = true;
    try {
      _api.notificationListApiHit(data, sessionManagement).then(
            (value) {
          print(value);
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<NotificationListResponse> response =
            JsonResponse.map((e) => NotificationListResponse.fromJson(e)).toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition == "True") {
              loading.value = false;
              notification_list.value=response;
              totalUnacknowledgedCount.value=notification_list.where((item) => item.acknowledgement==0).length;
            } else {
              loading.value = false;
              notification_list.value=[];
            }
          } else {
            loading.value = false;

            Utils.showExceptionToastification("Api Error!", JsonResponse);
          }
        },
      ).onError(
            (error, stackTrace) {
          print(error);
        },
      );
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }













}