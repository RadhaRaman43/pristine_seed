import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';

class CreateSalesForceCastScreen extends StatelessWidget{
  final sales_force_cast_vm = Get.put(SalesForeCastVM());
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:  () async {
      Get.toNamed(RoutesName.homeScreen);
      return false;
    },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,
              ),
              title:Row(
                children: [
                  Text(
                    'Create ForceCast List',
                    style: GoogleFonts.poppins(
                      color: AllColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              )
          ),
          drawer: CustomDrawer(),
          body:  RefreshIndicator(
            onRefresh:sales_force_cast_vm.refreshList,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Obx((){
                    return Visibility(
                      visible:sales_force_cast_vm.loading.value ,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    );
                  }),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8), // optional spacing
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                                backgroundColor: AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor),
                                ),
                                label: Text(
                                    'Pending',
                                    style: TextStyle(
                                      color:  AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                onPressed: () {
                                },
                              );
                            }),
                            const SizedBox(width: 8),
                            Obx(() {
                              return ActionChip(
                                elevation: 2,
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                                backgroundColor: AllColors.grayColor,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.grayColor),
                                ),
                                label: Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {

                                },
                              );
                            }),
                            const SizedBox(width: 8), // optional spacing between chips

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  Widget bindDateData(TextEditingController value,String hintdata){
    return  TextField(
      controller: value,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: hintdata,
          hintText: hintdata,
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
      cursorColor: AllColors.primaryDark1,
      onChanged: (value) {
        // Handle the text field value changes if needed
      },
    );
  }
}