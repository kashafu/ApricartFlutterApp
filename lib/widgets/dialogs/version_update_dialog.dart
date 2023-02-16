import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VersionUpdateDialog extends StatelessWidget {
  final String message;
  final VoidCallback onUpdatePress;
  const VersionUpdateDialog({
    Key? key,
    required this.message,
    required this.onUpdatePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: screenWidth(context, multiplier: 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 35),
                Text(
                  'Message',
                  style: AppTextStyles.medium14.copyWith(fontSize: 15, color: AppColors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    onUpdatePress();
                  },
                  child: Container(
                    height: 45,
                    width: 190,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Update App",
                      style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
