import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';

import '../../../viewModel/service_managment_vm_directory/service_inventory_vm/service_inventory_vm.dart';
import '../../custom_drawer.dart';


class ServiceInventoryViewDetailsScreen extends StatelessWidget{
  ServiceInventoryViewDetailsScreen({super.key});
  final service_details_page_controller=Get.put(ServiceInventoryViewModel());
  Size size= Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.service_inventory_screen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title: Row(
            children: [
              Text(
                'Service Inventory View',
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
            Obx(() {
              return Container(
                margin: EdgeInsets.only(top: 0.3),
                child: Visibility(
                  visible: service_details_page_controller.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                ),
              );
            },
            ),

              bindListView(context),
          ],
        ),
        ),
      ),
    );

  }

  Widget bindListView(BuildContext context) {
    if(service_details_page_controller.service_inventory_details_list!=null &&
        service_details_page_controller.service_inventory_details_list.length>0
    && service_details_page_controller.service_inventory_details_list.isNotEmpty){
      return Expanded(
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return bindviewInventoryList(context,index);

            }, separatorBuilder: (context, index) {
          return Divider(height: 0.5,color: AllColors.primaryDark1,);

        }, itemCount: service_details_page_controller.service_inventory_details_list.length),
      );
    }else{
      return Center(
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );

    }


  }

  Widget bindviewInventoryList(BuildContext context, int index) {
    return Container(
      child: ListTile(
        title:   Column(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Indent No.:",
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width *0.05 ,
              ),
              Container(
                width: size.width*.48,
                child: Tooltip(
                  message:"${service_details_page_controller.service_inventory_details_list[index]
                      .indentNo??""} " ,
                  child: Text("${service_details_page_controller.service_inventory_details_list[index]
                      .indentNo??""}",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
                  ),

            Row(
              children: [
                Text(
                  "Item No.:",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width *0.1 ,
                ),

                Container(
                  width: size.width*.58,
                  child: Tooltip(
                    message:"${service_details_page_controller.service_inventory_details_list[index]
                        .itemName??""} (${service_details_page_controller.service_inventory_details_list[index]
                        .itemNo??""})" ,
                    child: Text("${service_details_page_controller.service_inventory_details_list[index]
                        .itemName??""} (${service_details_page_controller.service_inventory_details_list[index]
                        .itemNo??""})",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          ],
        ) ,
          subtitle: Table(
            columnWidths: {
              0:FlexColumnWidth(2),
              1:FlexColumnWidth(1.5),
              2:FlexColumnWidth(1.5),
              3:FlexColumnWidth(1.1),

            },
            children: [
              TableRow(
                  children: [
                    Text(
                      "Good Qty.:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),

                    Tooltip(
                      message:service_details_page_controller.service_inventory_details_list[index].goodQty.toString(),
                      child: Text(
                        service_details_page_controller.service_inventory_details_list[index]
                            .goodQty.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),
                        // textAlign: TextAlign.end,
                      ),
                    ),

                    Text(
                      "Bad Qty:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Tooltip(
                      message: service_details_page_controller.service_inventory_details_list[index]
                          .badQty.toString(),
                      child: Text(
                        service_details_page_controller.service_inventory_details_list[index]
                            .badQty.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),
                        overflow:  TextOverflow.ellipsis,
                      ),
                    ),
                  ]
              ),
              TableRow(
                  children: [
                    Text(
                      "Movable Qty.:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),

                    Text(
                      service_details_page_controller.service_inventory_details_list[index].movableQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                    ),

                    Text("Return Qty.:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(  service_details_page_controller.service_inventory_details_list[index].returnQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                      overflow:  TextOverflow.ellipsis,
                    ),
                  ]
              ),

              TableRow(
                  children: [
                    Text(
                      "Return Bad Qty.:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),

                    Tooltip(
                      message:service_details_page_controller.service_inventory_details_list[index]
                          .returnBadQty.toString() ,
                      child: Text(
                        service_details_page_controller.service_inventory_details_list[index]
                            .returnBadQty.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),
                        // textAlign: TextAlign.end,
                      ),
                    ),

                    Text(
                      "",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Text("",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                      overflow:  TextOverflow.ellipsis,
                    ),
                  ]
              ),
            ],



          )

      ),
    );
  }

}