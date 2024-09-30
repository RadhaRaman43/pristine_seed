  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';
import '../view/custom_drawer.dart';

class ImageNotFound extends StatelessWidget{
  ImageNotFound({super.key});
  
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: ()  async {
       Get.back();
       return false;
     },
     child: Scaffold(
       appBar: AppBar(
         title: Text(
           'Data Not Found',
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
         width:double.infinity,
         height: double.infinity,
         child: Container(
           padding: EdgeInsets.all(10.0),
           margin: EdgeInsets.all(18.0),
           child: Image.asset("assests/images/opps_imge_not_found .jpeg"),

         ),
       ),







     ),
   );
  }
  
}