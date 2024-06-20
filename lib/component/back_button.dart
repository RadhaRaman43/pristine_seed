import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    Key? key,
    this.press,
  }) : super(key: key);
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey[50],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AllColors.primaryDark1,
            size: 15.0,
          ),
          onPressed: press as void Function()?,
        ),
      ),
    );
  }
}