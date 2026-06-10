import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

class SalesForceHeaderDetails extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.SalesForeCastScreen);
        return false;

      },
      child: Scaffold(
          onDrawerChanged: (isOpen) {
            if (isOpen) {
              //FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          appBar: AppBar(
            backgroundColor: AllColors.primaryDark1,
            iconTheme: IconThemeData(
              color: AllColors.whiteColor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'View Forcast',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '()',
                      style: GoogleFonts.poppins(
                        color: AllColors.whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

              ],
            ),

          ),
          drawer: CustomDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Visibility(
                  visible: sales_force_cast_vm.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.textColor,
                  ),
                );
              }),
              Expanded(
                child: ListView(children: [
                  Obx(() {
                    return BindSalesData(context);
                  }),
                ]),
              ),
            ],
          )),
    );
  }
  Widget BindSalesData(BuildContext context) {
  /*  String? dateTimeCreatedOn = StaticMethod.dateTimeToDate(
        saleCycleController.saleCycleList[0].createdOn ?? "");
    String? dateTimeApprovedOn = StaticMethod.dateTimeToDate(
        saleCycleController.saleCycleList[0].approvedOn ?? "");
    String? expClosureDate = StaticMethod.convertDateFormat1(
        saleCycleController.saleCycleList[0].estClosureDate ?? "");
    String saleCycleStatus =
        saleCycleController.saleCycleList[0].salesCycleApprovalStatus?.toLowerCase() ?? "";

*/

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AllColors.grayColor, // Set the border color here
                width: 1.0, // Adjust the border width if necessary
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Sales Details',
                labelStyle: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                    fontSize: AllFontSize.twentee),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  //bindData(fixText: "Task ID : ",data:saleCycleController.saleCycleList[0].taskId ?? ""),
                  const SizedBox(height: 3,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bindData({required String fixText,required String data,Color color = AllColors.textColor,
    VoidCallback? onTap, TextDecoration? decoration, TextDecorationStyle? decorationStyle,}){

    if(fixText=="Budget Amount" || fixText=="Expected Amount"){
      String formattedAmount = '₹ ${data}';
      data= formattedAmount;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fixText,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),

        Flexible(
          child: InkWell(
            onTap: onTap,
            child: Tooltip(
              message: data,
              child: Text(data,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                  decoration: decoration,
                  decorationStyle: decorationStyle,
                ),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }


}