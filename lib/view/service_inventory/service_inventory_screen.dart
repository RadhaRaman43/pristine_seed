import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/service_inventory_vm/service_inventory_vm.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../custom_drawer.dart';



class ServiceInventoryListScreen extends StatelessWidget{
  ServiceInventoryListScreen({super.key});
  Size size= Get.size;
   final service_inventory_page_controller=Get.put(ServiceInventoryViewModel());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async  {
        Get.offAllNamed(RoutesName.homeScreen);
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
                'Service Inventory',
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
          width:double.infinity,
          height: size.height,
          child: Column(
            children: [

              Obx(() {
                return Container(
                  margin: EdgeInsets.only(top: 0.3),
                  child: Visibility(
                    visible: service_inventory_page_controller.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  ),
                );
              },
              ),
              Container(
                  child: Obx(() => binListView(context),)
              ),


            ],
          ),
        ),
      ),
    );

  }

  binListView(BuildContext context) {
    ScrollController scrollController = ScrollController();

    if(service_inventory_page_controller.get_service_inventory_list.isNotEmpty &&
        service_inventory_page_controller.get_service_inventory_list.length>0)
    {
      scrollController.addListener(() {
        print("rmgfrnrnknkvb");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (service_inventory_page_controller.total_rows /
              service_inventory_page_controller.rowsPerPage)
              .toInt();
          if ((service_inventory_page_controller.total_rows %
              service_inventory_page_controller.rowsPerPage) >
              0) total_page += 1;
          print(
              "last index ${service_inventory_page_controller.pageNumber} ${service_inventory_page_controller.total_rows} ${service_inventory_page_controller.rowsPerPage} ${total_page}");

          if (service_inventory_page_controller.pageNumber + 1 != total_page) {
            service_inventory_page_controller.getServiceInventoryGetList(
                service_inventory_page_controller.pageNumber+1,);
            this.service_inventory_page_controller.pageNumber += 1;
          }
        }
      });
      return  Expanded(
        child: ListView.separated(
          padding: EdgeInsets.all(3),
          controller: scrollController,
          shrinkWrap: true,
            itemBuilder: (context, index) {
          return  bindInventoryListView(context,index);
        }, separatorBuilder: (context, index) {
          return Divider(height: 0.5,color: AllColors.primaryDark1);
        }, itemCount:service_inventory_page_controller.get_service_inventory_list.value.length),
      );

    }else {

      return Center(
        child: Image.asset(
          "assests/images/no_data_remove.png",
          width: 300,
          height: 180,
        ),
      );

    }


  }

  bindInventoryListView(BuildContext context, int index) {
    return Container(
      child: ListTile(
          title:   Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Item No.:",
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
                  message:"${service_inventory_page_controller. get_service_inventory_list[index]
                      .displayName??""} ( ${service_inventory_page_controller. get_service_inventory_list[index]
                      .itemNo??""} ) " ,
                  child: Text("${service_inventory_page_controller. get_service_inventory_list[index]
                      .displayName??""} ( ${service_inventory_page_controller. get_service_inventory_list[index]
                      .itemNo??""} ) ",
                     style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w600),
                       textAlign: TextAlign.start,
                       overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                  onTap: () {

                    service_inventory_page_controller. getServiceInventoryListView(service_inventory_page_controller. get_service_inventory_list[index].itemNo.toString());

              },
                  child: Icon(Icons.remove_red_eye_rounded))
            ],
          ) ,

          subtitle: Table(
            columnWidths: {
              0:FlexColumnWidth(2),
              1:FlexColumnWidth(1.5),
              2:FlexColumnWidth(1.5),
              3:FlexColumnWidth(1.5),

            },
            children: [
              TableRow(
                children: [
                  Text(
                    "Good Qty:",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),

                  Tooltip(
                    message: service_inventory_page_controller. get_service_inventory_list[index]
                        .goodQty.toString() ,
                    child: Text(
                      service_inventory_page_controller. get_service_inventory_list[index]
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
                    message: service_inventory_page_controller. get_service_inventory_list[index]
                        .badQty.toString(),
                    child: Text(
                      service_inventory_page_controller. get_service_inventory_list[index]
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
                      "Movable Qty:",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),

                    Text(
                      service_inventory_page_controller. get_service_inventory_list[index].movableQty.toString(),
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w300),
                    ),


                    Text("",
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