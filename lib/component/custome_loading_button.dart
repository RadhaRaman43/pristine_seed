import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';

class CustomLoadingButton extends StatelessWidget {
     CustomLoadingButton({
    Key? key,
    required this.text,
    required this.press,
    this.loading = false,
    this.icon,
  }) : super(key: key);

  final String text;
  final Function press;
  final bool loading;
  final IconData? icon;

  Size get size => Get.size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
          AllColors.textColor2,
          side: BorderSide(
              color: AllColors
                  .primaryDark1,
              width: 1)),
      onPressed: loading ? null : press as void Function()?, // Disable button while loading
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (loading)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          if (!loading && icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: AllColors.primaryDark1,
              ),
            ),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
