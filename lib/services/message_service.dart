import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/themes/dialogs.dart';
import 'package:fimto_frame/themes/theme.dart';

class MessageService {
  void showErrorSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      instantInit: true,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: 5),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  void showSuccessSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      instantInit: true,
      backgroundColor: FimtoColors.onPrimaryColor,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: 5),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: FimtoColors.primaryColor),
      ),
    );
  }

  Future<T?> showErrorInfoDialog<T>(String title, String message) {
    return Get.defaultDialog(
      title: '',
      backgroundColor: FimtoColors.onPrimaryColor,
      content: ErrorDialog(
        title: title,
        message: message,
      ),
    );
  }

  Future<T?> showSuccessInfoDialog<T>(String title, String message) {
    return Get.defaultDialog(
      title: '',
      backgroundColor: FimtoColors.onPrimaryColor,
      content: SuccessDialog(
        title: title,
        message: message,
      ),
    );
  }

  Future<T?> showDecisionAlertDialog<T>(
      String title, String message, String confirm, String cancel) {
    return Get.defaultDialog(
      title: '',
      content: Center(
        child: Text(
          message,
          style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                color: FimtoColors.warningDark,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: FimtoColors.onPrimaryColor,
      cancel: InkWell(
        onTap: () {
          Get.back(result: false);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FimtoColors.warningLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: FimtoColors.warningDark,
              width: 1,
            ),
          ),
          height: 42,
          width: 124,
          child: Center(
            child: Text(
              cancel,
              style: Theme.of(Get.context!).textTheme.button!.copyWith(
                    color: FimtoColors.warningDark,
                  ),
            ),
          ),
        ),
      ),
      confirm: InkWell(
        onTap: () {
          Get.back(result: true);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FimtoColors.warningDark,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 42,
          width: 124,
          child: Center(
            child:
                Text(confirm, style: Theme.of(Get.context!).textTheme.button),
          ),
        ),
      ),
      confirmTextColor: FimtoColors.onSecondaryColor,
      onConfirm: () => Get.back(result: true),
      barrierDismissible: false,
    );
  }

  Future<T?> showDecisionWithDatePickerAlertDialog<T>(
      String title, String confirm, String cancel, Function onDatePressed) {
    var dateMessage = DateTime.now();
    return Get.defaultDialog(
      title: title,
      titleStyle: Theme.of(Get.context!).textTheme.headline2,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: StatefulBuilder(
          builder: (_, StateSetter setState) => InkWell(
            onTap: () async {
              var date = await onDatePressed();
              if (date == null) return;

              setState(() => dateMessage = date);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(Get.context!).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16),
                    child: Text(
                      dateMessage.toIso8601String(),
                      style:
                          TextStyle(color: Theme.of(Get.context!).primaryColor),
                    ),
                  ),
                  Container(
                    color: Theme.of(Get.context!).primaryColorLight,
                    child: Image.asset('assets/images/drop_down.png'),
                    height: 36,
                    width: 36,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: FimtoColors.onPrimaryColor,
      cancel: InkWell(
        onTap: () {
          Get.back(result: false);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FimtoColors.errorColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 46,
          width: 128,
          child: Center(
            child: Text(
              cancel,
              style: Theme.of(Get.context!).textTheme.button!,
            ),
          ),
        ),
      ),
      confirm: InkWell(
        onTap: () {
          Get.back(result: true);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FimtoColors.successColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 46,
          width: 128,
          child: Center(
            child:
                Text(confirm, style: Theme.of(Get.context!).textTheme.button),
          ),
        ),
      ),
      confirmTextColor: FimtoColors.onSecondaryColor,
      onConfirm: () => Get.back(result: true),
      barrierDismissible: false,
    );
  }

  Future showChoiceDialog(Widget widget) {
    return Get.dialog(widget);
  }
}
