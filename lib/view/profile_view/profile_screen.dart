
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';
import 'dart:io';
import 'package:image_network/image_network.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/dashboard_vm/dashboard_vm.dart';
import '../../viewModel/profile_vm/profile_vm.dart';
import '../custom_drawer.dart';

class ProfileScreen extends StatelessWidget{
  final profile_page_controller=Get.put(ProfileViewModel());
  final DashBoardViewModel dashboardVM = Get.put(DashBoardViewModel());
   ProfileScreen({super.key});
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Profile',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AllColors.primaryDark1,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),

                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 2.0,top: 40.0),

                    ),
                     /*GestureDetector(
                        child: Container(
                          width: 110,
                          height: 110,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(color: AllColors.lightgreyColor),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: GetImageSection(profile_page_controller.pickedImage.value,''),
                          //Image.asset('assets/images/pristine_pfulfil.png'),
                        ),
                       *//* onTap: (){
                          profile_page_controller.pickProfileImage(context: context);
                        },*//*
                      ),*/
                    Obx(() {
                     return

                        SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: AllColors.lightgreyColor,
                              child: setImage1(dashboardVM.pickedImagef.value,dashboardVM.imageUrl.value),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                color: Colors.grey,
                                                margin:EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 5),
                                                height: 5,
                                                width:40
                                            ),
                                            Text('Profile Photo',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.sisxteen,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.camera_alt,color: AllColors.primaryDark1,),
                                              title: Text('Camera'),
                                              onTap: () {
                                                dashboardVM.openImageSource(ImageSource.camera); // Open camera
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_library,color: AllColors.primaryDark1,),
                                              title: Text('Gallery'),
                                              onTap: () {
                                               dashboardVM.openImageSource(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  elevation: 2.0,
                                  fillColor: AllColors.customDarkerWhite,
                                  child: Icon(Icons.camera_alt, color: AllColors.primaryDark1,size: 20,),
                                  padding: EdgeInsets.all(10.0),
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      );
                   }),
                    SizedBox(height: size.height*0.01,),
                    Text(
                      dashboardVM.email.toString(),
                      style: TextStyle(color: AllColors.customDarkerWhite, fontWeight: FontWeight.w500, fontSize: AllFontSize.fourtine),
                    ),
                    SizedBox(height: size.height*0.07,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 10,
              right: 10,
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: AllColors.customDarkerWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AllColors.textColor, style: BorderStyle.solid),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Your content for the second container...
                      Column(
                        children: [
                          Text('Version',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text(dashboardVM.version_code!=null?dashboardVM.version_code!:''
                            ,style: GoogleFonts.poppins(
                                color: AllColors.lightblackColor,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AllColors.textColor,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text('V.Name',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text(dashboardVM.version_name!=null?dashboardVM.version_name!:'',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700
                          ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AllColors.textColor,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text('Service',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text('24*7',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 300,
                left: 10,
                right: 10,
                bottom: 10,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        listTileWidget(dashboardVM.name=="" ?"":dashboardVM.name.value[0].toUpperCase(),"Name",dashboardVM.name.value),
                        Obx(() {
                          print("phone..........${dashboardVM.phone.value}");
                            return Visibility(
                              visible:dashboardVM.phone.value==null  && dashboardVM.phone.value==""?false:true ,
                              child: Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: AllColors.textColor,),
                                    listTileWidget(dashboardVM.phone.value=="" ||dashboardVM.phone.value==null  ?"":dashboardVM.phone.value[0].toUpperCase(),"Mobile",dashboardVM.phone.value),
                                  ],
                                ),
                              ),
                            );
                          },
                        //  child:
                        ),

                        Obx(() {
                            return Visibility(
                              visible: dashboardVM.designation.value==null || dashboardVM.designation.value!="" || dashboardVM.designation.value.isEmpty?false:true,
                              child: Column(
                                children: [
                                  Divider(
                                    height: 2,
                                    color: AllColors.textColor,),
                                  listTileWidget(dashboardVM.designation.value==""? "":dashboardVM.designation.value[0].toUpperCase(),"Designation",dashboardVM.designation.value),
                                ],
                              ),
                            );
                          },
                         // child:
                        ),


                        Obx(
                          () {
                            return Visibility(
                              visible:dashboardVM.department.value==null || dashboardVM.department.value==""? false:true ,
                              child: Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: AllColors.textColor,),
                                    listTileWidget(dashboardVM.department.value==""?"":dashboardVM.department.value[0].toUpperCase(),"Department",dashboardVM.department.value),
                                  ],
                                ),
                              ),
                            );
                          },
                         // child:
                        ),
                      Obx(() {
                        return Visibility(
                          visible: dashboardVM.companey_id.value==null && dashboardVM.companey_id.value==""?false:true,
                          child: Container(
                              child: Column(
                                children: [
                                  Divider(
                                    height: 2,
                                    color: AllColors.textColor,),
                                  listTileWidget(dashboardVM.companey_id.value==""?"":dashboardVM.companey_id.value[0].toUpperCase(),"Company Id",dashboardVM.companey_id.value),

                                ],
                              )
                          ),
                        );
                      },
                        //child:
                      ),

                        Visibility(
                          visible:dashboardVM.userRole.value==null || dashboardVM.userRole.value=="" ?false:true,
                          child: Container(
                            child: Column(
                              children: [
                                Divider(
                                  height: 2,
                                  color: AllColors.textColor,),
                                listTileWidget(dashboardVM.userRole.value==null?"":dashboardVM.userRole.value[0].toUpperCase(),"Role Name",dashboardVM.userRole.value),
                              ],
                            )



                          ),
                        ),


                        Obx(
                          () {
                            return Visibility(
                              visible:dashboardVM.employee_id.value.isEmpty || dashboardVM.employee_id.value==null || dashboardVM.employee_id.value==""?false:true ,
                              child: Container(
                                  child:Column(
                                    children: [
                                      Divider(
                                        height: 2,
                                        color: AllColors.textColor,),
                                      listTileWidget(dashboardVM.employee_id.value==""?"":dashboardVM.emp_id.value[0].toUpperCase(),"Employee Id",dashboardVM.emp_id.value),
                                    ],
                                  )


                              ),
                            );
                          },
                         // child:
                        ),

                        Obx(
                          () {
                            return Visibility(
                              visible:dashboardVM.grade.value==null || dashboardVM.grade.value==""  || dashboardVM.grade.value.isEmpty?false:true,
                              child: Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: AllColors.textColor,),
                                    listTileWidget(dashboardVM.grade.value==""?"":dashboardVM.grade.value[0].toUpperCase(),"Grade",dashboardVM.grade.value),

                                  ],
                                ),
                              ),
                            );
                          },

                        ),

                        Obx(
                          () {
                            return Visibility(
                              visible: dashboardVM.shift.value.isEmpty || dashboardVM.shift.value==null || dashboardVM.shift.value==""?false:true,
                              child: Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: AllColors.textColor,),
                                    listTileWidget(dashboardVM.shift.value==""?"":dashboardVM.shift.value[0].toUpperCase(),"Shift",dashboardVM.shift.value),

                                  ],
                                ),
                              ),
                            );
                          },

                        ),

                        Obx(
                          () {
                            return  Visibility(
                              visible:dashboardVM.manager_id.value=="" || dashboardVM.manager_id.value.isEmpty || dashboardVM.manager_id.value==null ?false:true ,
                              child: Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: AllColors.textColor,),
                                    listTileWidget(dashboardVM.manager_id.value==""?"":dashboardVM.manager_id.value[0].toUpperCase(),"Manager Id",dashboardVM.manager_id.value),

                                  ],
                                ),
                              ),
                            );
                          },

                        ),
                        Divider(
                          height: 2,
                          color: AllColors.textColor,),

                        ListTile(
                          leading:CircleAvatar(
                            radius: 20,
                            backgroundColor: AllColors.whiteColor,
                            child: Image.asset("assests/images/pristine_pfulfil.png")

                          ),
                          title: InkWell(
                            onTap: () {
                              launchUrlString("https://www.pristinebs.com");
                            },
                            child: Text("Powered By Pristine FulFill",
                              style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                        )


                        /* listTileWidget(dashboardVM.state[0].toUpperCase(),"State",dashboardVM.state),
                      Divider(
                        height: 2,
                        color: AllColors.primaryliteColor,),
                      listTileWidget(dashboardVM.country[0].toUpperCase(),"Country",dashboardVM.country),*/
                      ],
                    ),
                  ),
                ))
          ],
        ),
        ),
      ),
    );
  }

  Widget setImage1( File? manual_select_file ,String image_url){
    print( 'url....'+image_url);
    if (manual_select_file != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: kIsWeb?Image.memory(dashboardVM.webImagef.value,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            // If there's an error loading the image, display a default image
            return Image.asset(
              "assets/images/no_file.png",
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            );
          },):
        Image.file(
          File(dashboardVM.picked_pic.value),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // If there's an error loading the image, display a default image
            return ImageNetwork(
              image: image_url,
              height: 100,
              width: 100,
              duration: 1500,
              curve: Curves.easeIn,
              onPointer: true,
              debugPrint: false,
              fullScreen: false,
              fitAndroidIos: BoxFit.cover,
              fitWeb: BoxFitWeb.cover,
              borderRadius: BorderRadius.circular(70),
              onLoading: const CircularProgressIndicator(
                color: AllColors.primaryDark1,
              ),
              onError: const Icon(
                Icons.error,
                color: AllColors.redColor,
              ),
              onTap: () {
                //debugPrint("©gabriel_patrick_souza");
              },
            );
          },// Use BoxFit.cover to make the image fit
        ),
      );
    }
    else if (image_url != null && image_url.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: !kIsWeb?Image.network(
            image_url.toString(),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assets/images/no_file.png",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          ):
          ImageNetwork(
            image: image_url,
            height: 100,
            width: 100,
            duration: 1500,
            curve: Curves.easeIn,
            onPointer: true,
            debugPrint: false,
            fullScreen: false,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.cover,
            borderRadius: BorderRadius.circular(70),
            onLoading: const CircularProgressIndicator(
              color: AllColors.primaryDark1,
            ),
            onError: const Icon(
              Icons.error,
              color: AllColors.redColor,
            ),
            onTap: () {
              //debugPrint("©gabriel_patrick_souza");
            },
          )
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset('assets/images/pristine_pfulfil.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,),
      );
    }

  }

  Widget listTileWidget(String letter,String title,String subtitle){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AllColors.textColor,
        child: Text(letter,style: GoogleFonts.poppins(
          color: AllColors.primaryDark1, // Text color
          fontWeight: FontWeight.w700,
        ),
        ),
      ),
      title: Text(title,
        style: GoogleFonts.poppins(
          color: AllColors.textColor,
          fontSize: AllFontSize.twelve,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(subtitle,
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AllColors.primaryDark1
        ),
        child: Icon(Icons.check_outlined,
          color: AllColors.customDarkerWhite,
          size: 12,),
      ),
    );

  }


  Widget GetImageSection(String? path, String? imageUrl) {
    if (path != null && path.isNotEmpty) {
      print(path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      print(imageUrl);
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else {
      return Image.asset('assets/images/pristine_pfulfil.png');
    }
  }


}