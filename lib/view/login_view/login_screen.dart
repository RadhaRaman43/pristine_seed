import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../component/back_button.dart';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../utils/app_utils.dart';
import '../../viewModel/login_vm/LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final loginVM = Get.put(LoginViewModel());
  final Uri _url = Uri.parse('https://www.pristinebs.com/');
  final _formKey = GlobalKey<FormState>();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //_passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size=MediaQuery.of(context).size;
    Size size = Get.size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                   // padding:  EdgeInsets.only(top: 40),
                    // margin: EdgeInsets.only(left: 25, top: 30),
                    height: 100,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Image.asset(
                          "assests/images/pristine_pfulfill.png",
                          height: 60,
                          width: 60,
                        )),
                  ),
                  Container(
                   // padding:  EdgeInsets.only(top: 50),
                      //margin: EdgeInsets.only(left: 40),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In ",
                        style: GoogleFonts.poppins(
                            fontSize: AllFontSize.thhirty,
                            fontWeight: FontWeight.w600,
                            color: AllColors.primaryDark1),
                      ),
                     /* SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w600,
                                color: AllColors.primaryDark1),
                          ),
                          Text(
                            "  Sign up",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent),
                          )
                        ],
                      ),*/
                    ],
                  )),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * 0.05),
                      //padding: EdgeInsets.only(left: 40),
                      //height: size.height*.4,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address *",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.thirtine,
                                fontWeight: FontWeight.w600,
                                color: AllColors.primaryDark1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: TextFormField(
                              focusNode: loginVM.emailFocusNode.value,
                              controller: loginVM.emailController.value,
                              validator: (value){
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
                              onFieldSubmitted: (value){
                                Utils.fieldFocusChange(context, loginVM.emailFocusNode.value, loginVM.passFocusNode.value);
                              },
                              decoration: InputDecoration(
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: AllColors.primaryDark1)
                               ),
                                  contentPadding: EdgeInsets.symmetric(vertical:AllFontSize.ten,horizontal: AllFontSize.ten),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)))),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Text(
                            "Password *",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.thirtine,
                                fontWeight: FontWeight.w600,
                                color: AllColors.primaryDark1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: TextFormField(
                              obscureText: !_isPasswordVisible,
                              validator: (value){
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
                              onFieldSubmitted: (value){
                                Utils.fieldFocusChange(context, loginVM.passFocusNode.value, loginVM.emailFocusNode.value);
                              },
                              controller:loginVM.passController.value ,
                              decoration: InputDecoration(
                                  focusColor:Colors.amber,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AllColors.primaryDark1)
                                  ),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                     // color:  AllColors.splash_background,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                 // filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical:AllFontSize.ten,horizontal: AllFontSize.ten),
                                  border: OutlineInputBorder(

                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)))),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesName.forgetScreen);

                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                "Forget Password",
                                style: GoogleFonts.poppins(
                                    fontSize: AllFontSize.thirtine,
                                    fontWeight: FontWeight.w600,
                                    color: AllColors.primaryDark1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Obx(() {
                            return DefaultButton(
                              text: "Login",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  //  loginVM.loading.value = true;
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
                  SizedBox(height: size.height*.054,),
                  Center(child: Image.asset("assests/images/pristine_pfulfil.png",width: 40,height: 40,)),
                  SizedBox(height: size.height*.01,),
                  InkWell(
                    onTap: () {
                      launchUrlString("https://www.pristinebs.com");
                    },
                    child: Center(
                      child: Text("Powered By Pristine FulFill",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),

                      textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                 /* ListTile(
                    leading:CircleAvatar(
                        radius: 20,
                        backgroundColor: AllColors.whiteColor,
                        child:

                    ),
                    title: Text("Powered By Pristine FulFill",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),),
                  )*/
                ],
              ),
            ),
          ),
        ));
  }


}
