import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/models/servicePreventiveModel/indent_header_line_create_model.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/servicePreventiveModel/preventive_item_no_moel.dart';
import '../../viewModel/preventive_vm/preventive_vm.dart';
import '../custom_drawer.dart';

class PreventiveIndentHeaderViewScreen extends StatelessWidget{
  PreventiveIndentHeaderViewScreen({super.key});
  final preventive_indent_detils_page_controller=Get.put(PreventiveViewModel());
  Size size= Get.size;
  static String _displayItemNoForOption(PreventiveItemNoResponse option) =>
      option.itemCode!;
  static String _displayIndentTypeForOption(String option) => option!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        preventive_indent_detils_page_controller.is_Showindent.value=false;
        Get.toNamed(RoutesName.preventive_markvisit_screen);
        preventive_indent_detils_page_controller.IndentHeaderListApi();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Indent Details',
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
          child: Column(
            children: [
              Obx(
                    () {
                  return Container(
                    margin: EdgeInsets.only(top: 0.3),
                    child: Visibility(
                      visible: preventive_indent_detils_page_controller.loading
                          .value,
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
                  visible: preventive_indent_detils_page_controller.is_indent_type_dropDown.value,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child:   Column(
                      //  crossAxisAlignment:CrossAxisAlignment.start ,
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

                              preventive_indent_detils_page_controller.IndentHeaderCreateApi("");

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
                if(preventive_indent_detils_page_controller
                    .service_indent_header_list!=null && preventive_indent_detils_page_controller
                    .service_indent_header_list.isNotEmpty && preventive_indent_detils_page_controller
                    .service_indent_header_list.length>0){
                  return  Visibility(
                    visible:preventive_indent_detils_page_controller.is_Showindent.value ,
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
                                        "Indent No. ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        preventive_indent_detils_page_controller
                                            .service_indent_header_list[0]
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
                                        preventive_indent_detils_page_controller
                                            .service_indent_header_list[0].serviceNo??"",
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
                                            preventive_indent_detils_page_controller
                                                .service_indent_header_list![0]
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
                                  Obx(() {
                                          bool isVisible = preventive_indent_detils_page_controller
                                              .service_indent_header_list.isNotEmpty &&
                                              (preventive_indent_detils_page_controller
                                                  .service_indent_header_list[0].indentStatus ==
                                                  "Issued From Warehouse" ||
                                                  preventive_indent_detils_page_controller
                                                      .service_indent_header_list[0].indentStatus == "Received");
                                      return Visibility(
                                        visible:isVisible

                                        /*preventive_indent_detils_page_controller
                                            .service_indent_header_list[0]
                                            .indentStatus ==
                                            "Issued From Warehouse" || preventive_indent_detils_page_controller
                                            .service_indent_header_list[0]
                                            .indentStatus =="Received"*/

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
                                              preventive_indent_detils_page_controller
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
                                  ),
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
                                            visible: preventive_indent_detils_page_controller
                                                .service_indent_header_list[0]
                                                .indentStatus ==
                                                "Issued From Warehouse"
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
                                                  preventive_indent_detils_page_controller
                                                      .IndentConsumerHeaderMarkApi(
                                                      preventive_indent_detils_page_controller
                                                          .service_indent_header_list[
                                                      0]
                                                          .indentNo!);
                                                },
                                                child: Text(
                                                  'Received',
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
                                            visible: preventive_indent_detils_page_controller
                                                .service_indent_header_list[0]
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
                                                  preventive_indent_detils_page_controller.IndentComplete(
                                                      preventive_indent_detils_page_controller
                                                          .service_indent_header_list[
                                                      0]
                                                          .indentNo!);
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
                                      final lines = preventive_indent_detils_page_controller
                                          .service_indent_header_list[0].lines;

                                      // Check if lines is not null and has at least one element
                                      if (lines != null &&
                                          lines.isNotEmpty &&
                                          lines[0].lineNo == null) {
                                        return Visibility(
                                          visible: lines[0].lineNo == null,
                                          child: Obx(
                                                () {
                                              return Visibility(
                                                visible: preventive_indent_detils_page_controller
                                                    .service_indent_header_list[
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
                                                            preventive_indent_detils_page_controller
                                                                .IndentHeaderLineDelete(
                                                              preventive_indent_detils_page_controller
                                                                  .service_indent_header_list[
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
                                        visible: preventive_indent_detils_page_controller
                                            .service_indent_header_list[0]
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
                                              preventive_indent_detils_page_controller.isCheckBox.value=false;
                                              preventive_indent_detils_page_controller.getItemNo();
                                              preventive_indent_detils_page_controller
                                                  .item_no_controller
                                                  .clear();
                                              preventive_indent_detils_page_controller
                                                  .item_no_description_controller
                                                  .clear();
                                              preventive_indent_detils_page_controller
                                                  .quantity_controller
                                                  .clear();
                                              preventive_indent_detils_page_controller.discount_controller.clear();
                                              preventive_indent_detils_page_controller.unit_price_controller.clear();

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

            /*  Container(
                padding: EdgeInsets.all(10),
               // height: size.height * .2,
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
                          preventive_indent_detils_page_controller
                              .service_indent_header_list[0]
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
                          preventive_indent_detils_page_controller
                              .service_indent_header_list[0].serviceNo!,
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
                              preventive_indent_detils_page_controller
                                  .service_indent_header_list![0]
                                  .indentStatus?? "",
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
                       *//* Obx(
                              () {
                            return Visibility(
                                visible: preventive_indent_detils_page_controller
                                    .service_indent_header_list[
                                0]
                                    .indentStatus ==
                                    "Issued From Warehouse"
                                    ? true
                                    : false,
                                child: InkWell(
                                  onTap: () {
                                    preventive_indent_detils_page_controller
                                        .IndentConsumerHeaderMarkApi(
                                        preventive_indent_detils_page_controller
                                            .service_indent_header_list[
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
                        ),*//*


                        Obx(() {

                            return Visibility(
                              visible:preventive_indent_detils_page_controller
                                  .service_indent_header_list[
                              0]
                                  .indentStatus ==
                                  "Issued From Warehouse"
                                  ? true
                                  : false,
                              child: Container(
                                width: size.width * 0.4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: AllColors.lightgreyColor, backgroundColor: AllColors.whiteColor, shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: AllColors.primaryDark,
                                        width: 1),
                                  )),
                                  onPressed: () {
                                    preventive_indent_detils_page_controller
                                        .IndentConsumerHeaderMarkApi(
                                        preventive_indent_detils_page_controller
                                            .service_indent_header_list[
                                        0]
                                            .indentNo!);
                                  },
                                  child: Text(
                                    'Recieved',
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
                              visible:preventive_indent_detils_page_controller
                                  .service_indent_header_list![
                              0]
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
                                        color: AllColors.primaryDark,
                                        width: 1),
                                  )),
                                  onPressed: () {

                                    preventive_indent_detils_page_controller
                                        .IndentComplete(
                                        preventive_indent_detils_page_controller
                                            .service_indent_header_list![
                                        0]
                                            .indentNo!);


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


                       *//* Obx(() {
                          return Visibility(
                            visible: preventive_indent_detils_page_controller
                                .service_indent_header_list.length>0 && (preventive_indent_detils_page_controller
                                .service_indent_header_list![
                            0]
                                .indentStatus! ==
                                "Completed" ||
                                preventive_indent_detils_page_controller
                                    .service_indent_header_list[
                                0]
                                    .indentStatus! ==
                                    "Issued From Warehouse" ||
                                preventive_indent_detils_page_controller
                                    .service_indent_header_list[
                                0]
                                    .indentStatus! ==
                                    "Received" ||
                                preventive_indent_detils_page_controller
                                    .service_indent_header_list[
                                0]
                                    .indentStatus! ==
                                    "Rejected"
                            )
                                ? false
                                : true,
                            child: Tooltip(
                              message: "Complete",
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: InkWell(
                                    onTap: () {
                                      preventive_indent_detils_page_controller
                                          .IndentComplete(
                                          preventive_indent_detils_page_controller
                                              .service_indent_header_list![
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
                        }),*//*
                      ],
                    ),
                  ],
                ),
              ),

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
                        final lines = preventive_indent_detils_page_controller
                            .service_indent_header_list![0].lines;

                        // Check if lines is not null and has at least one element
                        if (lines != null &&
                            lines.isNotEmpty &&
                            lines[0].lineNo == null) {
                          return Visibility(
                            visible: lines[0].lineNo == null,
                            child: Obx(
                                  () {
                                return Visibility(
                                  visible: preventive_indent_detils_page_controller
                                      .service_indent_header_list![
                                  0]
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
                                             // Get.back();
                                              preventive_indent_detils_page_controller
                                                  .IndentHeaderLineDelete(
                                                preventive_indent_detils_page_controller
                                                    .service_indent_header_list![
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
                    Obx(() {
                        return Visibility(visible: preventive_indent_detils_page_controller.service_indent_header_list![0]
                              .indentStatus=="Pending"
                              ? true
                              : false,
                          child: Tooltip(
                            message: "Add Line",
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  color: AllColors.primaryDark1),
                              onPressed: () {
                                preventive_indent_detils_page_controller.isCheckBox.value=false;
                                preventive_indent_detils_page_controller.getItemNo();
                                preventive_indent_detils_page_controller
                                    .item_no_controller
                                    .clear();
                                preventive_indent_detils_page_controller
                                    .item_no_description_controller
                                    .clear();
                                preventive_indent_detils_page_controller.quantity_controller
                                    .clear();
                                preventive_indent_detils_page_controller.discount_controller.clear();
                                preventive_indent_detils_page_controller.unit_price_controller.clear();
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
        preventive_indent_detils_page_controller
            .service_indent_header_list;
    if (headerList != null && headerList.isNotEmpty) {
      var lines = headerList[0].lines;

      if (lines != null && lines.isNotEmpty && lines[0].lineNo != null) {
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return bindIntentListView(context, index);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0.5, color: AllColors.bluegrayColor);
            },
            itemCount: lines.length,
          ),
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



        showAddLineBottomSheet(context, preventive_indent_detils_page_controller
            .service_indent_header_list[0]
            .lines![index],"View");


      },
      child: ListTile(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Item:",
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              preventive_indent_detils_page_controller
                  .service_indent_header_list[0]
                  .lines![index]
                  .itemName
                  .toString() +
                  "(" +
                  preventive_indent_detils_page_controller
                      .service_indent_header_list[0]
                      .lines![index]
                      .itemNo
                      .toString() +
                  ")",
              style: GoogleFonts.poppins(
                color: AllColors.textColor,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
                          .indentStatus ==
                          "Pending"
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
                                  preventive_indent_detils_page_controller
                                      .IndentHeaderLineDelete(
                                      preventive_indent_detils_page_controller
                                          .service_indent_header_list[0]
                                          .indentNo!,
                                      preventive_indent_detils_page_controller
                                          .service_indent_header_list[0]
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
                    );
                  },
                  ),
                  Visibility(
                    visible: preventive_indent_detils_page_controller
                        .service_indent_header_list[0]
                        .indentStatus ==
                        "Issued From Warehouse"
                        ? true
                        : false
                    ,
                    child: InkWell(
                        onTap: () {
                          preventive_indent_detils_page_controller
                              .bad_quantity_controller.text =
                              preventive_indent_detils_page_controller
                                  .service_indent_header_list[0]
                                  .lines![index]
                                  .badQty.toString();

                          preventive_indent_detils_page_controller
                              .consumer_quantity_controller.text ==
                              preventive_indent_detils_page_controller
                                  .service_indent_header_list[0]
                                  .lines![index]
                                  .consumeQty.toString();
                          print(preventive_indent_detils_page_controller
                              .service_indent_header_list[0]
                              .lines![index]
                              .consumeQty.toString());
                          print("Consume......"+preventive_indent_detils_page_controller
                              .consumer_quantity_controller.value.text);
                          addConsumeDialog(context, index);
                        },
                        child: Image.asset("assests/images/view.png",width: 23,height: 23,)

                      /*  Icon(
                        Icons.remove_red_eye,
                        //color: AllColors.bluegrayColor,
                      )*/
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
                      "Appr. Qty:. ",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
                      "Con Qty.:",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
                      preventive_indent_detils_page_controller
                          .service_indent_header_list[0]
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
          visible:  preventive_indent_detils_page_controller.bad_quantity_controller[0].indentStatus=="Completed"?false:true,
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
                    preventive_indent_detils_page_controller.IndentHeaderLineDelete(preventive_indent_detils_page_controller.service_indent_header_create_list[0].indentNo!,preventive_indent_detils_page_controller.service_indent_header_create_list[0].lines![index].lineNo.toString(),"LineDiscard");
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

  /*void addLineDialog(BuildContext context) {
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
                  controller: preventive_indent_detils_page_controller
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
                  preventive_indent_detils_page_controller.quantity_controller,
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
                      preventive_indent_detils_page_controller.isCheckBox.value,
                      onChanged: (value) {
                        preventive_indent_detils_page_controller.isCheckBox.value =
                            value ?? false;
                        if(preventive_indent_detils_page_controller.isCheckBox.value){

                          preventive_indent_detils_page_controller.discount_controller.text="0";
                        }else{
                          preventive_indent_detils_page_controller.discount_controller.text="";
                        }
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
                      readOnly: preventive_indent_detils_page_controller.isCheckBox.value==true?true:false,
                      controller:preventive_indent_detils_page_controller.discount_controller,
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
                    Navigator.pop(context);
                    preventive_indent_detils_page_controller.IndentLineCreate(
                        preventive_indent_detils_page_controller
                            .service_indent_header_list[0].indentNo!);
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
  }
*/

  Widget bindItemNoDropDown(context, String flag) {
    return Autocomplete<PreventiveItemNoResponse>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return preventive_indent_detils_page_controller.item_no_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return preventive_indent_detils_page_controller.item_no_list.value
            .where((PreventiveItemNoResponse option) {
          return option.itemCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PreventiveItemNoResponse selection) {
        print(selection.itemCode);
        preventive_indent_detils_page_controller.item_no_controller.text =
            _displayItemNoForOption(selection).toString();
        preventive_indent_detils_page_controller.item_no = selection.itemCode!;
        preventive_indent_detils_page_controller.is_warrenty =selection.isWarranty!;
        preventive_indent_detils_page_controller.unit_price_controller.text=selection.costPerUnit.toString()!;
        preventive_indent_detils_page_controller.item_no_description_controller.text =
        selection.displayName!;
        if(preventive_indent_detils_page_controller.is_warrenty>0){
          preventive_indent_detils_page_controller.discount_controller.text="100";

        }
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: flag=="View"?true:false,
          enabled:flag=="View"?false:true,
          onChanged: (value) {
            if (value.isEmpty) {
              preventive_indent_detils_page_controller.item_no_description_controller
                  .clear();
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = preventive_indent_detils_page_controller.item_no_controller.text,
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
          AutocompleteOnSelected<PreventiveItemNoResponse> onSelected,
          Iterable<PreventiveItemNoResponse> suggestions) {
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
                  final PreventiveItemNoResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
    double remaining_qty=   preventive_indent_detils_page_controller
        .service_indent_header_list[0].lines![index].qtyIssueFromNav!;
    preventive_indent_detils_page_controller.remain_quantity_controller.text=remaining_qty.toString();
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
                'Total Appr Qty.  (  ${preventive_indent_detils_page_controller
                    .service_indent_header_list[0].lines![index].qtyIssueFromNav}  ) ',
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
                    double bad_qty=double.parse(preventive_indent_detils_page_controller.bad_quantity_controller.text=="" ?'0':preventive_indent_detils_page_controller.bad_quantity_controller.text);
                    double remaining_qty=preventive_indent_detils_page_controller
                        .service_indent_header_list[0].lines![index].qtyIssueFromNav!-(consume_qty+bad_qty);
                    preventive_indent_detils_page_controller.remain_quantity_controller.text=remaining_qty.toString();
                  },
                  controller: preventive_indent_detils_page_controller
                      .consumer_quantity_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Consumer Qty ",
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
                  preventive_indent_detils_page_controller.bad_quantity_controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double bad_qty=double.parse( (value=="")?"0":value);
                    double consume_qty=double.parse(preventive_indent_detils_page_controller.consumer_quantity_controller.text=="" ?'0':preventive_indent_detils_page_controller.consumer_quantity_controller.text);
                    double remaining_qty=preventive_indent_detils_page_controller
                        .service_indent_header_list[0].lines![index].qtyIssueFromNav!-(consume_qty+bad_qty);
                    preventive_indent_detils_page_controller.remain_quantity_controller.text=remaining_qty.toString();
                  },
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
                  controller: preventive_indent_detils_page_controller
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
                    preventive_indent_detils_page_controller.IndentConsumerLineApi(
                        preventive_indent_detils_page_controller
                            .service_indent_header_list[0].indentNo!,
                        preventive_indent_detils_page_controller
                            .service_indent_header_list[0]
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


  void showAddLineBottomSheet(BuildContext context, Lines? lines, String flag) {
    RxDouble sub_total=0.0.obs;
    RxDouble discount_amount=0.0.obs;
    RxDouble total_amount=0.0.obs;
    if(flag=="View"){
      preventive_indent_detils_page_controller.isCheckBox.value=lines!.isCustomerDamage!>1?true:false;
      preventive_indent_detils_page_controller .item_no_controller.text=lines!.itemNo!;
      preventive_indent_detils_page_controller  .item_no_description_controller.text=lines.itemName!;
      preventive_indent_detils_page_controller  .quantity_controller.text=lines.qty.toString();
      preventive_indent_detils_page_controller.discount_controller.text=lines.discountPer.toString();
      preventive_indent_detils_page_controller.unit_price_controller.text=lines.unitPrice.toString();
      sub_total.value=lines.subTotal!;
      discount_amount.value=lines.discountAmount!;
      total_amount.value=lines.totalPrice!;
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
                          controller: preventive_indent_detils_page_controller.item_no_description_controller,
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
                            double currentQty =  double.parse((preventive_indent_detils_page_controller.quantity_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.quantity_controller.text);
                            double current_unitPrice = double.parse((preventive_indent_detils_page_controller.unit_price_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.unit_price_controller.text);
                            double current_discount_per = double.parse((preventive_indent_detils_page_controller.discount_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.discount_controller.text);
                            sub_total.value = currentQty * current_unitPrice;
                            discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                            total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                          },
                          controller:
                          preventive_indent_detils_page_controller.quantity_controller,
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
                              preventive_indent_detils_page_controller.isCheckBox.value,
                              onChanged: (value) {
                                if(flag=="View"){
                                  return null;
                                }
                                preventive_indent_detils_page_controller.isCheckBox.value =
                                    value ?? false;
                                if(preventive_indent_detils_page_controller.isCheckBox.value){
                                  preventive_indent_detils_page_controller. discount_controller.text="0";
                                }else{
                                  preventive_indent_detils_page_controller. discount_controller.text="";
                                }
                                if(preventive_indent_detils_page_controller.is_warrenty>0 && !preventive_indent_detils_page_controller.isCheckBox.value){
                                  preventive_indent_detils_page_controller.discount_controller.text="100";

                                }
                                // print(
                                //     "Checkbox value: ${preventive_indent_detils_page_controller.isCheckBox.value}");
                                double currentQty =  double.parse((preventive_indent_detils_page_controller.quantity_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.quantity_controller.text);
                                double current_unitPrice = double.parse((preventive_indent_detils_page_controller.unit_price_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.unit_price_controller.text);
                                double current_discount_per = double.parse((preventive_indent_detils_page_controller.discount_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.discount_controller.text);
                                sub_total.value = currentQty * current_unitPrice;
                                discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                                total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);

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
                        Obx(() {
                          return  TextFormField(
                            onChanged: (value) {
                              double currentQty =  double.parse((preventive_indent_detils_page_controller.quantity_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.quantity_controller.text);
                              double current_unitPrice = double.parse((preventive_indent_detils_page_controller.unit_price_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.unit_price_controller.text);
                              double current_discount_per = double.parse((preventive_indent_detils_page_controller.discount_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.discount_controller.text);
                              sub_total.value = currentQty * current_unitPrice;
                              discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                              total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                            },
                            readOnly: preventive_indent_detils_page_controller.isCheckBox.value==true || flag=="View"?true:false,
                            controller:  preventive_indent_detils_page_controller.discount_controller,
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
                        TextFormField(
                          readOnly: flag=="View"?true:false,
                          onChanged: (value) {
                            double currentQty =  double.parse((preventive_indent_detils_page_controller.quantity_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.quantity_controller.text);
                            double current_unitPrice = double.parse((preventive_indent_detils_page_controller.unit_price_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.unit_price_controller.text);
                            double current_discount_per = double.parse((preventive_indent_detils_page_controller.discount_controller.text.isEmpty) ? "0" : preventive_indent_detils_page_controller.discount_controller.text);
                            sub_total.value = currentQty * current_unitPrice;
                            discount_amount.value = currentQty * current_unitPrice*current_discount_per/100;
                            total_amount.value = (currentQty * current_unitPrice)-(currentQty * current_unitPrice*current_discount_per/100);
                          },
                          controller:
                          preventive_indent_detils_page_controller.unit_price_controller,
                          keyboardType: TextInputType.number,
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
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Text("Discount:",style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Spacer(),

                                    Obx(() {
                                      return Text(discount_amount.value.toStringAsFixed(2),style: GoogleFonts.poppins(
                                        color: AllColors.textColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w500,
                                      ),);
                                    },
                                      //child:
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3,),
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
                            preventive_indent_detils_page_controller.IndentLineCreate(
                                preventive_indent_detils_page_controller
                                    .service_indent_header_list[0].indentNo!,context);
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
          return preventive_indent_detils_page_controller.indent_type_list;
        }
        return preventive_indent_detils_page_controller.indent_type_list;
      },
      onSelected: (String selection) {
        print(selection);
        preventive_indent_detils_page_controller.indent_type_controller.text =
            _displayIndentTypeForOption(selection).toString();

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = preventive_indent_detils_page_controller.indent_type_controller.text,
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


}