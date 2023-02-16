import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDefaultSnackbars {
  static GlobalKey<ScaffoldMessengerState> get scaffoldKey => locator<DataService>().scaffoldMessengerKey;
  static showErrorSnackbar(String message) {
    scaffoldKey.currentState?.clearSnackBars();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.red[600],
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 0),
                blurRadius: 5,
                color: AppColors.black.withOpacity(0.4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 3),
              const Icon(
                Icons.error_outline,
                size: 25,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.regular14.copyWith(color: AppColors.white),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showSuccessSnackbar(String message) {
    scaffoldKey.currentState?.clearSnackBars();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.green[600],
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 0),
                blurRadius: 5,
                color: AppColors.black.withOpacity(0.4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 3),
              const Icon(
                Icons.done,
                size: 25,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.regular14.copyWith(color: AppColors.white),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showIOSNotificationSnackbar(String title, String message, Function() onTap) {
    scaffoldKey.currentState?.clearSnackBars();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        content: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.clearSnackBars();
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 5)
                .add(EdgeInsets.only(bottom: screenHeight(StackedService.navigatorKey!.currentContext!) - 160)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(-1, 2),
                  blurRadius: 5,
                  color: AppColors.black.withOpacity(0.4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: AppTextStyles.medium16.copyWith(color: AppColors.black, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
