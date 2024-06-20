import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navigation_drawer_flutter/repository/forget_password_repository/forget_password-repository.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../../models/forgetPassModel/forget_password_response.dart';
import '../../reources/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class ForgetPasswordViewModel extends GetxController{

  final api=ForgetPasswordRepository();
  SessionManagement sessionManagement= SessionManagement();
  final forget_emailController=TextEditingController();


  RxBool loading=false.obs;

  forgotPasswordApi(){
    loading.value=true;
    Map data={
      'email_id':forget_emailController.value.text,
    };
    api.forgotPassApiHit(data,sessionManagement).then((value){
      try{
        loading.value=false;
        List<ForgotPassResponse> passResponse=(json.decode(value) as List).map((i) =>
            ForgotPassResponse.fromJson(i)).toList();
        if (passResponse[0].condition.toString() == "True") {
          Utils.sanckBarSuccess('OTP', passResponse[0].message.toString());
         // Get.toNamed(RoutesName.createPasswordScreen,arguments:passResponse[0].mailSendOnEmail.toString());
        }
        else {
          Utils.sanckBarError('Message', passResponse[0].message.toString());
        }
      }catch(e){
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      //print(stackTrace);
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }





}