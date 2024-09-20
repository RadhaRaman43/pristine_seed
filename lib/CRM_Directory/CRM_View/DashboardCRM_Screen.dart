import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/home_vm/HomeViewModel.dart';
import '../CRM_VIewModels/DashboardCRM_vm/Dashboard_CRM_VM.dart';

class DashboardcrmScreen extends StatelessWidget{
  DashboardcrmScreen({super.key});

  Size size = Get.size;
  final home_vm = Get.put(HomeViewModel());
  final dashboard_page_controller = Get.put(DashboardCrmVm());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async  {
          return await
          ConfirmationDialog(context) ?? false;
    }, child: Scaffold(
        body: Container(
          child: Container(
            height: double.infinity,
            color: AllColors.whiteColor,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //margin: EdgeInsets.all(2),
                        width: double.infinity,
                        // /  height: 500,
                        color: AllColors.whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "Welcome Back(${home_vm.name})",
                                style: GoogleFonts.poppins(
                                  fontSize: AllFontSize.sisxteen,
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    width: size.width*.6,
                                    child: Tooltip(
                                      message: home_vm.email ,
                                      child: Text(
                                        home_vm.email,
                                        style: GoogleFonts.poppins(
                                          fontSize: AllFontSize.thirtine,
                                          color: AllColors.primaryDark1,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              leading: Container(
                                //margin: EdgeInset
                                // s.only(top: 20),
                                child: CircleAvatar(
                                  backgroundColor: AllColors.whiteColor,
                                  child: Image.asset(
                                    "assests/images/pristine_pfulfill.png",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            /* Container(
                                color: AllColors.whiteColor,
                                margin: EdgeInsets.fromLTRB(15, 8, 15, 20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width * .4,
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.message,
                                              color: AllColors.whiteColor,
                                            ),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Text(
                                              "Message",
                                              style: GoogleFonts.poppins(
                                                  fontSize: AllFontSize.fourtine,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            AllColors.primaryDark1),
                                      ),
                                    ),
                                    Container(
                                      //color: AllColors.primaryDark1,
                                      width: size.width * .4,
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.settings,
                                              color: AllColors.whiteColor,
                                            ),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Text(
                                              "Settings",
                                              style: GoogleFonts.poppins(
                                                  fontSize: AllFontSize.sisxteen,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AllColors.textColor),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              )*/
                          ],
                        )),
                    Divider(
                      color: AllColors.lightgreyColor,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text('CRM DASHBOARD',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.sisxteen,
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.bold,
                          ),),
                    )

                  ],
                ),
              ),
            ),

          ),
        ),
      )
    );
  }

  ConfirmationDialog(context){
    print('Diaload chala');
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Exit !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
              children: [
               Column(
                children: [
                  Text(
                      'Do you want to Exit ?',
                      style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1,
                      )),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.lightredColor,
                          ),
                        ),
                        onPressed: ()  {
                          Get.back();

                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('No',
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.greenblue,
                          ),
                        ),
                        onPressed: ()  {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Yes',
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),]
            ),
          );

        });
  }
}