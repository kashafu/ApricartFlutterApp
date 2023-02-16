import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String label;
  const AppTextField({
    Key? key,
    required this.label,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: AppTextStyles.regular14.copyWith(color: AppColors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          label: Text(
            label,
            style: AppTextStyles.medium14.copyWith(color: AppColors.grey1.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}
