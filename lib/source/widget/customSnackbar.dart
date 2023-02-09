import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackbar {
  static bannerSuccess(message) {
    return SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      // forceActionsBelow: true,
      duration: Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        title: 'Suksess!!',
        message: message,
        contentType: ContentType.success,
        inMaterialBanner: true,
      ),
      // actions: const [SizedBox.shrink()],
    );
  }
  static bannerFailed(message) {
    return SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      // forceActionsBelow: true,
      duration: Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        title: 'Failed!!',
        message: message,
        contentType: ContentType.failure,
        inMaterialBanner: true,
      ),
      // actions: const [SizedBox.shrink()],
    );
  }
}