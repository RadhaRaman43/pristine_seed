import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/component/custome_confirm_dialog.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/return_indent_model/return_indent_name_item_model.dart';
import '../../reources/routes/routes_name.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.returnHeaderDetailsScreen);

        print(return_indent_add_line_controller.return_create_header_list[0].returnNo) ;
        return_indent_add_line_controller.ReturnIndentHeaderCreate("back");
        return false;
      },
      child: Scaffold(
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
         //   padding: EdgeInsets.all(10),
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
            Obx(() {
              return  Visibility(
                  visible:return_indent_add_line_controller.is_show_indent_dropDown.value && return_indent_add_line_controller
                      .return_create_header_list[0].isDone!>0?false:true ,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: bindIndentReturnDropDown(context),
                  ));
            },
            ),
            Obx(() {
              return Visibility(
                visible: return_indent_add_line_controller.selected_item_check.value ,
               // visible:true,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0,right: 8.0),
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox(width: 3,),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
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
                              keyboardType: TextInputType.number,
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
                                FocusScope.of(context).unfocus();
                                return_indent_add_line_controller.returnIndentAddLineApiHit(return_indent_add_line_controller.return_create_header_list[0].returnNo.toString(),return_indent_add_line_controller.selected_indent_data!.itemNo!,"Add");

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
                                return_indent_add_line_controller.is_show_indent_dropDown.value=false;
                                return_indent_add_line_controller.is_show_indent_dropDown.value=true;
                                return_indent_add_line_controller.selected_item_check.value=false;
                                return_indent_add_line_controller.selected_indent_data=null;
                                return_indent_add_line_controller.indent_name_controller.clear();
                                return_indent_add_line_controller.bad_qty_controller.clear();
                                return_indent_add_line_controller.unused_qty_controller.clear();
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
            },),
            SizedBox(height: size.height*.03,),

            Obx(() {

              return  Visibility(
              visible: return_indent_add_line_controller.indent_return_add_line_list.length>0 && return_indent_add_line_controller
                  .return_create_header_list[0].isDone==0?true:false,
                child: Container(
                  child: Column(
                    children: [
                      Divider( height: 0.5,color: AllColors.primaryDark1,),
                          Container(
                            padding: EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              children: [
                                Text("Indent Line Details:", style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700,
                                ),),

                                Spacer(),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      AllColors.textColor2,
                                      side: BorderSide(
                                          color: AllColors
                                              .redColor,
                                          width: 1)),
                                  onPressed: () {

                                    CustomConfirmDialog.showDialog(context: context, title: "Delete", content: "Do you want to Continue?", onPress: (){

                                      return_indent_add_line_controller.returnIndentLineDeleteApiHit(return_indent_add_line_controller.return_create_header_list[0].returnNo.toString(),null,return_indent_add_line_controller.indent_return_add_line_list[0].itemNo.toString());

                                        }, isLoading: return_indent_add_line_controller.loading,
                                    );
                                   // return_indent_add_line_controller.returnIndentLineDeleteApiHit(return_indent_add_line_controller.return_create_header_list[0].returnNo.toString(),null,return_indent_add_line_controller.indent_return_add_line_list[0].itemNo.toString());
                                  },
                                  icon: Icon(Icons.delete,color: AllColors.redColor,),
                                  label: Container(
                                    child: Tooltip(
                                      message: "Discard All Line",
                                      child: Text(
                                        "Discard",
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
                            )
                          // child:
                        ),

                      Divider( height: 0.5,color: AllColors.primaryDark1,),
                    ],
                  ),
                ),
              );
            },),
           SizedBox(height: size.height*.02,),
           Obx(() =>  bindListView(context),)
          ],
        ),
      )),
    );
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
        return_indent_add_line_controller.selected_indent_data=selection;
        return_indent_add_line_controller.selected_item_check.value=true;
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
                      child: Text("${option.indentNo.toString()+"("+option.itemNo.toString()+")"+"(${option.totalQty.toString()})"}",
                        overflow: TextOverflow.ellipsis,
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
    if(return_indent_add_line_controller.indent_return_add_line_list!=null &&
        return_indent_add_line_controller.indent_return_add_line_list.isNotEmpty &&
        return_indent_add_line_controller.indent_return_add_line_list.length>0){
      return Expanded(
        child: ListView.separated(itemBuilder: (context, index) {
          return bindReturnIndentLine(context,index);

        }, separatorBuilder: (context, index) {
          return Divider(height:0.5,color: AllColors.grayColor,);

        }, itemCount: return_indent_add_line_controller.indent_return_add_line_list.length),
      );
    }else{
      return  Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );
    }
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
                Text(
                  "${return_indent_add_line_controller.indent_return_add_line_list[index].displayName ?? ""} (${return_indent_add_line_controller.indent_return_add_line_list[index].itemNo ?? ""})",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.sisxteen, // Ensure this constant is correctly named
                  ),
                ),


                Spacer(),
                Obx(  () {
                  return Visibility(
                    visible: return_indent_add_line_controller
                        .return_create_header_list[0].isDone!>0?false:true,
                    child: InkWell(
                        onTap: () {
                          return_indent_add_line_controller.returnIndentLineDeleteApiHit(return_indent_add_line_controller.return_create_header_list[0].returnNo.toString(),return_indent_add_line_controller.indent_return_add_line_list[index].lineNo.toString(),return_indent_add_line_controller.indent_return_add_line_list[index].itemNo.toString());
                        },
                        child: Tooltip(
                          message: "Delete Line",
                            child: Icon(Icons.delete,color: AllColors.redColor,))),
                  );
                },

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
