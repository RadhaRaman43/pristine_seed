import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../viewModel/home_vm/HomeViewModel.dart';
import '../../../viewModel/notification_vm/notification_vm.dart';
import '../../../viewModel/service_managment_vm_directory/corrective_vm/corrective_vm.dart';
import '../../../viewModel/service_managment_vm_directory/dashboard_vm/dashboard_vm.dart';
class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  Size size = Get.size;
  final home_vm = Get.put(HomeViewModel());
  final dashboard_page_controller = Get.put(DashBoardViewModel());
  final notification_page_controller = Get.put(NotificationViewModel());
  final corrective_page_controller=Get.put(CorrectiveViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: "Exit",
          titleStyle: const TextStyle(
              color: AllColors.primaryDark1, fontSize: 18, fontWeight: FontWeight.bold),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text("Do you want to Exit?",
              style: TextStyle(color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,fontSize: AllFontSize.fourtine),),
          ),
          confirm: OutlinedButton(
              onPressed: () =>  SystemChannels.platform.invokeMethod('SystemNavigator.pop'), child: const Text("Yes",
            style: TextStyle(color: AllColors.primaryDark1),)

          ),
          cancel: OutlinedButton(onPressed: () => Get.back(),
            child: const Text("No", style: TextStyle(color: Colors.red)),),
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          child: Container(
              height: double.infinity,
              color: AllColors.whiteColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RefreshIndicator(
                      onRefresh: refreshData,
                      child: Container(
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
                                     width: size.width*.63,
                                      child: Tooltip(
                                        message: home_vm.email ,
                                        child: Text(
                                          home_vm.email,
                                          style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.thirtine,
                                            color: AllColors.primaryDark1,
                                          ),
                                          //overflow: TextOverflow.ellipsis,
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
                            ],
                          )),
                    ),
                    Divider(
                      color: AllColors.lightgreyColor,
                    ),
                    Obx(() {
                        return Container(
                          margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          padding: EdgeInsets.fromLTRB(3, 0, 3,0),
                            height: size.height*.75,
                          child: ListView.builder(
                           // / scrollDirection: Axis.horizontal,
                           //  padding: EdgeInsets.fromLTRB(5, 0, 5, 100),
                           // padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final service = dashboard_page_controller
                                  .service_installation_list[index];
                              final imagePath = dashboard_page_controller
                                  .getImagePath(service.serviceType);
                              var title=dashboard_page_controller
                                  .service_installation_list[index].serviceType!;
                                       return   BindListView(index, imagePath,title);
                            },
                            itemCount: dashboard_page_controller
                                .service_installation_list.value.length,
                          ),
                        );
                      },
                    ),
                    //todo quick access Commented....
                    /*Obx(
                      () {
                        return Visibility(
                          visible: home_vm.recentlyOpenedMenus_list.length>0?true:false,
                          child: Container(

                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            padding:EdgeInsets.only( top: 10),

                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AllColors.lightgreyColor, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            height: size.height * .55,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Quick Access",
                                      style: GoogleFonts.poppins(
                                          fontSize: AllFontSize.twentee,
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    width: 300,
                                    child: Obx(() {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(top: 15.0, right: 1,left: 15),
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            // /padding: EdgeInsets.zero,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              // Adjust the number of columns as per your requirement
                                              crossAxisSpacing: 10.0,
                                               mainAxisSpacing: 10.0,
                                            ),
                                            itemCount: home_vm.recentlyOpenedMenus_list.length,
                                            itemBuilder: (context, index) {
                                              final reversedIndex =
                                                  home_vm.recentlyOpenedMenus_list.length -
                                                      1 -
                                                      index;
                                              final menuTitle = home_vm.recentlyOpenedMenus_list[reversedIndex];
                                              final icon = StaticMethod.getChildIconForIndex(menuTitle);
                                              return InkWell(
                                                onTap: () {
                                                  navigateToScreen(menuTitle);
                                                },
                                                child: Container(
                                                  width: 200,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    // /color: AllColors.bluegrayColor,
                                                      border: Border.all(
                                                          color: AllColors.lightgreyColor,
                                                          width: 1.0),
                                                      borderRadius:
                                                      BorderRadius.circular(30)),

                                                  margin: EdgeInsets.only(left: 5),
                                                  padding:
                                                  EdgeInsets.only(left: 5, right: 5),
                                                  //color: Colors.blue, // You can change the color or style as needed
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      Icon(
                                                        icon,
                                                        size: 70,
                                                        color: AllColors.primaryDark1,
                                                      ),
                                                      SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 20.0),
                                                        child: Container(
                                                          child: Tooltip(
                                                            message:home_vm.recentlyOpenedMenus_list[
                                                            reversedIndex]! ,
                                                            child: Text(home_vm.recentlyOpenedMenus_list[
                                                            reversedIndex]!,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize:
                                                                  AllFontSize.fourtine,
                                                                  color: AllColors
                                                                      .textColor),
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      //child:
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                     // child:
                    ),*/
                  ],
                ),
              )),
        ),
      ),
    );
  }

  BindListView(int index, String imagePath, String title) {
    return Container(
       /// width: size.width * 0.2,
      child: InkWell(
        onTap: () {
          switch(title){
            case "Corrective":
              Get.toNamed(RoutesName.corrective_screen);
              IconData iconData = StaticMethod.getChildIconForIndex(title);
              home_vm.openMenu(title, iconData);
              break;
            case "Installation" :
              IconData iconData = StaticMethod.getChildIconForIndex(title);
              home_vm.openMenu(title, iconData);
              Get.toNamed(RoutesName.installation_screen);
              break;
            case "Preventive":
              IconData iconData = StaticMethod.getChildIconForIndex(title);
              home_vm.openMenu(title, iconData);
              Get.toNamed(RoutesName.preventive_screen,preventDuplicates: false);
              break;

            case "Reopen":
            IconData iconData = StaticMethod.getChildIconForIndex(title);
              home_vm.openMenu(title, iconData);
              Get.toNamed(RoutesName.corrective_screen);
              corrective_page_controller.is_done.value=-1;
              corrective_page_controller.getServiceCorrectiveList(corrective_page_controller.is_done.value, corrective_page_controller.pageNumber,corrective_page_controller.date_filter.value);
              break;



          }
        },
        child: ListTile(
           // /contentPadding: EdgeInsets.fromLTRB(2, 0, 5, 0),
            title: Container(
              height: 200,
              padding: EdgeInsets.only(left: 15,right: 15,top: 2),
              // /margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AllColors.whiteColor,
                 borderRadius: BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:Colors.black12,
                     // spreadRadius: 1,
                      offset: Offset(1.7, 1.7)
                    )
                  ]
              ),
               // height: 150,
             //   margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                            dashboard_page_controller
                                .service_installation_list[index]
                                .serviceType!,
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w500,
                                color: AllColors.textColor)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .03,
                      //height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            imagePath,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        SizedBox(
                          width: size.width * .3,
                          //height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(
                              dashboard_page_controller
                                  .service_installation_list[index].serviceCount
                                  .toString()!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: dashboard_page_controller
                                      .getColorForIndex(index)

                              )),
                        ),
                      ],
                    )
                  ],
                ))
            ),
      ),
    );
  }
  void navigateToScreen(String? menuTitle) {
    switch (menuTitle) {
      case 'Installation Request':
        Get.toNamed(RoutesName.installation_screen, preventDuplicates: false);
        break;
      case 'Corrective Request':
        Get.toNamed(RoutesName.corrective_screen, preventDuplicates: false);
        break;
      case 'Preventive Request':
        Get.toNamed(RoutesName.preventive_screen, preventDuplicates: false);
        break;
      default:
        print('Unknown menu title: $menuTitle');
    }
  }
  Future<void> refreshData() async {
    print("bmglmbgb");
    notification_page_controller.getNotificationList("get", "");
  }




}
