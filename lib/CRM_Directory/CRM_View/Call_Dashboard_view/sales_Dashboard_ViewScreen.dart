import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Dashboard_VM/Sales_Dashboard_Vm.dart';

class SalesDashboardViewscreen extends StatelessWidget{
  SalesDashboardViewscreen({super.key});

  final dashboard_view_Controller = Get.put(SalesDashboardVm());
  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: () async {
      Get.toNamed(RoutesName.homeScreen);
      return false;
    },
    child: Scaffold(
        appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Text(
                'Sales Dashboard',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {
               // showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))
            ],
          )
      ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Obx(() {
              return Visibility(
                visible: dashboard_view_Controller.loading.value,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.green,
                  color: AllColors.textColor,
                ),
              );
            }),
            Container(
              margin: EdgeInsets.only(top: 15.0,left: 10,right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AllColors.grayColor, // Set the border color here
                  width: 1.0, // Adjust the border width if necessary
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Cluster Name',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.ClusterName.value
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Region Name',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.RegionName.value
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Sales Person Name',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.SalesPersonName.value
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Sales Person ER Code',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.SalesPersonERCode.value
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Period From',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.PeriodFrom.value
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AllColors.grayColor, // Set the border color here
                        width: 1.0, // Adjust the border width if necessary
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Period To',
                        labelStyle: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          dashboard_view_Controller.PeriodTo.value
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      )
    );
  }


}