import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';

// Define your colors and font sizes here

class LoadingButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Future<void> Function() onPressed;

  const LoadingButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AllColors.textColor2,
        side: const BorderSide(
          color: AllColors.primaryDark1,
          width: 1,
        ),
      ),
      onPressed: _isLoading ? null : _handlePressed,
      icon: _isLoading
          ? CircularProgressIndicator(color: AllColors.primaryDark1)
          : Icon(widget.icon, color: AllColors.primaryDark1),
      label: Tooltip(
        message: widget.label,
        child: Text(
          widget.label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _handlePressed() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      _isLoading = false;
    });
  }
}
