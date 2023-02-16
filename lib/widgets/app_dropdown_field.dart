import 'package:apricart/constants/assets.dart';
import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class AppDropdownField extends StatelessWidget {
  final String label;
  final String? data;
  final VoidCallback? onTap;
  const AppDropdownField({
    Key? key,
    required this.label,
    this.onTap,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: AppColors.grey0,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Text(
              data ?? label,
              style: data == null
                  ? AppTextStyles.medium14.copyWith(color: AppColors.grey1.withOpacity(0.6))
                  : AppTextStyles.medium14.copyWith(color: AppColors.black),
            ),
            const Spacer(),
            RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                Assets.arrowRightIcon,
                color: AppColors.grey1,
                width: 7,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
