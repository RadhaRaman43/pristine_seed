
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/models/serviceCorrectiveModel/indent_header_line_create_model.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/serviceCorrectiveModel/corrective_item_no_model.dart';
import '../../models/serviceIndentModel/Item_no_model.dart';
import '../../utils/app_utils.dart';
import '../../viewModel/corrective_vm/corrective_vm.dart';
import '../custom_drawer.dart';

class CorrectiveIndentHeaderViewScreen extends StatelessWidget{
  CorrectiveIndentHeaderViewScreen({super.key});
  final indent_deatils_page_controller=Get.put(CorrectiveViewModel());
  Size size=Get.size;
  static String _displayItemNoForOption(CorrectiveItemNoResponse option) =>
      option.itemCode!;
  static String _displayIndentTypeForOption(String option) => option!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        indent_deatils_page_controller.is_Showindent.value=false;
        indent_deatils_page_controller.CorrectiveIndentHeaderListApi();
        Get.toNamed(RoutesName.corrective_markvisit_screen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Indent Details',
            style: GoogleFonts.poppins(
              color: AllColors.whiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: IconThemeData(
            color: AllColors.whiteColor, // Change this to the desired color
          ),
          backgroundColor: AllColors.primaryDark1,
        ),
        drawer: CustomDrawer(),
        body:  Container(
          child: Column(
            children: [
              Obx(() {
                  return Container(
                    margin: EdgeInsets.only(top: 0.3),
                    child: Visibility(
                      visible: indent_deatils_page_controller.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    ),
                  );
                },
              ),


              Obx( () {
                return  Visibility(
                  visible: indent_deatils_page_controller.is_indent_type_dropDown.value,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child:   Column(
                       // crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          bindIndentDropDropDown(context),
                          SizedBox(height: 10,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AllColors.lightgreyColor,
                                backgroundColor: AllColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark, width: 1),
                                )),
                            onPressed: () {

                              indent_deatils_page_controller.IndentHeaderCreateApi("");

                              ;
                            },
                            child: Text(
                              'Create',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )
                  ),
                );
              },),
              Obx( () {
                if(indent_deatils_page_controller
                    .service_indent_header_create_list!=null && indent_deatils_page_controller
                    .service_indent_header_create_list.isNotEmpty && indent_deatils_page_controller
                    .service_indent_header_create_list.length>0){
                  return  Visibility(
                    visible:indent_deatils_page_controller.is_Showindent.value ,
                    child: Container(
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              //    height: size.height * .16,
                              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 1.0,
                                  offset: Offset(0.0, 0.55),
                                )
                              ], color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Indent Typ ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list[0]
                                            .indentType ??
                                            ''!,
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
                                        "Indent No. ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list[0]
                                            .indentNo ??
                                            ''!,
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
                                        "Service No.",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list[0].serviceNo??"",
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
                                  Obx(
                                        () {
                                      return Row(
                                        children: [
                                          Text(
                                            "Indent Status",
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            indent_deatils_page_controller
                                                .service_indent_header_create_list![0]
                                                .indentStatus ??
                                                "",
                                            style: GoogleFonts.poppins(
                                              color: AllColors.redColor,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Location",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list![0]
                                            .locationCode??"",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                 /* Obx(
                                        () {

                                          bool isVisible = indent_deatils_page_controller
                                              .service_indent_header_list.isNotEmpty &&
                                              (indent_deatils_page_controller
                                                  .service_indent_header_list[0].indentStatus ==
                                                  "Ready For Consumption" ||
                                                  indent_deatils_page_controller
                                                      .service_indent_header_list[0].indentStatus == "Received");
                                      return Visibility(
                                        visible: isVisible
                                        *//*indent_deatils_page_controller
                                            .service_indent_header_list[0]
                                            .indentStatus ==
                                            "Ready For Consumption" || indent_deatils_page_controller
                                            .service_indent_header_list[0]
                                            .indentStatus =="Receive"*//*
                                            ? true
                                            : false,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Location",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              indent_deatils_page_controller
                                                  .service_indent_header_list![0]
                                                  .locationCode??"",
                                              style: GoogleFonts.poppins(
                                                color: AllColors.textColor,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),*/
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Obx(
                                            () {
                                          return Visibility(
                                            visible: indent_deatils_page_controller
                                                .service_indent_header_create_list[0]
                                                .indentStatus ==
                                                "Ready For Consumption"
                                                ? true
                                                : false,
                                            child: Container(
                                              width: size.width * 0.4,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor: AllColors.lightgreyColor,
                                                    backgroundColor: AllColors.whiteColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      side: BorderSide(
                                                          color: AllColors.primaryDark,
                                                          width: 1),
                                                    )),
                                                onPressed: () {
                                                  indent_deatils_page_controller
                                                      .IndentConsumerHeaderMarkApi(
                                                      indent_deatils_page_controller
                                                          .service_indent_header_create_list[
                                                      0]
                                                          .indentNo!);
                                                },
                                                child: Text(
                                                  'Consume',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      fontSize: AllFontSize.sisxteen,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Obx(
                                            () {
                                          return Visibility(
                                            visible: indent_deatils_page_controller
                                                .service_indent_header_create_list[0]
                                                .indentStatus ==
                                                "Pending"
                                                ? true
                                                : false,
                                            child: Container(
                                              width: size.width * 0.4,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor: AllColors.lightgreyColor,
                                                    backgroundColor: AllColors.whiteColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      side: BorderSide(
                                                          color: AllColors.primaryDark,
                                                          width: 1),
                                                    )),
                                                onPressed: () {


                                                  RescheduleDateDialog(context);


                                                },
                                                child: Text(
                                                  'Complete',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      fontSize: AllFontSize.sisxteen,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //todo lines... details.....

                            Container(
                              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0.0, 0.55),
                                  color: Colors.black54,
                                  blurRadius: 0.5,
                                )
                              ], color: Colors.white),
                              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Line Details",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 8,
                                  ),
                                  Obx(
                                        () {
                                      final lines = indent_deatils_page_controller
                                          .service_indent_header_create_list[0].lines;

                                      // Check if lines is not null and has at least one element
                                      if (lines != null &&
                                          lines.isNotEmpty &&
                                          lines[0].lineNo == null) {
                                        return Visibility(
                                          visible: lines[0].lineNo == null,
                                          child: Obx(
                                                () {
                                              return Visibility(
                                                visible: indent_deatils_page_controller
                                                    .service_indent_header_create_list[
                                                0]
                                                    .indentStatus ==
                                                    "Pending"
                                                    ? true
                                                    : false,
                                                child: Tooltip(
                                                  message: "Header Delete",
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: AllColors.redColor),
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title: "Header Delete",
                                                        titleStyle: TextStyle(
                                                          color: AllColors.primaryDark1,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        content: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 15.0),
                                                          child: Text(
                                                            "Do you want to Delete?",
                                                            style: TextStyle(
                                                              color: AllColors.primaryDark1,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: AllFontSize.fourtine,
                                                            ),
                                                          ),
                                                        ),
                                                        confirm: OutlinedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            indent_deatils_page_controller
                                                                .IndentHeaderLineDelete(
                                                              indent_deatils_page_controller
                                                                  .service_indent_header_create_list[
                                                              0]
                                                                  .indentNo!,
                                                              lines[0].lineNo.toString(),
                                                              "HeaderDiscard",
                                                            );
                                                          },
                                                          child: Text("Yes",
                                                              style: TextStyle(
                                                                  color: Colors.red)),
                                                        ),
                                                        cancel: OutlinedButton(
                                                          onPressed: () => Get.back(),
                                                          child: Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color:
                                                                AllColors.primaryDark1),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return SizedBox(); // Return an empty widget if conditions are not met
                                      }
                                    },
                                  ),
                                  Spacer(),
                                  Obx(
                                        () {
                                      return Visibility(
                                        visible: indent_deatils_page_controller
                                            .service_indent_header_create_list[0]
                                            .indentStatus ==
                                            "Pending"
                                            ? true
                                            : false,
                                        child: Tooltip(
                                          message: "Add Line",
                                          child: IconButton(
                                            icon: Icon(Icons.add,
                                                color: AllColors.primaryDark1),
                                            onPressed: () {
                                              indent_deatils_page_controller.isCheckBox.value=false;
                                              indent_deatils_page_controller.getItemNo();
                                              indent_deatils_page_controller
                                                  .item_no_controller
                                                  .clear();
                                              indent_deatils_page_controller
                                                  .item_no_description_controller
                                                  .clear();
                                              indent_deatils_page_controller
                                                  .quantity_controller
                                                  .clear();
                                              indent_deatils_page_controller.discount_controller.clear();
                                              indent_deatils_page_controller.unit_price_controller.clear();
                                              indent_deatils_page_controller. item_price_controller.clear();
                                              showAddLineBottomSheet(context,null,"");
                                              //addLineDialog(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //  Divider(height: 0.55,color: AllColors.bluegrayColor,),
                            SizedBox(
                              height: 3,
                            ),
                            Obx(() => bindList(context),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return Container();
                }
              },)



       /*       Container(
                padding: EdgeInsets.all(10),
                //height: size.height * .16,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 0.55),
                  )
                ], color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Indent No. ",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          indent_deatils_page_controller
                              .service_indent_header_create_list[0]
                              .indentNo ??
                              ''!,
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
                          "Service No.",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          indent_deatils_page_controller
                              .service_indent_header_create_list[0].serviceNo!,
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
                    Obx(() {
                        return Row(
                          children: [
                            Text(
                              "Indent Status",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text(indent_deatils_page_controller
                                  .service_indent_header_create_list![0]
                                  .indentStatus?? '',
                              style: GoogleFonts.poppins(
                                color: AllColors.redColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                            return  Visibility(
                              visible: indent_deatils_page_controller
                                  .service_indent_header_create_list[
                              0]
                                  .indentStatus ==
                                  "Ready For Consumption" || indent_deatils_page_controller
                                  .service_indent_header_create_list[
                              0].indentStatus ==
                                  "Completed" ||
                                  indent_deatils_page_controller
                                      .service_indent_header_create_list[
                                  0]
                                      .indentStatus ==
                                      "Received" ||  indent_deatils_page_controller
                                  .service_indent_header_create_list[
                              0]
                                  .indentStatus ==
                                  "Rejected" ||
                                  indent_deatils_page_controller
                                      .service_indent_header_create_list[
                                  0].indentStatus=="Approved"
                                  ? true
                                  : false,
                              child: SizedBox(
                                width: size.width*.5,
                              ),
                            );
                          },

                        ),


                        Obx(() {
                          return Visibility(
                            visible: indent_deatils_page_controller
                                .service_indent_header_create_list[
                            0]
                                .indentStatus ==
                                "Ready For Consumption"
                                ? true
                                : false,
                            child: Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark1,
                                      width: 1),
                                )),
                                onPressed: () {
                                  indent_deatils_page_controller
                                      .IndentConsumerHeaderMarkApi(
                                      indent_deatils_page_controller
                                          .service_indent_header_create_list[
                                      0]
                                          .indentNo!);
                                },
                                child: Text(
                                  'Receive',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        },),
                        Obx(() {
                          return  Visibility(
                            visible:indent_deatils_page_controller
                                .service_indent_header_create_list[0]
                                .indentStatus=="Pending"
                                ? true
                                : false,
                            child: Container(
                              width: size.width * 0.4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark1, width: 1),
                                )),
                                onPressed: () {
                                  indent_deatils_page_controller.IndentComplete(
                                      indent_deatils_page_controller
                                          .service_indent_header_create_list[
                                      0]
                                          .indentNo!);

                                },
                                child: Text(
                                  'Complete',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.textColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );

                        },

                        ),
                      ],
                    ),

                  *//*  Row(
                      children: [
                       *//**//* Text(
                          "",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                          ),
                        ),*//**//*
                        //Spacer(),



                       *//**//* Obx(
                              () {
                            return Visibility(
                                visible: indent_deatils_page_controller
                                    .service_indent_header_create_list[
                                0]
                                    .indentStatus ==
                                    "Ready For Consumption"
                                    ? true
                                    : true,
                                child: InkWell(
                                  onTap: () {
                                    indent_deatils_page_controller
                                        .IndentConsumerHeaderMarkApi(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                        0]
                                            .indentNo!);
                                  },
                                  child: Image.asset(
                                    "assests/images/recieved_document.jpg",
                                    width: 30,
                                    height: 30,
                                  ),
                                ));
                          },
                        ),
                        Obx(() {
                          return Visibility(
                            visible: indent_deatils_page_controller
                                .service_indent_header_create_list[
                            0].indentStatus ==
                                "Completed" ||
                                indent_deatils_page_controller
                                    .service_indent_header_create_list[
                                0]
                                    .indentStatus ==
                                    "Ready For Consumption" ||
                                indent_deatils_page_controller
                                    .service_indent_header_create_list[
                                0]
                                    .indentStatus ==
                                    "Received" ||
                                indent_deatils_page_controller
                                    .service_indent_header_create_list[
                                0]
                                    .indentStatus ==
                                    "Rejected" ||
                                indent_deatils_page_controller
                                    .service_indent_header_create_list[
                                0].indentStatus=="Approved"
                                ? false
                                : true,
                            child: Tooltip(
                              message: "Complete",
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: InkWell(
                                    onTap: () {
                                      indent_deatils_page_controller.IndentComplete(
                                          indent_deatils_page_controller
                                              .service_indent_header_create_list[
                                          0]
                                              .indentNo!);
                                    },
                                    child: Image.asset(
                                      "assests/images/upload-file.png",
                                      width: 30,
                                      height: 30,
                                    )),
                              ),
                            ),
                          );
                        }),*//**//*



                      ],
                    ),*//*
                  ],
                ),
              ),*/








             /* Container(
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0.0, 0.55),
                    color: Colors.black54,
                    blurRadius: 0.5,
                  )
                ], color: Colors.white),
                padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Line Details",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(
                      flex: 8,
                    ),
                    Obx(
                          () {
                        final lines = indent_deatils_page_controller
                            .service_indent_header_create_list[0].lines;

                        // Check if lines is not null and has at least one element
                        if (lines != null &&
                            lines.isNotEmpty &&
                            lines[0].lineNo == null) {
                          return Visibility(
                            visible: lines[0].lineNo == null,
                            child: Obx(
                                  () {
                                return Visibility(
                                  visible:indent_deatils_page_controller
                                      .service_indent_header_create_list[0]
                                      .indentStatus=="Pending"
                                      ? true
                                      : false,
                                  child: Tooltip(
                                    message: "Header Delete",
                                    child: IconButton(
                                      icon: Icon(Icons.delete,
                                          color: AllColors.redColor),
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: "Header Delete",
                                          titleStyle: TextStyle(
                                            color: AllColors.primaryDark1,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: Text(
                                              "Do you want to Delete?",
                                              style: TextStyle(
                                                color: AllColors.primaryDark1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AllFontSize.fourtine,
                                              ),
                                            ),
                                          ),
                                          confirm: OutlinedButton(
                                            onPressed: () {
                                              Get.back();
                                              indent_deatils_page_controller
                                                  .IndentHeaderLineDelete(
                                                indent_deatils_page_controller
                                                    .service_indent_header_create_list[
                                                0]
                                                    .indentNo!,
                                                lines[0].lineNo.toString(),
                                                "HeaderDiscard",
                                              );
                                            },
                                            child: Text("Yes",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                          cancel: OutlinedButton(
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color:
                                                  AllColors.primaryDark1),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return SizedBox(); // Return an empty widget if conditions are not met
                        }
                      },
                    ),
                    Spacer(),
                    Obx(
                          () {
                        return Visibility(
                          visible: indent_deatils_page_controller
                              .service_indent_header_create_list[0]
                              .indentStatus ==
                              "Completed" ||
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[0]
                                  .indentStatus ==
                                  "Ready For Consumption" ||
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[0]
                                  .indentStatus ==
                                  "Received" ||
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[0]
                                  .indentStatus ==
                                  "Rejected" ||
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[
                              0].indentStatus=="Approved"
                              ? false
                              : true,
                          child: Tooltip(
                            message: "Add Line",
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  color: AllColors.primaryDark1),
                              onPressed: () {
                                indent_deatils_page_controller.getItemNo();
                                indent_deatils_page_controller
                                    .item_no_controller
                                    .clear();
                                indent_deatils_page_controller
                                    .item_no_description_controller
                                    .clear();
                                indent_deatils_page_controller
                                    .quantity_controller
                                    .clear();
                                indent_deatils_page_controller.isCheckBox.value==false;
                                indent_deatils_page_controller.discount_controller.clear();
                                indent_deatils_page_controller.unit_price_controller.clear();
                               // addLineDialog(context);
                                showAddLineBottomSheet(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              //  Divider(height: 0.55,color: AllColors.bluegrayColor,),
              SizedBox(
                height: 3,
              ),
              Obx(
                    () => bindList(context),
              )*/
            ],
          ),
        ),

      ),
    );
  }


  bindList(BuildContext context) {
    var headerList =
        indent_deatils_page_controller.service_indent_header_create_list;
    if (headerList != null && headerList.isNotEmpty) {
      var lines = headerList[0].lines;

      if (lines != null && lines.isNotEmpty && lines[0].lineNo != null) {
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return bindIntentListView(context, index);
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0.5, color: AllColors.bluegrayColor);
          },
          itemCount: lines.length,
        );
      }
    }

    return Center(
      child: Image.asset(
        "assests/images/no_data_remove.png",
        width: 300,
        height: 180,
      ),
    );
  }

  bindIntentListView(BuildContext context, int index) {
    return InkWell(
      onTap: () {

        showAddLineBottomSheet(context,indent_deatils_page_controller
            .service_indent_header_create_list[0]
            .lines![index],"View");


      },
      child: ListTile(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Item",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
              width: size.width*.67,
              child: Tooltip(
                message: indent_deatils_page_controller
                    .service_indent_header_create_list[0]
                    .lines![index]
                    .itemName
                    .toString() +
                    "(" +
                    indent_deatils_page_controller
                        .service_indent_header_create_list[0]
                        .lines![index]
                        .itemNo
                        .toString(),
                child: Text(
                  indent_deatils_page_controller
                      .service_indent_header_create_list[0]
                      .lines![index]
                      .itemName
                      .toString() +
                      "(" +
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .itemNo
                          .toString() +
                      ")",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Obx(() =>  Visibility(
                    visible:indent_deatils_page_controller
                        .service_indent_header_create_list[0]
                        .indentStatus=="Pending"
                        ? true
                        : false,
                    child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Line Delete",
                            titleStyle: const TextStyle(
                                color: AllColors.primaryDark1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Do you want to Delete?",
                                style: TextStyle(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AllFontSize.fourtine),
                              ),
                            ),
                            confirm: OutlinedButton(
                              onPressed: () {
                                Get.back();
                                indent_deatils_page_controller
                                    .IndentHeaderLineDelete(
                                    indent_deatils_page_controller
                                        .service_indent_header_create_list[0]
                                        .indentNo!,
                                    indent_deatils_page_controller
                                        .service_indent_header_create_list[0]
                                        .lines![index]
                                        .lineNo
                                        .toString(),
                                    "LineDiscard");
                              },
                              child: const Text("Yes",
                                  style: TextStyle(color: Colors.red)),
                            ),
                            cancel: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: AllColors.primaryDark1),
                                )),
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: AllColors.redColor,
                        )),
                  ),),
                  Obx(() =>   Visibility(
                    visible: indent_deatils_page_controller
                        .service_indent_header_create_list[0]
                        .indentStatus ==
                        "Ready For Consumption"
                        ? true
                        : false
                    ,
                    child: InkWell(
                        onTap: () {
                          //  indent_deatils_page_controller.consumer_quantity_controller.clear();
                          // indent_deatils_page_controller.bad_quantity_controller.clear();
                          indent_deatils_page_controller
                              .bad_quantity_controller.text =
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[0]
                                  .lines![index]
                                  .badQty.toString();

                          indent_deatils_page_controller
                              .consumer_quantity_controller.text ==
                              indent_deatils_page_controller
                                  .service_indent_header_create_list[0]
                                  .lines![index]
                                  .consumeQty!;
                          print(indent_deatils_page_controller
                              .service_indent_header_create_list[0]
                              .lines![index]
                              .consumeQty);
                          print("Consume......"+indent_deatils_page_controller
                              .consumer_quantity_controller.value.text);
                          addConsumeDialog(context, index);
                        },
                        child: Image.asset("assests/images/view.png",width: 23,height: 23,)

                      /*  Icon(
                        Icons.remove_red_eye,
                        //color: AllColors.bluegrayColor,
                      )*/
                    ),
                  ),)
                ],
              ),
            )
          ],
        ) ,
          subtitle: Container(
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(1.9),
                1: FlexColumnWidth(1.3),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(0.8),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      "Qty:.",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .qty
                          .toString() ??
                          '',
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Appr. Qty:.",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),

                    ),

                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .qty
                          .toString() ??
                          '',
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Dis. Amt.:",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .discountAmount.toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Total Price:",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .totalPrice
                          .toString() ??
                          '',
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Con Qty:.",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .consumeQty!
                          .toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      "Bad Qty:.",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      indent_deatils_page_controller
                          .service_indent_header_create_list[0]
                          .lines![index]
                          .badQty
                          .toString() ??
                          '',
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


        /*Visibility(
          visible:  indent_deatils_page_controller.bad_quantity_controller[0].indentStatus=="Completed"?false:true,
          child: InkWell(
            onTap: () {
              Get.defaultDialog(
                title: "Line Delete",
                titleStyle: const TextStyle(
                    color: AllColors.primaryDark1, fontSize: 18, fontWeight: FontWeight.bold),
                content: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Do you want to Delete?",
                    style: TextStyle(color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w600,fontSize: AllFontSize.fourtine),),

                ),
                confirm: OutlinedButton(
                  onPressed: ()   {
                    Get.back();
                    indent_deatils_page_controller.IndentHeaderLineDelete(indent_deatils_page_controller.service_indent_header_create_list[0].indentNo!,indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].lineNo.toString(),"LineDiscard");
                  } ,
                  child: const Text("Yes", style: TextStyle(color: Colors.red)),
                ),
                cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No",
                  style: TextStyle(color: AllColors.primaryDark1),)),
              );

            },
              child: Icon(Icons.delete,color: AllColors.redColor,)),
        ),*/

      ),
    );
  }

/*
  void addLineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Item Details...',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            height: size.height * .43,
            child: Column(
              children: [
                bindItemNoDropDown(context),
                TextFormField(
                  readOnly: true,
                  controller: indent_deatils_page_controller
                      .item_no_description_controller,
                  //   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Item Name",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                TextFormField(
                  controller:
                  indent_deatils_page_controller.quantity_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Quantity",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Obx(() => Checkbox(
                      fillColor:  MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      focusColor: AllColors.primaryDark1,
                      checkColor: AllColors.primaryDark1,
                      value:
                      indent_deatils_page_controller.isCheckBox.value,
                      onChanged: (value) {
                        indent_deatils_page_controller.isCheckBox.value =
                            value ?? false;
                        if(indent_deatils_page_controller.isCheckBox.value){

                          indent_deatils_page_controller. discount_controller.text="0";
                        }else{
                          indent_deatils_page_controller.discount_controller.text="";

                        }
                        print(
                            "Checkbox value: ${indent_deatils_page_controller.isCheckBox.value}");
                      },
                    )),
                    Text(
                      "Customer Damage",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Obx(
                      () {
                    return  TextFormField(
                      readOnly: indent_deatils_page_controller.isCheckBox.value==true?true:false,
                      controller:
                      indent_deatils_page_controller.discount_controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Discount%",
                        labelStyle: TextStyle(color: AllColors.primaryDark1),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AllColors.primaryDark1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AllColors.primaryDark1),
                        ),
                      ),
                    );
                  },
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

                    indent_deatils_page_controller.IndentLineCreate(
                        indent_deatils_page_controller
                            .service_indent_header_create_list[0].indentNo!,context);
                    // todo  Your onPressed logic...
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      'Add item',
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
  }*/

  Widget bindItemNoDropDown(context, String flag) {
    return Autocomplete<CorrectiveItemNoResponse>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return indent_deatils_page_controller.item_no_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return indent_deatils_page_controller.item_no_list.value
            .where((CorrectiveItemNoResponse option) {
          return option.itemCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CorrectiveItemNoResponse selection) {
        print(selection.itemCode);
        indent_deatils_page_controller.item_no_controller.text =
            _displayItemNoForOption(selection).toString();
        indent_deatils_page_controller.item_no = selection.itemCode!;
        indent_deatils_page_controller.is_warrenty =selection.isWarranty!;
        indent_deatils_page_controller.unit_price =selection.costPerUnit!;
        indent_deatils_page_controller.unit_price_controller.text=selection.costPerUnit.toString()!;
        indent_deatils_page_controller.item_price_controller.text=selection.costPerUnit.toString()!;
        indent_deatils_page_controller.item_no_description_controller.text =
        selection.displayName!;
        if(indent_deatils_page_controller.is_warrenty>0){
          indent_deatils_page_controller.discount_controller.text="100";

        }

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: flag=="View"?true:false,
          enabled: flag=="View"?false:true,
          onChanged: (value) {
            if (value.isEmpty) {
              indent_deatils_page_controller.item_no_description_controller
                  .clear();
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = indent_deatils_page_controller.item_no_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Item Code .',
            labelText: 'Select Item Code',
            hintStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CorrectiveItemNoResponse> onSelected,
          Iterable<CorrectiveItemNoResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              //width: size.width * .65,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CorrectiveItemNoResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*.8,
                              child: Tooltip(
                                message: option.itemCode.toString() +
                                    " (${option.displayName ?? ""} )",
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  option.itemCode.toString() +
                                      " (${option.displayName ?? ""} )",
                                  style: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: AllFontSize
                                          .sisxteen // Change the text color here
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),

                            Visibility(
                              visible: option.isWarranty! > 0 ? true : false,
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 22.0),
                                  child: Icon(
                                    Icons.verified_user,
                                    size: 15,
                                    color: AllColors.primaryDark1,
                                  )),
                            ),

                            // child:
                          ],
                          // child:
                        )
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void addConsumeDialog(BuildContext context, int index) {
    double remaining_qty= indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].qtyIssueFromNav!;
    indent_deatils_page_controller.remain_quantity_controller.text=remaining_qty.toString();

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
                'Fill Details',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.primaryDark1,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Total Appr Qty. (  ${indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].qtyIssueFromNav}  ) ',
                style: GoogleFonts.poppins(
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w700,
                  color: AllColors.redColor,
                ),
              ),
            ],
          ),

          content: Container(
            height: size.height * .35,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    double consume_qty=double.parse( (value=="")?"0":value);
                    double bad_qty=double.parse(indent_deatils_page_controller.bad_quantity_controller.text=="" ?'0':indent_deatils_page_controller.bad_quantity_controller.text);
                    double remaining_qty=indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].qtyIssueFromNav!-(consume_qty+bad_qty);
                    indent_deatils_page_controller.remain_quantity_controller.text=remaining_qty.toString();
                  },
                  controller: indent_deatils_page_controller
                      .consumer_quantity_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Consume Qty ",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    double bad_qty=double.parse( (value=="")?"0":value);
                    double consume_qty=double.parse(indent_deatils_page_controller.consumer_quantity_controller.text=="" ?'0':indent_deatils_page_controller.consumer_quantity_controller.text);
                    double remaining_qty=indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].qtyIssueFromNav!-(consume_qty+bad_qty);
                    indent_deatils_page_controller.remain_quantity_controller.text=remaining_qty.toString();
                  },
                  controller:
                  indent_deatils_page_controller.bad_quantity_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Bad Qty",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),

                TextFormField(
                  controller: indent_deatils_page_controller
                      .remain_quantity_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Remain Qty ",
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
                    indent_deatils_page_controller.IndentConsumerLineApi(
                        indent_deatils_page_controller
                            .service_indent_header_create_list[0].indentNo!,
                        indent_deatils_page_controller
                            .service_indent_header_create_list[0]
                            .lines![index]
                            .lineNo!);
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      'Save',
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


  void showAddLineBottomSheet(BuildContext context, Lines ?lines,String flag) {
    RxDouble sub_total=0.0.obs;
    RxDouble discount_amount=0.0.obs;
    RxDouble total_amount=0.0.obs;
    indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();
    if(flag=="View"){
      indent_deatils_page_controller.isCheckBox.value =
      lines!.isCustomerDamage! > 0 ? true : false;
      indent_deatils_page_controller.item_no_controller.text=lines!.itemNo!;
      indent_deatils_page_controller.item_no_description_controller.text=lines!.itemName!;
      indent_deatils_page_controller.quantity_controller.text=lines!.qty!.toString();
      indent_deatils_page_controller.discount_controller.text=lines!.discountPer!.toString();
      indent_deatils_page_controller.unit_price_controller.text=lines!.unitPrice!.toString();
      sub_total.value=lines!.subTotal!;
      discount_amount.value=lines!.discountAmount!;
      total_amount.value=lines!.totalPrice!;
      indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();
      indent_deatils_page_controller.item_price_controller.text=lines.actualUnitPrice.toString();
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Line",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Icon(
                            Icons.cancel,
                            color: AllColors.primaryDark1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                    child: Divider(
                      height: 1,
                      color: AllColors.primaryDark1,
                    )),
                SingleChildScrollView(
                  child: Container(
                    //height: 420,
                    child: Column(
                      children: [
                        bindItemNoDropDown(context,flag),
                        TextFormField(
                          readOnly: true,
                          controller: indent_deatils_page_controller.item_no_description_controller,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Item Name",
                            labelStyle: TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),

                        TextFormField(
                          readOnly: flag=="View"?true:false,
                          onChanged: (value) {
                            double currentQty =  double.parse((indent_deatils_page_controller.quantity_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.quantity_controller.text);
                            double current_unitPrice = double.parse((indent_deatils_page_controller.unit_price_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.unit_price_controller.text);
                            double current_discount_per = double.parse((indent_deatils_page_controller.discount_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.discount_controller.text);



                            indent_deatils_page_controller.unit_price_controller.text= (indent_deatils_page_controller.unit_price-(indent_deatils_page_controller.unit_price*current_discount_per/100)).toStringAsFixed(2);


                            sub_total.value = currentQty * indent_deatils_page_controller.unit_price;

                            discount_amount.value = (currentQty *
                                indent_deatils_page_controller.unit_price *
                                current_discount_per /
                                100).abs();
                            total_amount.value =(currentQty * current_unitPrice);
                            indent_deatils_page_controller
                                .paybal_amount_controller
                                .text = total_amount.value.toString();



                            /*sub_total.value = currentQty * current_unitPrice;
                            discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                            total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                            indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();*/
                          },
                          controller:
                          indent_deatils_page_controller.quantity_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Quantity",
                            labelStyle: TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Obx(() => Checkbox(
                              fillColor:  MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              focusColor: AllColors.primaryDark1,
                              checkColor: AllColors.primaryDark1,
                              value:
                              indent_deatils_page_controller.isCheckBox.value,
                              onChanged: (value) {
                                if(flag=="View"){
                                  return null;
                                }
                                indent_deatils_page_controller.isCheckBox.value =
                                    value ?? false;
                                if(indent_deatils_page_controller.isCheckBox.value){
                                  indent_deatils_page_controller. discount_controller.text="0";
                                }else{
                                  indent_deatils_page_controller. discount_controller.text="";
                                }
                                if(indent_deatils_page_controller.is_warrenty>0 && !indent_deatils_page_controller.isCheckBox.value){
                                  indent_deatils_page_controller.discount_controller.text="100";

                                }
                                // print(
                                //     "Checkbox value: ${indent_deatils_page_controller.isCheckBox.value}");
                                double currentQty =  double.parse((indent_deatils_page_controller.quantity_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.quantity_controller.text);
                                double current_unitPrice = double.parse((indent_deatils_page_controller.unit_price_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.unit_price_controller.text);


                                double current_discount_per = double.parse(
                                    (indent_deatils_page_controller
                                        .discount_controller
                                        .text
                                        .isEmpty)
                                        ? "0"
                                        : indent_deatils_page_controller
                                        .discount_controller.text);


                                indent_deatils_page_controller.discount_controller.text=current_discount_per.abs().toStringAsFixed(2);

                                indent_deatils_page_controller.unit_price_controller.text= (indent_deatils_page_controller.unit_price-(indent_deatils_page_controller.unit_price*current_discount_per/100)).toStringAsFixed(2);

                                sub_total.value = currentQty * indent_deatils_page_controller.unit_price;

                                discount_amount.value = (currentQty *
                                    indent_deatils_page_controller.unit_price *
                                    current_discount_per /
                                    100).abs();
                                total_amount.value =(currentQty * current_unitPrice);
                                indent_deatils_page_controller
                                    .paybal_amount_controller
                                    .text = total_amount.value.toString();



                            /*
                                double current_discount_per = double.parse((indent_deatils_page_controller.discount_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.discount_controller.text);
                                sub_total.value = currentQty * current_unitPrice;
                                discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                                total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                                indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();*/

                              },
                            )),
                            Text(
                              "Customer Damage",
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twelve,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: indent_deatils_page_controller.item_price_controller,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Unit Price",
                            labelStyle: TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),
                       // Obx(() {
                         // return

                            TextFormField(
                            onChanged: (value) {
                              //todo discount not grether 100....
                              double enteredDiscount = double.tryParse(value) ?? 0;

                              // Check if entered discount is greater than 100
                              if (enteredDiscount > 100) {
                                enteredDiscount = 100;
                                // Set the text to 100 if it's greater than 100
                                indent_deatils_page_controller.discount_controller.text = "100";

                                Utils.showErrorToastification("Error!", "Discount % Cannot Be Greater Than 100");
                              }

                              double currentQty =  double.parse((indent_deatils_page_controller.quantity_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.quantity_controller.text);
                              double current_unitPrice = double.parse((indent_deatils_page_controller.unit_price_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.unit_price_controller.text);
                              double current_discount_per = double.parse((indent_deatils_page_controller.discount_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.discount_controller.text);


                              indent_deatils_page_controller.unit_price_controller.text=(indent_deatils_page_controller.unit_price-(indent_deatils_page_controller.unit_price*current_discount_per/100)).abs().toStringAsFixed(2);

                              sub_total.value = currentQty * indent_deatils_page_controller.unit_price;
                              discount_amount.value = (currentQty *
                                  current_unitPrice *
                                  current_discount_per /
                                  100).abs();
                              total_amount.value =
                                  (currentQty * current_unitPrice) -
                                      (currentQty *
                                          current_unitPrice *
                                          current_discount_per /
                                          100);
                              indent_deatils_page_controller
                                  .paybal_amount_controller
                                  .text = total_amount.value.toString();


                             /* sub_total.value = currentQty * current_unitPrice;
                              discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                              total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                              indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();*/
                            },
                            readOnly: /*indent_deatils_page_controller.isCheckBox.value==true ||*/  flag=="View"?true:false,
                            controller:  indent_deatils_page_controller.discount_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Enter Discount%",
                              labelStyle: TextStyle(color: AllColors.primaryDark1),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AllColors.primaryDark1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AllColors.primaryDark1),
                              ),
                            ),
                          ),
                     //   },
                       // ),


                        TextFormField(
                          readOnly: flag=="View"?true:false,
                          onChanged: (value) {
                            
                            
                            double currentQty =  double.parse((indent_deatils_page_controller.quantity_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.quantity_controller.text);
                            double current_unitPrice = double.parse((indent_deatils_page_controller.unit_price_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.unit_price_controller.text);

                            double current_discount_per = ((indent_deatils_page_controller.unit_price-current_unitPrice)*100/indent_deatils_page_controller.unit_price).abs();


                            if(current_unitPrice>indent_deatils_page_controller.unit_price){
                              indent_deatils_page_controller.unit_price_controller.text=indent_deatils_page_controller.unit_price.toStringAsFixed(2);
                              indent_deatils_page_controller.discount_controller.text="0";
                              current_discount_per=0;
                              Utils.showErrorToastification("Message!", "Price After Discount Must be Lesser Unit price:${indent_deatils_page_controller.unit_price.toStringAsFixed(2)}");
                            }

                            indent_deatils_page_controller.discount_controller.text= current_discount_per.abs().toStringAsFixed(2);

                            sub_total.value = currentQty * indent_deatils_page_controller.unit_price;

                            discount_amount.value = (currentQty *
                                indent_deatils_page_controller.unit_price *
                                current_discount_per /
                                100).abs();
                            total_amount.value =(currentQty * current_unitPrice);
                            indent_deatils_page_controller
                                .paybal_amount_controller
                                .text = total_amount.value.toString();

                          /*  double current_discount_per = double.parse((indent_deatils_page_controller.discount_controller.text.isEmpty) ? "0" : indent_deatils_page_controller.discount_controller.text);
                            sub_total.value = currentQty * current_unitPrice;
                            discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                            total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                            indent_deatils_page_controller.paybal_amount_controller.text=total_amount.value.toString();*/
                          },
                          controller:
                          indent_deatils_page_controller.unit_price_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Price After Discount",
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
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Sub Total",style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Spacer(),

                                    Obx(() {
                                      return Text( sub_total.value.toStringAsFixed(2),style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),);
                                    },
                                      //child:
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Text(
                                      "Discount:",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Obx(
                                          () {
                                        return Text(
                                          discount_amount.value.abs()
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                            color: AllColors.textColor,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      },
                                      //child:
                                    ),
                                  ],
                                ),
                                 Row(
                                  children: [
                                    Text("Paybal Amount:",style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Spacer(),
                                    Obx(() {
                                      return Text(
                                        total_amount.value.toStringAsFixed(2),
                                        style: GoogleFonts.poppins(
                                          color: AllColors.textColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    },
                                      //child:
                                    ),

                                  ],
                                )
                              ],
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
                            indent_deatils_page_controller.IndentLineCreate(
                                indent_deatils_page_controller
                                    .service_indent_header_create_list[0].indentNo!,context);
                            //  Navigator.pop(context);
                            // todo  Your onPressed logic...
                          },
                          child: Container(
                            width: 80,
                            alignment: Alignment.center,
                            child: Text(
                              'Add item',
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bindIndentDropDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIndentTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return indent_deatils_page_controller.indent_type_list;
        }
        return indent_deatils_page_controller.indent_type_list;
      },
      onSelected: (String selection) {
        print(selection);
        indent_deatils_page_controller.indent_type_controller.text =
            _displayIndentTypeForOption(selection).toString();

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = indent_deatils_page_controller.indent_type_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Indent Type',
            labelText: 'Indent Type',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                //fontWeight: FontWeight.w300,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  RescheduleDateDialog(BuildContext context) {
    indent_deatils_page_controller.indent_date_controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Reschedule date',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content: Container(
            //height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bindDatePicker(context),
                SizedBox(height: size.height*.03),
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
                        indent_deatils_page_controller.IndentComplete(
                            indent_deatils_page_controller
                                .service_indent_header_create_list[
                            0]
                                .indentNo!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 60,
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
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AllColors.primaryDark1,
                        ),
                      ),
                      onPressed: () {
                        indent_deatils_page_controller.indent_date_controller.clear();
                        Navigator.pop(context);


                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bindDatePicker(BuildContext context) {
    return TextFormField(
      controller: indent_deatils_page_controller.indent_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          /*fontWeight: FontWeight.w500,
            fontSize: AllFontSize.sisxteen*/),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime starting_date = DateTime.now();
        DateTime ending_date = DateTime(2200);
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: starting_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        var outputFormat = DateFormat('yyyy-MM-dd');

        if (date != null) {
          indent_deatils_page_controller.indent_date_controller.text =
              outputFormat.format(date);
        } else {
          indent_deatils_page_controller.indent_date_controller.text = "";
        }
      },
    );
  }


}