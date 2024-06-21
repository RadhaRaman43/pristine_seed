import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/models/serviceIndentModel/Item_no_model.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/custom_drawer.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/installation_vm/installation_vm.dart';

class IndentHeaderViewScreen extends StatelessWidget {
  IndentHeaderViewScreen({super.key});

  final indent_deatils_page_controller = Get.put(InstallationViewModel());

  static String _displayItemNoForOption(ItemNoResponse option) =>
      option.itemCode!;

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        indent_deatils_page_controller.IndentHeaderListApi();
        Get.toNamed(RoutesName.installation_mark_visit);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Indent  Details',
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
                      visible: indent_deatils_page_controller.loading.value,
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
                              .service_indent_header_create_list[0].serviceNo!,
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
                        /*Obx(
                          () {
                            return Visibility(
                                visible: indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                                0]
                                            .indentStatus ==
                                        "Issued From Warehouse"
                                    ? true
                                    : false,
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
                        ),*/

                        Obx(
                          () {
                            return Visibility(
                              visible: indent_deatils_page_controller
                                          .service_indent_header_create_list[0]
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
                                    indent_deatils_page_controller
                                        .IndentConsumerHeaderMarkApi(
                                            indent_deatils_page_controller
                                                .service_indent_header_create_list[
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
                                    indent_deatils_page_controller.IndentComplete(
                                        indent_deatils_page_controller
                                            .service_indent_header_create_list[
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

                        /* Obx(() {
                          return Visibility(
                            visible: indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                                0]
                                            .indentStatus ==
                                        "Completed" ||
                                    indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                                0]
                                            .indentStatus ==
                                        "Issued From Warehouse" ||
                                    indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                                0]
                                            .indentStatus ==
                                        "Received" ||
                                    indent_deatils_page_controller
                                            .service_indent_header_create_list[
                                                0]
                                            .indentStatus ==
                                        "Rejected"
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
                        }),*/
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
                                addLineDialog(context);
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
              )
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
      onTap: () {},
      child: ListTile(
         title:  Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text(
               "Item :",
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
             ),
             Spacer(),
             Container(
               alignment: Alignment.centerRight,
               child: Row(
                 children: [
                   Obx(() =>Visibility(
                     visible: indent_deatils_page_controller
                         .service_indent_header_create_list[0]
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
                           size: 25,
                           Icons.delete,
                           color: AllColors.redColor,
                         )),
                   ), ),
                   Obx(() =>  Visibility(
                     visible: indent_deatils_page_controller
                         .service_indent_header_create_list[0]
                         .indentStatus ==
                         "Issued From Warehouse"
                         ? true
                         : false,
                     child: InkWell(
                         onTap: () {
                           print(indent_deatils_page_controller
                               .service_indent_header_create_list[0]
                               .lines![index]
                               .consumeQty);
                           //  indent_deatils_page_controller.consumer_quantity_controller.clear();
                           // indent_deatils_page_controller.bad_quantity_controller.clear();
                           indent_deatils_page_controller
                               .bad_quantity_controller.text =
                               indent_deatils_page_controller
                                   .service_indent_header_create_list[0]
                                   .lines![index]
                                   .badQty!
                                   .toString();
                           indent_deatils_page_controller
                               .consumer_quantity_controller.text ==
                               indent_deatils_page_controller
                                   .service_indent_header_create_list[0]
                                   .lines![index]
                                   .consumeQty
                                   .toString();
                           addConsumeDialog(context, index);
                         },
                         child: Image.asset(
                           "assests/images/view.png",
                           width: 23,
                           height: 23,
                         )
/*
                        Icon(
                        Icons.remove_red_eye,
                        //color: AllColors.bluegrayColor,
                      )*/
                     ),
                   ),)
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
                      "Qty.:",
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
                      "Appr. Qty.:",
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
                      "Consume Qty.:",
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
                      "Bad Qty.:",
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
            //height: size.height * .43,
            child: Column(
              mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.start,
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
                              indent_deatils_page_controller. discount_controller.text="";

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
        );
      },
    );
  }

  Widget bindItemNoDropDown(context) {
    return Autocomplete<ItemNoResponse>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return indent_deatils_page_controller.item_no_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return indent_deatils_page_controller.item_no_list.value
            .where((ItemNoResponse option) {
          return option.itemCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemNoResponse selection) {
        print(selection.itemCode);
        indent_deatils_page_controller.item_no_controller.text =
            _displayItemNoForOption(selection).toString();
        indent_deatils_page_controller.item_no = selection.itemCode!;
        indent_deatils_page_controller.item_no_description_controller.text =
            selection.displayName!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
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
          AutocompleteOnSelected<ItemNoResponse> onSelected,
          Iterable<ItemNoResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width * .6,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ItemNoResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          option.itemCode.toString() +
                              " (${option.displayName??""} )",
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize
                                  .
                              sisxteen // Change the text color here
                              ),

                        )),
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
                'Total Appr Qty.  (  ${indent_deatils_page_controller.service_indent_header_create_list[0].lines![index].qtyIssueFromNav}  ) ',
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
}
