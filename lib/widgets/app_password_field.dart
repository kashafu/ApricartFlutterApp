import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class AppPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  const AppPasswordField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
  }) : super(key: key);

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 43,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: AppColors.grey0,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: AppTextStyles.regular14.copyWith(color: AppColors.black),
            textAlignVertical: TextAlignVertical.center,
            obscureText: isObscure,
            decoration: InputDecoration(
                border: InputBorder.none,
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                label: Text(
                  widget.label ?? "Password",
                  style: AppTextStyles.medium14.copyWith(color: AppColors.grey1.withOpacity(0.6)),
                )),
          ),
        ),
        Positioned(
          right: 52,
          child: GestureDetector(
            onTap: () => setState(() {
              isObscure = !isObscure;
            }),
            child: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              size: 22,
              color: AppColors.grey1.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
