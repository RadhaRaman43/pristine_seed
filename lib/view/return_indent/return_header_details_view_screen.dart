import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/return_indent_vm/return_indent_vm.dart';

import '../../component/custome_confirm_dialog.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../custom_drawer.dart';

class ReturnHeaderDetailsScreen extends StatelessWidget {
  ReturnHeaderDetailsScreen({super.key});

  final return_header_details_controller = Get.put(ReturnIndentViewModel());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.returnIndentScreen);

       // return_header_details_controller.ReturnIndentHeaderCreate()
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Return Indent View',
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
          child: Column(
            children: [
              Obx(
                () {
                  return Container(
                    margin: EdgeInsets.only(top: 0.3),
                    child: Visibility(
                      visible: return_header_details_controller.loading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.textColor,
                        color: AllColors.primaryDark1,
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 5.0,
                ),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 1.0,
                    offset: Offset(0.55, 0.55),
                  )
                ], color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Return No',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          return_header_details_controller
                                  .return_create_header_list[0].returnNo ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
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
                          'Location',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          return_header_details_controller
                                  .return_create_header_list[0].locationCode ??
                              "",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
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
                          'Status',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          return_header_details_controller
                                      .return_create_header_list[0].isDone ==
                                  0
                              ? "Pending"
                              : "Completed",
                          style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
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
                            CustomConfirmDialog.showDialog(
                              context: context,
                              title: "Complete",
                              content: "Do you want to Continue?",
                              onPress: () {
                                return_header_details_controller.returnIndentHeaderCompleteApiHit(return_header_details_controller
                                    .return_create_header_list[0].returnNo.toString());
                                // Your onPress function
                              },
                              isLoading: return_header_details_controller.loading,
                            );

                          },
                          icon: Icon(Icons.check,color: AllColors.primaryDark1,),
                          label: Container(
                            child: Tooltip(
                              message: "Complete",
                              child: Text(
                                "Complete",
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
                                      .redColor,
                                  width: 1)),
                          onPressed: () {

                            CustomConfirmDialog.showDialog(context: context, title: "Header Delete",
                              content: "Do you want to Continue?",
                              onPress: () {
                              return_header_details_controller.returnIndentHeaderDeleteApiHit(return_header_details_controller
                                  .return_create_header_list[0].returnNo.toString());

                            }, isLoading: return_header_details_controller.loading,);



                          },
                          icon: Icon(Icons.delete,color: AllColors.redColor,),
                          label: Container(
                            child: Tooltip(
                              message: "Header Delete",
                              child: Text(
                                " Header Delete",
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

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.5),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 1.0,
                    offset: Offset(0.55, 0.55),
                  )
                ], color: Colors.white),
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  // /top: 5.0,
                ),
                child: Row(
                  children: [
                    Text("Line Details :",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        )),

                  ],
                ),
              ),
                 Obx(() =>  bindListView(context),)



            ],
          ),
        ),
      ),
    );
  }

  bindListView(BuildContext context) {
    if(return_header_details_controller
        .return_create_header_list[0].lines!.isNotEmpty && return_header_details_controller
        .return_create_header_list[0].lines!=null && return_header_details_controller
        .return_create_header_list[0].lines!.length>0){
      return Expanded(
        child: ListView.separated(itemBuilder: (context, index) {
          return BindReturnLineView(context,index);
        }, separatorBuilder: (context, index) {
          return Divider(height: 0.5,color: AllColors.primaryDark1,);
        }, itemCount: return_header_details_controller
            .return_create_header_list[0].lines!.length),
      );
    }else{
      return Container(
        child: Center(
          child: Text(""),
        ),
      );

    }

  }

  BindReturnLineView(BuildContext context, int index){
    return Container(
      child: ListTile(
        title: Row(
          children: [
            Text("Item No:",style:  GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(width:size.width*.1,),
            Text( return_header_details_controller
                .return_create_header_list[0].lines![index].itemNo??"",
              style: GoogleFonts.poppins(
              color: AllColors.textColor,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500,
            ),),
            Spacer(),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                      onTap: () {
                        return_header_details_controller.getIndentItemName(return_header_details_controller
                            .return_create_header_list[0].returnNo.toString(),return_header_details_controller
                            .return_create_header_list[0].lines![index].itemNo.toString());

                        return_header_details_controller.returnIndentAddLineApiHit(return_header_details_controller
                            .return_create_header_list[0].lines![index].returnNo.toString(),return_header_details_controller
                            .return_create_header_list[0].lines![index].itemNo.toString(),"InIt");


                      },
                      child: Icon(Icons.remove_red_eye,color: AllColors.primaryDark1,)),
                ),

              ],
            ),




          ],
        ),
        subtitle: Table(
          columnWidths: {
            0:FlexColumnWidth(1.8),
            1:FlexColumnWidth(1.3),
            2:FlexColumnWidth(1.8),
            3:FlexColumnWidth(1.3),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Qty.",
                    style:  GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Tooltip(
                    message: "Good: ${return_header_details_controller
                        .return_create_header_list[0].lines![index].unusedQty.toString()} Bad:${return_header_details_controller
                        .return_create_header_list[0].lines![index].damageQty.toString()}",
                    child: Text(return_header_details_controller
                        .return_create_header_list[0].lines![index].totalQty.toString(),
                      style:  GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Return Qty.",
                    style:  GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Tooltip(
                    message: "Good: ${return_header_details_controller
                        .return_create_header_list[0].lines![index].returnUnusedQty.toString()} Bad:${return_header_details_controller
                        .return_create_header_list[0].lines![index].returnDamageQty.toString()}",
                    child: Text(return_header_details_controller
                        .return_create_header_list[0].lines![index].totalReturnQty.toString(),
                      style:  GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                      ),),
                  ),
                ),
              ]
            ),

          ],
        ),

      ),
    );




  }

  void showConfirmCompleteDialog(BuildContext context) {

  }
}
