import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';
class DefaultButtonRed extends StatelessWidget {
  DefaultButtonRed({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  final String? text;
  final Function? press;

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ), backgroundColor: AllColors.redColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: GoogleFonts.poppins(
            fontSize: AllFontSize.fourtine,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}