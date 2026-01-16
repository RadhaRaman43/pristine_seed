

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../view/custom_drawer.dart';

class PageNotFoundScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments??"";
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
            ],
          )
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Image.asset("assests/images/opps_imge_not_found .jpeg"),
      ),
    );
  }
  
}