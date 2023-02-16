import 'package:flutter/material.dart';

import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class MinOrderDialog extends StatelessWidget {
  final String message;
  const MinOrderDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
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
                const SizedBox(height: 20),
                Text(
                  'Alert!',
                  style: AppTextStyles.semibold18.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 14),
                Text(
                  message,
                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Okay",
                          style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
