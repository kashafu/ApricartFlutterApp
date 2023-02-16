import 'package:apricart/shared/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app/locator.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class OrderTypeChangeDialog extends StatelessWidget {
  const OrderTypeChangeDialog({
    Key? key,
  }) : super(key: key);

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
                const SizedBox(height: 12),
                Text(
                  'Attention: Some of the selected products may not be available if you change order type.',
                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 32,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Cancel",
                            style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Container(
                          height: 32,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "OK",
                            style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
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