import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/notification_vm/notification_vm.dart';
import '../custom_drawer.dart';

class NotificationScreen extends StatelessWidget{
  NotificationScreen({super.key});

  final notification_page_controller=Get.put(NotificationViewModel());

  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Notification List',
          style: GoogleFonts.poppins(
            color: AllColors.whiteColor,
            fontSize: AllFontSize.twentee,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: AllColors.whiteColor, // Change this to the desired color
        ),
        backgroundColor: AllColors.primaryDark1,
      ),
      drawer: CustomDrawer(),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () {
                  return  Container(
                    margin: EdgeInsets.only(top: 0.2),
                    child: Visibility(
                      visible:notification_page_controller.loading.value ,
                      child: LinearProgressIndicator(
                        color: AllColors.textColor,
                        backgroundColor: AllColors.primaryDark1,
                      ),
                    ),
                  );
                },
                // child:
              ),
          
              Container(
                // padding: EdgeInsets.all(5),
                 // margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    //color: AllColors.grayColor1,
                      borderRadius: BorderRadius.circular(5)),
                  child: Obx(() {
                    return BindListView(context);
                  })),
          
            ],
          ),
        ),
      ),

    );
  }



  Widget BindListView(context) {
    if (notification_page_controller
        .notification_list.isNotEmpty &&
        notification_page_controller
            .notification_list.length >
            0) {
      return Expanded(
        child: ListView.separated(
          physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            shrinkWrap: true,
            itemCount: notification_page_controller
                .notification_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindNotificationListView(context, index);
            }),
      );
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }


  BindNotificationListView(BuildContext context, int index) {
    return Obx(() =>
        ListTile(
          onTap: () {
            notification_page_controller.setSelectedIndex(index);
            if (notification_page_controller.notification_list[index]
                .acknowledgement == 0) {
              notification_page_controller.acknowledgement_id.value =
              notification_page_controller.notification_list[index].id!;
              notification_page_controller.getNotificationList("acknowledgement",
                  notification_page_controller.acknowledgement_id.value
                      .toString());
            } else {
              if (notification_page_controller
                  .notification_list[index]
                  .acknowledgement! > 0)
                notification_page_controller.flag.value = '';
            }
          },
          tileColor: notification_page_controller
              .notification_list[index]
              .acknowledgement == 0
              ? AllColors.skyBlue // Change the color as needed
              : AllColors.whiteColor,
          title: Row(
            children: [
              Text("NO: ", style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen,
              )
              ),
              Container(
                width: size.width * .5,
                child: Text(
                    notification_page_controller
                        .notification_list[index]
                        .documentNo ?? '',
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w700,
                      fontSize: AllFontSize.sisxteen,
                    )),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  child: Text(
                      "${notification_page_controller
                          .notification_list[index]
                          .message ?? ''}",
                      //overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w600,
                        fontSize: AllFontSize.fourtine,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${notification_page_controller
                          .notification_list[index]
                          .documentType ?? ''}",
                      overflow: TextOverflow.ellipsis,
                      // Ensure text does not overflow
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      ),
                    ),
                    Container(
                      width: size.width*.3,
                      child: Tooltip(
                        message: "${notification_page_controller
                            .notification_list[index].createdOn ?? ''}",
                        child: Text("${notification_page_controller
                            .notification_list[index].createdOn ?? ''}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w400,
                              fontSize: AllFontSize.twelve,
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          leading: Container(
            height: 70,
            width: 56,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                color: AllColors.primaryDark1
                ,
                border: Border.all(color: AllColors.primaryDark1, width: 1)),
            child: bindImage(index),
          ),
        ),
    );
  }


  bindImage(int index) {
    int serialNumber = index+1;
    if (notification_page_controller
        .notification_list[index].documentNo!=
        null && notification_page_controller
        .notification_list[index].documentNo != "") {
      return Stack(
        children: [
          Center(
            child: Container(
              width: 90,
              height: 90,
              child: CircleAvatar(
                backgroundColor: AllColors.grayColor1,
                child: Text(serialNumber.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight:FontWeight.w500,
                        fontSize: AllFontSize.twentee,
                        color: AllColors.primaryDark1)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 25,
            top: 38,
            child: Obx(() {
              return  Visibility(visible: notification_page_controller
                  .notification_list[index].acknowledgement!>0?
              false:true,
                child: Icon(Icons.notifications
                  ,color: AllColors.primaryDark1,),
              );
            },
            ),
          )
        ],
      );
    }
    else{
      return CircleAvatar(
        backgroundColor:  AllColors.primaryDark1,
        child: Text("No",style: GoogleFonts.poppins(
            fontWeight:FontWeight.w500,
            fontSize: AllFontSize.twentee,
            color: AllColors.primaryDark1) ),
      );
    }
  }




}