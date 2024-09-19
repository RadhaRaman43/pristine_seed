import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../viewModel/installation_vm/installation_vm.dart';
import '../custom_drawer.dart';

class MarkVisit extends StatelessWidget {
  MarkVisit({super.key});

  final installation_indent_page_controller = Get.put(InstallationViewModel());

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    var serViceTatDate = StaticMethod.onlyDate(installation_indent_page_controller
        .service_installation_details_list[0].serviceTatDatetime!);

    return WillPopScope(
      onWillPop: () async {
        installation_indent_page_controller.getServiceInstallationDetails(installation_indent_page_controller.id,"Refresh");
        Get.toNamed(RoutesName.installation_details_screen);

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'View Installation',
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
        body: RefreshIndicator(
          onRefresh: installation_indent_page_controller.refreshIndentListData,
          child: ListView(
            children: [
              Container(
                height: size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        return Container(
                          margin: EdgeInsets.only(top: 0.3),
                          child: Visibility(
                            visible: installation_indent_page_controller
                                .loading.value,
                            child: LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                     // / height: size.height * .22,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                            color: Colors.black54),
                      ], color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Service No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .serviceNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),

                          Row(
                            children: [
                              Text(
                                "Customer",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: size.width*.55,
                                child: Tooltip(
                                  message: installation_indent_page_controller
                                      .service_installation_details_list[0]
                                      .customerName!,
                                  child: Text(
                                    installation_indent_page_controller
                                        .service_installation_details_list[0]
                                        .customerName!,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              Text(
                                "Contact No.",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerPhoneNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),

                          Row(
                            children: [
                              Text(
                                "Customer Address",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: size.width*.55,
                                child: Tooltip(
                                  message: installation_indent_page_controller
                                      .service_installation_details_list[0]
                                      .customerAddress! ,
                                  child: Text(
                                    installation_indent_page_controller
                                        .service_installation_details_list[0]
                                        .customerAddress!,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer PinCode",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerPincode!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),

                          Obx(
                                () {
                              return Visibility(
                                visible:installation_indent_page_controller
                                    .service_installation_details_list[0].isUnderApproval==1 && installation_indent_page_controller
                                    .service_installation_details_list[0].serviceStatus=="Completed"? true:false ,
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Text("Under Approval",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.redColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              );
                            },

                          ),

                          SizedBox(
                            height: 3,
                          ),
                          Obx(
                                () {
                              return  Visibility(
                                visible:  installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .isUnderApproval==0 &&  installation_indent_page_controller
                                    .service_installation_details_list[0].serviceStatus=="Rescheduled"?true:false,
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Tooltip(
                                      message:installation_indent_page_controller
                                          .service_installation_details_list[0].recheduleApprovalRemark?? "" ,
                                      child: Text(installation_indent_page_controller
                                          .service_installation_details_list[0].recheduleApprovalStatus?? "",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.redColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            // child:
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Obx(() {
                              return  Visibility(
                                visible: installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .isUnderApproval==1 && installation_indent_page_controller
                                  .service_installation_details_list[0].serviceStatus=="Rescheduled"?true:false,
                                child: Row(
                                  children: [
                                    Text(
                                      "Status",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Text("Under Approval",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.redColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              );
                            },
                            // child:
                          ),

                          /*SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer No",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerPhoneNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer Address",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerAddress!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Customer No",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .customerNo!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Date",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              *//*Text(
                                orderDate!,
                                style: GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),*//*
                            ],
                          ),*/
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 2),
                       // padding: EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 10),
                        //height: 200,
                        // width: double.infinity,
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0.0, 1.0),
                              color: Colors.black54,
                              blurRadius: 1.0)
                        ], color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Details ",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      installation_indent_page_controller.getItemDetails();
                                      ShowItemDetailsDialog(context);

                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Product",
                                          style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: size.width*.55,
                                          child: Tooltip(
                                            message:"${installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .itemName} (${installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .itemNo??""} )",
                                            child: Text("${installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .itemName} (${installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .itemNo!})"
                                              ,
                                              style: GoogleFonts.poppins(
                                                color: AllColors.textColor,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        "Category",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: size.width*.55,
                                        child: Tooltip(
                                          message:installation_indent_page_controller
                                              .service_installation_details_list[0]
                                              .categoryName?? "" ,
                                          child: Text("${installation_indent_page_controller
                                              .service_installation_details_list[0]
                                              .categoryName?? ""} "
                                            ,
                                            style: GoogleFonts.poppins(
                                              color: AllColors.textColor,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),


                                  Row(
                                    children: [
                                      Text(
                                        "Serial No. ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        installation_indent_page_controller
                                            .service_installation_details_list[0]
                                            .serialNo!,
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Service Tat",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        serViceTatDate! ,
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              return Visibility(
                                visible:  installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .complainReasonCode!=null &&  installation_indent_page_controller
                                    .service_installation_details_list[0]
                                    .complainReasonCode!=""  ?true:false,
                                child: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 1.0),
                                        color: Colors.black54,
                                        blurRadius: 1.0)
                                  ], color: Colors.white),
                                  padding: EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Complain Details ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),

                                             Row(
                                            children: [
                                              Text(
                                                "Complain Code",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: size.width*.55,
                                                child: Tooltip(
                                                  message:"${installation_indent_page_controller
                                                      .service_installation_details_list[0]
                                                      .complainReasonDesc?? ""}( ${installation_indent_page_controller
                                                      .service_installation_details_list[0]
                                                      .complainReasonCode?? ""} )",
                                                  child: Text("${installation_indent_page_controller
                                                      .service_installation_details_list[0]
                                                      .complainReasonDesc?? ""}( ${installation_indent_page_controller
                                                      .service_installation_details_list[0]
                                                      .complainReasonCode?? ""} )",
                                                    style: GoogleFonts.poppins(
                                                      color: AllColors.textColor,
                                                      fontSize: AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Obx(
                                            () {
                                          return Visibility(
                                            visible: installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .complainRemark!=null &&  installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .complainRemark!="" &&  installation_indent_page_controller
                                                .service_installation_details_list[0]
                                                .complainRemark!.isNotEmpty?true:false ,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Complain Remark",
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: size.width*.55,
                                                  child: Tooltip(
                                                    message:installation_indent_page_controller
                                                        .service_installation_details_list[0]
                                                        .complainRemark?? "" ,
                                                    child: Text(
                                                      installation_indent_page_controller
                                                          .service_installation_details_list[0]
                                                          .complainRemark?? "",
                                                      style: GoogleFonts.poppins(
                                                        color: AllColors.textColor,
                                                        fontSize: AllFontSize.fourtine,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },

                                      ),
                                    ],
                                  ),
                                ),
                              );

                            },
                             // child:
                            ),
                            Container(
                              //height: size.height*.13,
                              margin: EdgeInsets.only(top: 5,bottom: 5),
                              padding: EdgeInsets.only(left: 5.0, top: 0, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AllColors.textColor2,
                                          side: BorderSide(
                                            color: AllColors.primaryDark1,
                                            width: 1,
                                          ),
                                        ),
                                        onPressed: () {
                                          installation_indent_page_controller. image_description_flag.value="";
                                          installation_indent_page_controller
                                              .image_description_controller
                                              .clear();
                                          installation_indent_page_controller
                                              .image_flag
                                              .value = "Installation_Product";
                                          showConfirmationImageDialog(context);
                                          // Your onPressed logic here
                                        },
                                        icon: Icon(
                                          Icons.upload,
                                          // Replace with your desired icon
                                          color: AllColors
                                              .primaryDark1, // Icon color
                                        ),
                                        label: Container(
                                          width: size.width * .15,
                                          child: Tooltip(
                                            message: "Upload Product",
                                            child: Text(
                                              "Product",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AllColors.textColor2,
                                          side: BorderSide(
                                            color: AllColors.primaryDark1,
                                            width: 1,
                                          ),
                                        ),
                                        onPressed: () {
                                          installation_indent_page_controller.image_description_flag.value="Certificate";
                                          installation_indent_page_controller
                                              .image_description_controller
                                              .clear();
                                          installation_indent_page_controller
                                                  .image_flag.value =
                                              "Installation_Certificate";
                                          showConfirmationImageDialog(context);
                                        },
                                        icon: Icon(
                                          Icons.list_alt,
                                          // Replace with your desired icon
                                          color: AllColors
                                              .primaryDark1, // Icon color
                                        ),
                                        label: Container(
                                          width: size.width * .2,
                                          child: Tooltip(
                                            message: "Upload Certificate",
                                            child: Text(
                                              "Certificate",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                  SizedBox(height: 3,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                          () {
                                          return Visibility(
                                            visible:
                                            installation_indent_page_controller
                                                .  service_installation_details_list[0].serviceStatus ==
                                                "Completed"
                                                ? false
                                                : true,
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    AllColors.textColor2,
                                                    side: BorderSide(
                                                        color: AllColors
                                                            .primaryDark1,
                                                        width: 1)),
                                                onPressed: () {
                                                  installation_indent_page_controller.is_indent_type_dropDown.value=true;
                                                  installation_indent_page_controller.is_Showindent.value=false;
                                                  Get.toNamed(RoutesName.installation_Indent_view);


                                                 /* installation_indent_page_controller
                                                      .IndentHeaderCreateApi(
                                                      "");*/
                                                },
                                                icon: Icon(Icons.add_shopping_cart,color: AllColors.primaryDark1,),
                                                label: Container(
                                                  child:Tooltip(
                                                    message: "Stock Indent",
                                                    child: Text(
                                                      "Stock Indent",
                                                      style: GoogleFonts.poppins(
                                                        color: AllColors
                                                            .primaryDark1,
                                                        fontSize:
                                                        AllFontSize.fourtine,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                  ) ,
                                                ),
                                               // child:
                                            ),
                                          );
                                        },
                                      ),
                                      Obx(() {
                                        return Visibility(
                                          visible: installation_indent_page_controller.  service_installation_details_list[0].serviceStatus =="Completed"?false:true,
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AllColors.textColor2,
                                              side: BorderSide(
                                                color: AllColors.primaryDark1,
                                                width: 1,
                                              ),
                                            ),
                                            onPressed: () {
                                              installation_indent_page_controller
                                                  .indent_remark_controller
                                                  .clear();
                                              remarkDialog(context);

                                              // Your onPressed logic here
                                            },
                                            icon: Icon(
                                              Icons.check,
                                              // Replace with your desired icon
                                              color: AllColors
                                                  .primaryDark1, // Icon color
                                            ),
                                            label: Container(
                                            //  margin: EdgeInsets.only(right: size.width*.1),
                                             // width: size.width * .1,
                                              child: Tooltip(
                                                message: "Mark Complete",
                                                child: Text(
                                                  "Complete",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Obx(() {
                      return bindList();
                    }),
                    //SizedBox(height: 5,),
                    Obx(
                      () {
                        return  Visibility(
                          visible:installation_indent_page_controller.service_indent_header_list.length >
                              0 &&
                              installation_indent_page_controller
                                  .service_indent_header_list.isNotEmpty,
                          child: Divider(
                            height: 2,
                            color: AllColors.bluegrayColor,
                          ),
                        );
                      },
                     // child:
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bindIndentListView(BuildContext context, int index) {
    return Container(
      width: size.width * 0.8,
      child: InkWell(
        onTap: () {
          installation_indent_page_controller.IndentHeaderCreateApi(
              installation_indent_page_controller
                  .service_indent_header_list[index].indentNo!);
        },
        child: ListTile(
            subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Indent No. :",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
               /* SizedBox(
                  width: size.width * .02,
                ),*/
                Spacer(),
                Text(
                  installation_indent_page_controller
                      .service_indent_header_list[index].indentNo!,
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Service No.:",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
               /* SizedBox(
                  width: size.width * .01,
                ),*/
                Spacer(),
                Text(
                  installation_indent_page_controller
                      .service_indent_header_list[index].serviceNo!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Indent Type",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Container(
                  // width: size.width * .25,
                  child: Text(
                    installation_indent_page_controller
                        .service_indent_header_list[index].indentType!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Status :",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Container(
                 // width: size.width * .25,
                  child: Text(
                    installation_indent_page_controller
                        .service_indent_header_list[index].indentStatus!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  bindList() {
    if (installation_indent_page_controller.service_indent_header_list.length >
            0 &&
        installation_indent_page_controller
            .service_indent_header_list.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 2,bottom: 2),
         height: size.height * .12,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return VerticalDivider(

              color: AllColors.bluegrayColor,
              width: 1.0,

            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: installation_indent_page_controller
              .service_indent_header_list.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return bindIndentListView(context, index);
          },
        ),
      );
    } else {
      return Center(
        child: Text(""),
        /*Image.asset(
          "assests/images/no_data_remove.png", width: 300, height: 180,),*/
      );
    }
  }

  void showConfirmationImageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose Option...",
                style: TextStyle(
                  color: AllColors.primaryDark1,
                )),
            content: Container(
             // height: 180,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: .5,
                    color: AllColors.lightgreyColor,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      installation_indent_page_controller
                          .showLineImagesPopup(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: AllColors.primaryDark1,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'View',
                            style: TextStyle(color: AllColors.primaryDark1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: .5,
                    color: AllColors.lightgreyColor,
                  ),
                  InkWell(
                    onTap: () async {
                      installation_indent_page_controller.capture_flag.value =
                          "Capture";
                      installation_indent_page_controller.upLoadImage(context);

                      // installation_indent_page_controller.upLoadImage(context);
                      //Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(
                        () {
                          return Visibility(
                            visible: installation_indent_page_controller
                                        .  service_installation_details_list[0].serviceStatus  ==
                                    "Completed"
                                ? false
                                : true,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: AllColors.primaryDark1,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Camera',
                                  style:
                                      TextStyle(color: AllColors.primaryDark1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      return Visibility(
                        visible:installation_indent_page_controller
                            .  service_installation_details_list[0].serviceStatus  ==
                            "Completed"
                            ? false
                            : true,
                        child: Divider(
                          height: .5,
                          color: AllColors.lightgreyColor,
                        ),
                      );
                    },
                   // child:
                  ),
                  InkWell(
                    onTap: () async {
                      installation_indent_page_controller.capture_flag.value =
                      "Gallery";
                      installation_indent_page_controller.upLoadGalleryImage(context);

                      // installation_indent_page_controller.upLoadImage(context);
                      //Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(
                            () {
                          return Visibility(
                            visible: installation_indent_page_controller
                                .  service_installation_details_list[0].serviceStatus  ==
                                "Completed"
                                ? false
                                : true,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.photo,
                                  color: AllColors.primaryDark1,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Gallery',
                                  style:
                                  TextStyle(color: AllColors.primaryDark1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Obx(
                    () {
                      return Visibility(
                          visible: installation_indent_page_controller
                                      .  service_installation_details_list[0].serviceStatus  ==
                                  "Completed"
                              ? false
                              : true,
                          child: Divider(
                            height: .5,
                            color: AllColors.lightgreyColor,
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void remarkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mark Complete...',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),

             /* SizedBox(
                height: 8.0,
              ),*/
            ],
          ),
          content: Container(
            height: size.height * .17,
            child: Column(
              children: [
                TextFormField(
                  controller: installation_indent_page_controller
                      .indent_remark_controller,
                  decoration: InputDecoration(
                    labelText: "Enter Remark ",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AllColors.primaryDark1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    GeoTaggingMarkDialog(context);
                 /*   installation_indent_page_controller
                        .InstallationMarkComplete(
                            installation_indent_page_controller
                                .service_installation_details_list[0].id
                                .toString());*/
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      'Ok',
                      style: GoogleFonts.poppins(
                        color: AllColors.customDarkerWhite,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  Widget setupAlertDialoadContainer() {
    if(installation_indent_page_controller.item_details_list.length>0
       && installation_indent_page_controller.item_details_list.isNotEmpty
    && installation_indent_page_controller.item_details_list!=null){
      return
        Obx(
          () {
          return   Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(height: 1,color: AllColors.lightgreyColor,);
                },
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:installation_indent_page_controller.item_details_list.length ,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Text("Item :",
                              style:  GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AllFontSize.fourtine),),
                            Spacer(),
                            Container(
                              width: size.width*.2,
                              child: Tooltip(
                                message:"${installation_indent_page_controller.item_details_list[index].displayName?? ""}${installation_indent_page_controller.item_details_list[index].componentProductCode.toString()})" ,
                                child: Text("${installation_indent_page_controller.item_details_list[index].displayName?? ""}""(${installation_indent_page_controller.item_details_list[index].componentProductCode.toString()})",
                                  style:  GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AllFontSize.fourtine),
                                  overflow: TextOverflow.ellipsis,

                                ),
                              ),
                            )

                          ],
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Text("Quality :",
                              style:  GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AllFontSize.fourtine),),
                            Spacer(),
                            Text(installation_indent_page_controller.item_details_list[index].componentQuantity.toString(),
                              style:  GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AllFontSize.fourtine),)

                          ],
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Text("Price :",
                              style:  GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AllFontSize.fourtine),),
                            Spacer(),
                            Text(installation_indent_page_controller.item_details_list[index].componentPrice.toString(),
                              style:  GoogleFonts.poppins(
                                  color: AllColors.textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AllFontSize.fourtine),)

                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
         // child:
        );
    }else{
      return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0,
        child:Center(
          child:  Image.asset(
            "assests/images/no_data_remove.png",
            width: 300,
            height: 180,
          ),
        ),
      );
    }





  }
  void ShowItemDetailsDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Row(
                  children: [
                    Text('Item  Details',style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.sisxteen),),
                    Spacer(),
                    IconButton(onPressed: () {
                      Get.back();
                    }, icon: Icon(Icons.cancel,color: AllColors.primaryDark1,size: 20,
                    ))
                  ],
                ),
                Divider(color: AllColors.lightgreyColor,height: 1,)
              ],
            ),



            content: Obx(() {
              return setupAlertDialoadContainer();
            },

               // child:
            ),
          );
        });
  }

  void GeoTaggingMarkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Geo Tag Confirm...',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                ' Do you want to geo-Tagged for this Service?',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.fourtine,
                  // fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
            ],
          ),
          content: Container(
          // height: size.height * 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              //  SizedBox(height: size.height*.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                          Navigator.pop(context);
                          installation_indent_page_controller
                              .InstallationMarkComplete(
                              installation_indent_page_controller
                                  .service_installation_details_list[0].id
                                  .toString());
                        // Your installation mark complete logic here
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        if(installation_indent_page_controller
                            .service_installation_details_list[0].isGeoTag==1){
                          Utils.showErrorToastification("Message", "Geo Tag is Mandatory So You Can Not Skip This Process ");
                          return;
                        }else{
                          Navigator.pop(context);
                          installation_indent_page_controller
                              .InstallationMarkComplete(
                              installation_indent_page_controller
                                  .service_installation_details_list[0].id
                                  .toString());
                        }
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }



}
