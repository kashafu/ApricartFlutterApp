import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class AppPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isDisabled;
  const AppPhoneField({
    Key? key,
    this.controller,
    this.focusNode,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: Stack(
        children: [
          Container(
            height: 43,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.only(left: 50),
            decoration: BoxDecoration(
              color: isDisabled ? AppColors.grey1.withOpacity(0.05) : Colors.transparent,
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
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.length > 10) {
                  int offset = controller?.selection.base.offset ?? 0;
                  if (offset == value.length) {
                    controller?.text = value.substring(0, 10);
                  } else {
                    controller?.text = value.substring(0, offset - 1) + value.substring(offset);
                  }
                  controller?.selection = TextSelection.fromPosition(TextPosition(offset: offset - 1));
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  label: Text(
                    "3xxxxxxxxx",
                    style: AppTextStyles.medium14.copyWith(color: AppColors.grey1.withOpacity(0.6)),
                  )),
            ),
          ),
          Positioned(
            top: 0,
            left: 40,
            bottom: 0,
            child: Container(
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.grey1.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: AppColors.grey0,
                ),
              ),
              child: Text(
                "+92",
                style: AppTextStyles.regular14.copyWith(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
