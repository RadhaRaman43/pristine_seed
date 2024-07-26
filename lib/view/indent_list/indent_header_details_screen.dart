import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/indent_list_vm/indent_list_vm.dart';
import '../custom_drawer.dart';

class IndentHeaderDetailsScreen extends StatelessWidget{
  IndentHeaderDetailsScreen({super.key});
  Size size= Get.size;

  final indent_details_page_controller=Get.put(IndentListViewModel());

  @override
  Widget build(BuildContext context) {
    print(indent_details_page_controller.indent_header_details_list[0]
        .indentType );
   return WillPopScope(
     onWillPop: () async  {
       Get.offAllNamed(RoutesName.indentListscreen);
       return false;
     },
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: AllColors.primaryDark1,
         iconTheme: IconThemeData(
           color: AllColors.whiteColor,
         ),
         title: Text(
           'Indent View',
           style: GoogleFonts.poppins(
             color: AllColors.whiteColor,
             fontSize: AllFontSize.twentee,
             fontWeight: FontWeight.w700,
           ),
         ),
       ),
       drawer:  CustomDrawer(),
       body: Container(
         //padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Obx(
                   () {
                 return Container(
                   margin: EdgeInsets.only(top: 0.3),
                   child: Visibility(
                     visible: indent_details_page_controller.loading.value,
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
                         indent_details_page_controller.indent_header_details_list[0]
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
                         indent_details_page_controller.indent_header_details_list[
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
                         indent_details_page_controller.indent_header_details_list[
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
                             indent_details_page_controller.indent_header_details_list[
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
                         indent_details_page_controller.indent_header_details_list
                             .isNotEmpty
                             ? indent_details_page_controller.indent_header_details_list[
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


                 ],
               ),
             ),

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
        indent_details_page_controller.indent_header_details_list;
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

      },
      child: ListTile(
        title: Row(
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
            Container(
              width: size.width * .67,
              child: Tooltip(
                message:  indent_details_page_controller.indent_header_details_list[0]
                    .lines![index]
                    .itemName
                    .toString() +
                    "(" +
                    indent_details_page_controller.indent_header_details_list[0]
                        .lines![index]
                        .itemNo
                        .toString(),
                child: Text(
                  indent_details_page_controller.indent_header_details_list[0]
                      .lines![index]
                      .itemName
                      .toString() +
                      "(" +
                      indent_details_page_controller.indent_header_details_list[0]
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

          ],
        ),
        subtitle: Container(
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(1.9),
              1: FlexColumnWidth(1.3),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.1),
              //3: FlexColumnWidth(0.8),
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
                    indent_details_page_controller.indent_header_details_list[0]
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
                    indent_details_page_controller.indent_header_details_list[0]
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
                    indent_details_page_controller.indent_header_details_list[0]
                        .lines![index]
                        .discountAmount
                        .toString(),
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
                    indent_details_page_controller.indent_header_details_list[0]
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
                    indent_details_page_controller.indent_header_details_list[0]
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
                    indent_details_page_controller.indent_header_details_list[0]
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


}