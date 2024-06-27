import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/return_indent_model/return_indent_name_item_model.dart';
import '../../viewModel/return_indent_vm/return_indent_vm.dart';
import '../custom_drawer.dart';

class ReturnIndentAddLine extends StatelessWidget {
  ReturnIndentAddLine({super.key});

  final return_indent_add_line_controller = Get.put(ReturnIndentViewModel());
  Size size = Get.size;
  static String _displayLocationNameForOption(IndentItemResponse option) =>
      option.indentNo!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Indent',
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
          padding: EdgeInsets.all(10),
      width: double.infinity,
      height: size.height,
      child: Column(

        children: [
          Obx(
            () {
              return Container(
                margin: EdgeInsets.only(top: 0.3),
                child: Visibility(
                  visible: return_indent_add_line_controller.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.textColor,
                    color: AllColors.primaryDark1,
                  ),
                ),
              );
            },
          ),
          bindIndentReturnDropDown(context),
          Obx(() {
            return Visibility(
              visible:return_indent_add_line_controller.is_show_indent_qty.value,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: 3,),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              return_indent_add_line_controller.unused_qty_controller.text=value;
                            },
                            controller:return_indent_add_line_controller.unused_qty_controller ,
                            decoration: InputDecoration(
                                labelText: "Enter Unused Qty",
                                labelStyle: TextStyle(color: AllColors.primaryDark1),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AllColors.primaryDark1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AllColors.primaryDark1))),
                          ),
                        ),
                        SizedBox(width: size.width*.1,),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              return_indent_add_line_controller.bad_qty_controller.text=value;
                            },
                            controller: return_indent_add_line_controller.bad_qty_controller,
                            decoration: InputDecoration(
                                labelText: "Enter Bad Qty",
                                labelStyle: TextStyle(color: AllColors.primaryDark1),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AllColors.primaryDark1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AllColors.primaryDark1))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height*.02,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AllColors.textColor2,
                                side: BorderSide(
                                    color: AllColors
                                        .primaryDark1,
                                    width: 1)),
                            onPressed: () {
                              return_indent_add_line_controller.returnIndentAddLineApiHit(return_indent_add_line_controller.return_create_header_list[0].returnNo.toString(),return_indent_add_line_controller.item_no,"Add");

                            },
                            icon: Icon(Icons.save,color: AllColors.primaryDark1,),
                            label: Container(
                              child: Tooltip(
                                message: "Save",
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            //  child:
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AllColors.textColor2,
                                side: BorderSide(
                                    color: AllColors
                                        .primaryDark1,
                                    width: 1)),
                            onPressed: () {

                            },
                            icon: Icon(Icons.clear,color: AllColors.primaryDark1,),
                            label: Container(
                              child: Tooltip(
                                message: "Clear",
                                child: Text(
                                  "Clear",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            //  child:
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },

          ),

         SizedBox(height: size.height*.02,),

         Obx(() =>  bindListView(context),)



        ],
      ),
    ));
  }

  Widget bindIndentReturnDropDown(context) {
    return Autocomplete<IndentItemResponse>(
      displayStringForOption: _displayLocationNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return return_indent_add_line_controller.indent_name_list.value;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return return_indent_add_line_controller.indent_name_list.value
            .where((IndentItemResponse option) {
          return option.indentNo!
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (IndentItemResponse selection) {
        print(selection.indentNo);
        return_indent_add_line_controller.indent_name_controller.text =
            _displayLocationNameForOption(selection).toString();
        return_indent_add_line_controller.bad_qty_controller.text=selection.badQty.toString();
        return_indent_add_line_controller.unused_qty_controller.text=selection.unusedQty.toString();
        return_indent_add_line_controller.indent_no=selection.indentNo!;
        return_indent_add_line_controller.indent_line_no=selection.lineNo.toString()!;
        return_indent_add_line_controller.item_no=selection.itemNo!;
        return_indent_add_line_controller.return_unused_qty=selection.unusedQty.toString()!;
        return_indent_add_line_controller.return_damage_qty=selection.badQty.toString()!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              return_indent_add_line_controller.indent_name_controller.clear();
            }
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = return_indent_add_line_controller.indent_name_controller.text ,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Indent',
            labelText: 'Select Indent',
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
          AutocompleteOnSelected<IndentItemResponse> onSelected,
          Iterable<IndentItemResponse> suggestions) {
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
                  final IndentItemResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        option.indentNo.toString(),
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

  bindListView(BuildContext context) {
    return Expanded(
      child: ListView.separated(itemBuilder: (context, index) {
        return bindReturnIndentLine(context,index);
      
      }, separatorBuilder: (context, index) {
        return Divider(height:0.5,color: AllColors.grayColor,);
      
      }, itemCount: return_indent_add_line_controller.indent_return_add_line_list.length),
    );
  }
  bindReturnIndentLine(BuildContext context, int index) {
    return Container(
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Text("Item No.",style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize
                        .sisxteen // Change the text color here
                ),),
               SizedBox(width: size.width*.03,),
                Text( return_indent_add_line_controller.indent_return_add_line_list[index].itemNo.toString() ,
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.sisxteen // Change the text color here
                ),
                ),

              ],
            )
          ],

        ),
        subtitle: Table(
          columnWidths: {
            0:FlexColumnWidth(2.5),
            1:FlexColumnWidth(1),
            2:FlexColumnWidth(1.8),
            3:FlexColumnWidth(1.8),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("Line No.",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.fourtine // Change the text color here
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].lineNo.toString(),
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: AllFontSize.fourtine // Change the text color here
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("Indent No.",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.fourtine // Change the text color here
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].indentNo.toString(),
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: AllFontSize.fourtine // Change the text color here
                    ),),
                )

              ]
            ),
            TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Indent Line No.",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].indentLineNo.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Used Qty.",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].returnUnusedQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  )

                ]
            ),
            TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Return bad Qty.",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].returnBadQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Total Qty.",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(return_indent_add_line_controller.indent_return_add_line_list[index].returnTotalQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine // Change the text color here
                      ),),
                  )

                ]
            )
          ],
        ),
      ),
    );


  }
}
