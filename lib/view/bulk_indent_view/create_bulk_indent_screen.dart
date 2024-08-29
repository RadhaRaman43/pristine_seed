import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/bulk_indent_model/bulk_header_create_model.dart';
import '../../models/bulk_indent_model/bulk_item_master_model.dart';
import '../../models/serviceIndentModel/Item_no_model.dart';
import '../../utils/app_utils.dart';
import '../../viewModel/bulk_indent_Vm/bulk_indent_vm.dart';
import '../custom_drawer.dart';

class CreateBulkIndentScreen extends StatelessWidget{
  CreateBulkIndentScreen({super.key});
  
  final create_bulk_controller=Get.put(BulkIndentViewModel());

  Size size= Get.size;


  static String _displayItemNoForOption(BulkItemMasterGetModel option) =>
      option.itemCode!;

  static String _displayIndentTypeForOption(String option) => option!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,
        ),
        title: Row(
          children: [
            Text(
              'Create Bulk Indent',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: Column(
          children: [
            Obx(
                  () {
                return Visibility(
                  visible: create_bulk_controller
                      .is_indent_type_dropDown.value,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        //crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          bindIndentDropDropDown(context),
                          SizedBox(
                            height: 10,
                          ),
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
                              create_bulk_controller.BulkHeaderCreateApi("");
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
                      )),
                );
              },
            ),
            Obx(
                  () {
                if (create_bulk_controller
                    . bulk_indent_header_create_list !=
                    null &&
                    create_bulk_controller
                        . bulk_indent_header_create_list.isNotEmpty &&
                    create_bulk_controller
                        . bulk_indent_header_create_list.length >
                        0) {
                  return Visibility(
                    visible:
                    create_bulk_controller.is_Showindent.value,
                    child: Container(
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              //    height: size.height * .16,
                              decoration:
                              BoxDecoration(boxShadow: <BoxShadow>[
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
                                        "Indent Type ",
                                        style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        create_bulk_controller
                                            . bulk_indent_header_create_list[
                                        0]
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
                                        create_bulk_controller
                                            . bulk_indent_header_create_list[
                                        0]
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
                                        create_bulk_controller
                                            . bulk_indent_header_create_list[
                                        0]
                                            .serviceNo ??
                                            "",
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
                                            create_bulk_controller
                                                . bulk_indent_header_create_list![
                                            0]
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

                                  /*Obx(
                                      () {
                                        return Visibility(
                                          visible: indent_deatils_page_controller
                                              .service_indent_header_list.isNotEmpty &&  indent_deatils_page_controller
                                                      .service_indent_header_list[
                                                          0]
                                                      .indentStatus ==
                                                  "Ready For Consumption" || indent_deatils_page_controller
                                              .service_indent_header_list.isNotEmpty &&   indent_deatils_page_controller
                                              .service_indent_header_list[
                                          0]
                                              .indentStatus =="Received"
                                              ? true
                                              : false,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Location",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                indent_deatils_page_controller
                                                        .service_indent_header_list![
                                                            0]
                                                        .locationCode ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  color: AllColors.textColor,
                                                  fontSize:
                                                      AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),*/

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
                                        create_bulk_controller
                                            . bulk_indent_header_create_list
                                            .isNotEmpty
                                            ? create_bulk_controller
                                            . bulk_indent_header_create_list[
                                        0]
                                            .locationCode ??
                                            ""
                                            : "",
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
                                        // Check if the list is not empty before accessing its elements
                                        bool isVisible = indent_deatils_page_controller
                                            .service_indent_header_list.isNotEmpty &&
                                            (indent_deatils_page_controller
                                                .service_indent_header_list[0].indentStatus ==
                                                "Ready For Consumption" ||
                                                indent_deatils_page_controller
                                                    .service_indent_header_list[0].indentStatus == "Received");

                                        return Visibility(
                                          visible: isVisible,
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
                                                    .service_indent_header_list.isNotEmpty
                                                    ? indent_deatils_page_controller
                                                    .service_indent_header_list[0].locationCode ??
                                                    ""
                                                    : "",
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
                                            visible: create_bulk_controller
                                                . bulk_indent_header_create_list[
                                            0]
                                                .indentStatus ==
                                                "Ready For Consumption"
                                                ? true
                                                : false,
                                            child: Container(
                                              width: size.width * 0.4,
                                              child: ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                    AllColors
                                                        .lightgreyColor,
                                                    backgroundColor:
                                                    AllColors
                                                        .whiteColor,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      side: BorderSide(
                                                          color: AllColors
                                                              .primaryDark,
                                                          width: 1),
                                                    )),
                                                onPressed: () {

                                                 /* create_bulk_controller
                                                      .IndentConsumerHeaderMarkApi(
                                                      create_bulk_controller
                                                          . bulk_indent_header_create_list[
                                                      0]
                                                          .indentNo!);*/
                                                },
                                                child: Text(
                                                  'Consume',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      fontSize: AllFontSize
                                                          .sisxteen,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Obx(
                                            () {
                                          return Visibility(
                                            visible:
                                            create_bulk_controller
                                                . bulk_indent_header_create_list[
                                            0]
                                                .indentStatus ==
                                                "Pending"
                                                ? true
                                                : false,
                                            child: Container(
                                              width: size.width * 0.4,
                                              child: ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                    AllColors
                                                        .lightgreyColor,
                                                    backgroundColor:
                                                    AllColors
                                                        .whiteColor,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15),
                                                      side: BorderSide(
                                                          color: AllColors
                                                              .primaryDark,
                                                          width: 1),
                                                    )),
                                                onPressed: () {
                                                  //RescheduleDateDialog(context);
                                                },
                                                child: Text(
                                                  'Complete',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors
                                                          .primaryDark1,
                                                      fontSize: AllFontSize
                                                          .sisxteen,
                                                      fontWeight:
                                                      FontWeight.w700),
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
                              decoration:
                              BoxDecoration(boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: Offset(0.0, 0.55),
                                  color: Colors.black54,
                                  blurRadius: 0.5,
                                )
                              ], color: Colors.white),
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
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
                                      final lines =
                                          create_bulk_controller
                                              . bulk_indent_header_create_list[
                                          0]
                                              .lines;

                                      // Check if lines is not null and has at least one element
                                      if (lines != null &&
                                          lines.isNotEmpty &&
                                          lines[0].lineNo == null) {
                                        return Visibility(
                                          visible: lines[0].lineNo == null,
                                          child: Obx(
                                                () {
                                              return Visibility(
                                                visible: create_bulk_controller
                                                    . bulk_indent_header_create_list[
                                                0]
                                                    .indentStatus ==
                                                    "Pending"
                                                    ? true
                                                    : false,
                                                child: Tooltip(
                                                  message: "Header Delete",
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: AllColors
                                                            .redColor),
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title:
                                                        "Header Delete",
                                                        titleStyle: TextStyle(
                                                          color: AllColors
                                                              .primaryDark1,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                        content: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              vertical:
                                                              15.0),
                                                          child: Text(
                                                            "Do you want to Delete?",
                                                            style: TextStyle(
                                                              color: AllColors
                                                                  .primaryDark1,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              fontSize:
                                                              AllFontSize
                                                                  .fourtine,
                                                            ),
                                                          ),
                                                        ),
                                                        confirm:
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                         /*
                                                            create_bulk_controller
                                                                .IndentHeaderLineDelete(
                                                              create_bulk_controller
                                                                  . bulk_indent_header_create_list[
                                                              0]
                                                                  .indentNo!,
                                                              lines[0]
                                                                  .lineNo
                                                                  .toString(),
                                                              "HeaderDiscard",
                                                            );*/

                                                          },
                                                          child: Text("Yes",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                        cancel:
                                                        OutlinedButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: AllColors
                                                                    .primaryDark1),
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
                                        visible: create_bulk_controller
                                            . bulk_indent_header_create_list[
                                        0]
                                            .indentStatus ==
                                            "Pending"
                                            ? true
                                            : false,
                                        child: Tooltip(
                                          message: "Add Line",
                                          child: IconButton(
                                            icon: Icon(Icons.add,
                                                color:
                                                AllColors.primaryDark1),
                                            onPressed: () {
                                             /* create_bulk_controller
                                                  .isCheckBox.value = false;
                                              create_bulk_controller
                                                  .getItemNo();
                                              create_bulk_controller
                                                  .item_no_controller
                                                  .clear();
                                              create_bulk_controller
                                                  .item_no_description_controller
                                                  .clear();
                                              create_bulk_controller
                                                  .quantity_controller
                                                  .clear();
                                              create_bulk_controller
                                                  .discount_controller
                                                  .clear();
                                              create_bulk_controller
                                                  .unit_price_controller
                                                  .clear();
                                              create_bulk_controller.item_price_controller.clear();
*/
                                              showAddLineBottomSheet(context, null, "");

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
                          //  Obx(() => bindList(context),)
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
            
            
            
          ],
        ),
      ),
    );
  }

  Widget bindIndentDropDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIndentTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return create_bulk_controller.indent_type_list;
        }
        return create_bulk_controller.indent_type_list;
      },
      onSelected: (String selection) {
        print(selection);
        create_bulk_controller.indent_type_controller.text =
            _displayIndentTypeForOption(selection).toString();

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = create_bulk_controller.indent_type_controller.text,
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



  void showAddLineBottomSheet(BuildContext context, Lines? lines, String flag) {
    RxDouble sub_total = 0.0.obs;
    RxDouble discount_amount = 0.0.obs;
    RxDouble total_amount = 0.0.obs;
    create_bulk_controller.discount_controller.text = "100";
    create_bulk_controller.paybal_amount_controller.text =
        total_amount.value.toString();
    if (flag == "View") {
      create_bulk_controller.isCheckBox.value =
      lines!.isCustomerDamage! > 0 ? true : false;
      create_bulk_controller.item_no_controller.text = lines!.itemNo!;
      create_bulk_controller.item_no_description_controller.text =
      lines!.itemName!;
      create_bulk_controller.quantity_controller.text =
          lines!.qty!.toString();
      create_bulk_controller.discount_controller.text =
          lines!.discountPer!.toString();
      ;
      create_bulk_controller.unit_price_controller.text =
          lines!.unitPrice!.toString();
      sub_total.value = lines!.subTotal!;
      discount_amount.value = lines!.discountAmount!;
      total_amount.value = lines!.totalPrice!;
      create_bulk_controller.paybal_amount_controller.text =
          total_amount.value.toString();
      create_bulk_controller.item_price_controller.text=lines.actualUnitPrice!.toString();
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
                      bindItemNoDropDown(context, flag),
                        TextFormField(
                          readOnly: true,
                          controller: create_bulk_controller
                              .item_no_description_controller,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Item Name",
                            labelStyle:
                            TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),

                        TextFormField(
                          readOnly: flag == "View" ? true : false,
                          onChanged: (value) {
                            double currentQty = double.parse(
                                (create_bulk_controller
                                    .quantity_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .quantity_controller.text);
                            double current_unitPrice = double.parse(
                                (create_bulk_controller
                                    .unit_price_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .unit_price_controller.text);
                            double current_discount_per = double.parse(
                                (create_bulk_controller
                                    .discount_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .discount_controller.text);

                            create_bulk_controller.unit_price_controller.text= (create_bulk_controller.unit_price-(create_bulk_controller.unit_price*current_discount_per/100)).toStringAsFixed(2);
                            current_unitPrice = double.parse((create_bulk_controller.unit_price_controller.text.isEmpty) ? "0" : create_bulk_controller.unit_price_controller.text);

                            sub_total.value = currentQty * create_bulk_controller.unit_price;

                            discount_amount.value =( currentQty *
                                create_bulk_controller.unit_price *
                                current_discount_per /
                                100).abs();

                            total_amount.value =(currentQty * current_unitPrice);

                            create_bulk_controller
                                .paybal_amount_controller
                                .text = total_amount.value.toString();

                          },
                          controller: create_bulk_controller
                              .quantity_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Quantity",
                            labelStyle:
                            TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Checkbox(
                              fillColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              focusColor: AllColors.primaryDark1,
                              checkColor: AllColors.primaryDark1,
                              value: create_bulk_controller
                                  .isCheckBox.value,
                              onChanged: (value) {
                                if (flag == "View") {
                                  return null;
                                }

                                create_bulk_controller
                                    .isCheckBox.value = value ?? false;
                                if (create_bulk_controller
                                    .isCheckBox.value) {
                                  create_bulk_controller
                                      .discount_controller.text = "0";
                                  //total_amount.value=0.0;
                                } else {
                                  create_bulk_controller
                                      .discount_controller.text = "100";
                                }
                                if (create_bulk_controller
                                    .is_warrenty >
                                    0 &&
                                    !create_bulk_controller
                                        .isCheckBox.value) {
                                  create_bulk_controller
                                      .discount_controller.text = "100";
                                }

                                double currentQty = double.parse(
                                    (create_bulk_controller
                                        .quantity_controller
                                        .text
                                        .isEmpty)
                                        ? "0"
                                        : create_bulk_controller
                                        .quantity_controller.text);
                                double current_unitPrice = double.parse(
                                    (create_bulk_controller
                                        .unit_price_controller
                                        .text
                                        .isEmpty)
                                        ? "0"
                                        : create_bulk_controller
                                        .unit_price_controller.text);
                                double current_discount_per = double.parse(
                                    (create_bulk_controller
                                        .discount_controller
                                        .text
                                        .isEmpty)
                                        ? "0"
                                        : create_bulk_controller
                                        .discount_controller.text);

                                create_bulk_controller.unit_price_controller.text= (create_bulk_controller.unit_price-(create_bulk_controller.unit_price*current_discount_per/100)).toStringAsFixed(2);

                                create_bulk_controller.discount_controller.text=current_discount_per.abs().toStringAsFixed(2);
                                sub_total.value = currentQty * create_bulk_controller.unit_price;

                                discount_amount.value = (currentQty *
                                    create_bulk_controller.unit_price *
                                    current_discount_per /
                                    100).abs();

                                //todo total amount change after customer damage comment code...

                                // total_amount.value =(currentQty * current_unitPrice);


                                //todo total amount change after customer damage...


                                total_amount.value =
                                    (currentQty *  create_bulk_controller.unit_price) -
                                        (currentQty *
                                            create_bulk_controller.unit_price *
                                            current_discount_per /
                                            100);

                                create_bulk_controller
                                    .paybal_amount_controller
                                    .text = total_amount.value.toString();
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
                          controller: create_bulk_controller
                              .item_price_controller,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Unit Price",
                            labelStyle:
                            TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),
                        // Obx(
                        // () {
                        // return
                        TextFormField(
                          onChanged: (value) {
                            double enteredDiscount =
                                double.tryParse(value) ?? 0;
                            if (enteredDiscount > 100) {
                              enteredDiscount = 100;
                              // Set the text to 100 if it's greater than 100
                              create_bulk_controller
                                  .discount_controller.text = "100";

                              Utils.showErrorToastification("Error!",
                                  "Discount % Cannot Be Greater Than 100");
                            }

                            double currentQty = double.parse(
                                (create_bulk_controller
                                    .quantity_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .quantity_controller.text);
                            double current_unitPrice = double.parse(
                                (create_bulk_controller
                                    .unit_price_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .unit_price_controller.text);
                            double current_discount_per = double.parse(
                                (create_bulk_controller
                                    .discount_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .discount_controller.text);

                            create_bulk_controller.unit_price_controller.text=(create_bulk_controller.unit_price-(create_bulk_controller.unit_price*current_discount_per/100)).abs().toStringAsFixed(2);
                            //    double current_discount_per = enteredDiscount;
                            sub_total.value = currentQty * create_bulk_controller.unit_price;



                            discount_amount.value =(currentQty *
                                create_bulk_controller.unit_price *
                                current_discount_per /
                                100).abs();

                            // total_amount.value =
                            //     (currentQty * current_unitPrice) -
                            //         (currentQty *
                            //             current_unitPrice *
                            //             current_discount_per /
                            //             100);

                            total_amount.value =
                                (currentQty * create_bulk_controller.unit_price) -
                                    (currentQty *
                                        create_bulk_controller.unit_price *
                                        current_discount_per /
                                        100);




                            create_bulk_controller
                                .paybal_amount_controller
                                .text = total_amount.value.toString();
                            //todo discount not grether 100....

                            // Check if entered discount is greater than 100
                          },
                          readOnly: /*indent_deatils_page_controller
                                              .isCheckBox.value ==
                                          true ||*/
                          flag == "View" ? true : false,
                          controller: create_bulk_controller
                              .discount_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Discount%",
                            labelStyle:
                            TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                          ),
                        ),
                        //  },
                        //  ),

                        TextFormField(
                          readOnly: flag == "View" ? true : false,
                          // enabled: false,
                          onChanged: (value) {
                            double currentQty = double.parse(
                                (create_bulk_controller
                                    .quantity_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .quantity_controller.text);
                            double current_unitPrice = double.parse(
                                (create_bulk_controller
                                    .unit_price_controller.text.isEmpty)
                                    ? "0"
                                    : create_bulk_controller
                                    .unit_price_controller.text);
                            double current_discount_per = ((create_bulk_controller.unit_price-current_unitPrice)*100/create_bulk_controller.unit_price);


                            if(current_unitPrice>create_bulk_controller.unit_price){
                              create_bulk_controller.unit_price_controller.text=create_bulk_controller.unit_price.abs().toStringAsFixed(2);
                              create_bulk_controller.discount_controller.text="0";
                              current_discount_per=0;
                              Utils.showErrorToastification("Message!", "Price After Discount Must be Lesser Unit price:${create_bulk_controller.unit_price.toStringAsFixed(2)}");
                            }

                            create_bulk_controller.discount_controller.text=current_discount_per.abs().toStringAsFixed(2);


                            sub_total.value = currentQty * create_bulk_controller.unit_price;

                            discount_amount.value = (currentQty *
                                create_bulk_controller.unit_price *
                                current_discount_per /
                                100).abs();

                            total_amount.value =(currentQty * current_unitPrice);



                            create_bulk_controller
                                .paybal_amount_controller
                                .text = total_amount.value.toString();
                          },
                          controller: create_bulk_controller.unit_price_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Price After Discount",
                            labelStyle:
                            TextStyle(color: AllColors.primaryDark1),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: AllColors.primaryDark1),
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
                                    Text(
                                      "Sub Total",
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
                                          sub_total.value.toStringAsFixed(2),
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
                                SizedBox(
                                  height: 3,
                                ),
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
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Payable Amount:",
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Visibility(
                          visible: flag == "View" ? false : true,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                  AllColors.primaryDark1,
                                ),
                              ),
                              onPressed: () {

                               /* create_bulk_controller.IndentLineCreate(
                                    create_bulk_controller
                                        .service_indent_header_create_list[0]
                                        .indentNo!,
                                    context);*/

                                //  Navigator.pop(context);
                                // todo  Your onPressed logic...
                              },
                              child: Visibility(
                                visible: flag == "View" ? false : true,
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

                            // child:

                          ),
                        ),
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





  Widget bindItemNoDropDown(context,String flag) {
    create_bulk_controller.item_no_list.value=[];
    return Autocomplete<BulkItemMasterGetModel>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return create_bulk_controller.item_no_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return await create_bulk_controller.getItemNo(textEditingValue.text);
      },
      onSelected: (BulkItemMasterGetModel selection) {
       // print(selection.reasonCode);
        create_bulk_controller.item_no_controller.text =
            _displayItemNoForOption(selection).toString();


        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: flag == "View" ? true : false,
          enabled: flag == "View" ? false : true,
          onChanged: (value) {
            if(value.isEmpty){
              FocusScope.of(context).unfocus();
            }
            create_bulk_controller.item_no_controller.text  = value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = create_bulk_controller.item_no_controller.text ,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Enter Reason Code.',
            labelText: 'Enter Reason Code',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
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
          AutocompleteOnSelected<BulkItemMasterGetModel> onSelected,
          Iterable<BulkItemMasterGetModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.grayColor1,
              width: size.width,
              height: size.height*.15,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final BulkItemMasterGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width:size.width*.1 ,
                        child: Tooltip(
                          message: option.itemCode.toString()+" (${option.displayName})" ,
                          child: Text(
                            option.itemCode.toString()+" (${option.displayName})",
                            style: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w300,
                                fontSize: AllFontSize.sisxteen // Change the text color here
                            ),
                          ),
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



  /*Widget bindItemNoDropDown(context, String flag) {
    return Autocomplete<ItemNoResponse>(
      displayStringForOption: _displayItemNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return create_bulk_controller.item_no_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return create_bulk_controller.item_no_list.value
            .where((ItemNoResponse option) {
          return option.itemCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()) || option.displayName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemNoResponse selection) {
        print(selection.itemCode);
        create_bulk_controller.item_no_controller.text =
            _displayItemNoForOption(selection).toString();
        create_bulk_controller.item_no = selection.itemCode!;
        create_bulk_controller.item_Qty = selection.componentQuantity!;
        create_bulk_controller.is_warrenty = selection.isWarranty!;
        create_bulk_controller.unit_price = selection.costPerUnit!;
        //  indent_deatils_page_controller.unit_price = selection.costPerUnit!;
        create_bulk_controller.item_price_controller.text=selection.costPerUnit!.toStringAsFixed(2);
        selection.costPerUnit.toString()!;
        create_bulk_controller.item_no_description_controller.text =
        selection.displayName!;
        if (create_bulk_controller.is_warrenty > 0) {
          create_bulk_controller.discount_controller.text = "100";
        }
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: flag == "View" ? true : false,
          enabled: flag == "View" ? false : true,
          onChanged: (value) {
            if (value.isEmpty) {
              create_bulk_controller.item_no_description_controller
                  .clear();
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = create_bulk_controller.item_no_controller.text,
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
              width: size.width,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * .8,
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
                        )),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }*/


}