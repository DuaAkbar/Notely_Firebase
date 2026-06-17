import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/widgets/ConfirmationModal.dart';

class Helpers {
 
  static void showConfirmationDialogue(
    String title,
    String message,
    VoidCallback callback,
  ) {
    Get.dialog(
      ConfirmationModal(title: title, message: message, callback: callback),
    );
  }
}
