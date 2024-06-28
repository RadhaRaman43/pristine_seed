import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';

class CustomConfirmDialog {
  static void showDialog({
    required BuildContext context,
    required String title,
    required String content,
    required Function() onPress,
    required RxBool isLoading,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: AllColors.primaryDark1,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          content,
          style: const TextStyle(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w600,
            fontSize: AllFontSize.fourtine,
          ),
        ),
      ),
      confirm: Obx(() {
        return Wrap(
          children: [
            OutlinedButton(
              onPressed: isLoading.value ? null : onPress,
              child: isLoading.value
                  ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: AllColors.primaryDark1,
                ),
              )
                  : const Text(
                "Yes",
                style: TextStyle(color: AllColors.primaryDark1),
              ),
            ),
          ],
        );
      }),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text("No", style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
