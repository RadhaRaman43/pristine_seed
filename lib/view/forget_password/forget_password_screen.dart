import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/forget_password_vm/forget-password_vm.dart';

import '../../component/back_button.dart';
import '../../component/default_button.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/login_vm/LoginViewModel.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final forget_password_controller= Get.put(ForgetPasswordViewModel());
  Size size = Get.size;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.loginScreen);
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3,
                    offset: Offset(0.0, 0.055),
                  )
                ], color: Colors.white),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: size.height * 0.09,
                        child: CircleBackButton(press: () {
                          Get.offAllNamed(RoutesName.loginScreen);
                        }),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: size.width * .2),
                      child: Text(
                        "Forget Password",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.twentee,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 130,
                width: 130,
                margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AllColors.primaryDark1.withOpacity(0.1),
                        offset: Offset(0.0, 5),
                        blurRadius: 10,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 10)
                  ],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Image.asset(
                  "assests/images/pristine_pfulfill.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Text("Enter Your Email Address",style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.twentee,
                ),),
              ),
              SizedBox(height: size.height*.03,),
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(

                ),
                child: TextFormField(
                  controller: forget_password_controller.forget_emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    suffixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,horizontal: AllFontSize.ten ),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                    ),

                  ),
                ),

              Obx(
                () {
                  return Container(
                    margin: EdgeInsets.fromLTRB(30, 25, 30, 0),
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                    height: 50,
                    child: DefaultButton(
                      press: (){
                        forget_password_controller.forgotPasswordApi();
                      },
                      text: "Continue",
                        loading: forget_password_controller.loading.value,

                    ),
                  );
                },

              )


            ],

          ),
        ),
      ),
    );
  }
}
