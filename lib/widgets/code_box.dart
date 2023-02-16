import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class CodeBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  const CodeBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.grey1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: AppColors.grey0,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: AppTextStyles.semibold14.copyWith(color: AppColors.black),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        onTap: () {
          controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
        },
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}
