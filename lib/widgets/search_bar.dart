import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  const SearchBar({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      margin: const EdgeInsets.symmetric(horizontal: 29),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),
          Image.asset(
            Assets.searchIcon,
            width: 13,
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: AppTextStyles.regular14,
              textAlignVertical: TextAlignVertical.center,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                isCollapsed: true,
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 9, right: 13, top: 3, bottom: 3),
                label: Text(
                  'Search',
                  style: AppTextStyles.regular14.copyWith(color: AppColors.black.withOpacity(0.5)),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: widget.focusNode.hasFocus ? 1 : 0,
            child: GestureDetector(
              onTap: () => widget.controller.clear(),
              child: Icon(
                Icons.cancel_outlined,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
