import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/loginModel/login_model.dart';
import '../../reources/routes/routes_name.dart';
import '../../repository/login_repository/login_repository.dart';
import '../../utils/app_utils.dart';
import '../SessionManagment/session_managment.dart';

class LoginViewModel extends GetxController{
  final _api=LoginRepository();
  final emailController =TextEditingController().obs;
  final passController =TextEditingController().obs;
  final emailFocusNode=FocusNode().obs;
  final passFocusNode=FocusNode().obs;

  RxBool loading=false.obs;
  SessionManagement sessionManagement=SessionManagement();

  Future<void> loginApi() async{
    loading.value=true;
    Map data={
      'email':emailController.value.text,
      'password':passController.value.text,
    };
    await _api.loginApiHit(data,sessionManagement).then((value){
      try{

        List<LoginResponse> loginResponse=(json.decode(value) as List).map((i) =>
            LoginResponse.fromJson(i)).toList();

        if(loginResponse!=null &&  loginResponse[0].condition=="True"){
          loading.value=false;

         /* if(loginResponse[0].isHo=='1'){
            sessionManagement.clearSession();
           Get.offAllNamed(RoutesName.loginScreen);
            Utils.sanckBarError('Message !', "Cluster User Can Not Access Mobile Application.");
            return;
          }
*/
         // Utils.sanckBarSuccess("Success", loginResponse[0].message!);
          sessionManagement.setUserCode(loginResponse[0].userType.toString());
          sessionManagement.setCompanyId(loginResponse[0].companyId.toString());
          sessionManagement.setEmail(loginResponse[0].email.toString());
          sessionManagement.setUserType(loginResponse[0].userType.toString());
          sessionManagement.setAuthToken(loginResponse[0].jwtToken.toString());
          sessionManagement.setRequestHostName(loginResponse[0].requestHostName.toString());
          sessionManagement.setName(loginResponse[0].name.toString());
          sessionManagement.setPhoneNo(loginResponse[0].phoneNo.toString());
          sessionManagement.setIsHo(loginResponse[0].isHo.toString());
          sessionManagement.setRoleName(loginResponse[0].roleName.toString());
          sessionManagement.setProfile(loginResponse[0].profile.toString());
          sessionManagement.setIsCrm(loginResponse[0].isCrm.toString());
          sessionManagement.setMenuList(loginResponse[0].menu ?? []);
         // Get.toNamed(RoutesName.homeScreen);
          Get.offAllNamed(RoutesName.homeScreen);

        }
        else{
          passController.value.text="";
          emailController.value.text="";
          Utils.showErrorToastification("False!", loginResponse[0].message!);
         // print(loginResponse.message);
          print("elseeee");
        }
      }catch(e){
        Utils.showErrorToastification("Exception!",e.toString());
        print(e);
      }finally{
        loading.value=false;
      }

    }).onError((error, stackTrace) {
      print(error);
      Utils.showErrorToastification("Api Error!",error.toString());
      loading.value=false;
    },);


  }
}



