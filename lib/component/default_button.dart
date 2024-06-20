import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';

class DefaultButton extends StatelessWidget {

  DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.loading=false,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final bool loading;
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height:size.height*.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ), backgroundColor: AllColors.primaryDark1,
        ),
        onPressed: loading ? null : press as void Function()?, // Disable button while loading
        child: loading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AllColors.primaryDark1, // You can change the color to your preference
          ),
        )
            : Text(
          text!,
          style: GoogleFonts.poppins(
              fontSize:AllFontSize.fourtine,
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}