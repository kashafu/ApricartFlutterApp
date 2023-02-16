import 'package:apricart/shared/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../app/locator.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class SelectCityDialog extends StatefulWidget {
  final List<String> items;
  const SelectCityDialog({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<SelectCityDialog> createState() => _SelectCityDialogState();
}

class _SelectCityDialogState extends State<SelectCityDialog> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
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
                const SizedBox(height: 20),
                Text(
                  'Select City',
                  style: AppTextStyles.semibold18.copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 52,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: AppColors.secondary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: value,
                    hint: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('Select', style: AppTextStyles.regular15),
                    ),
                    items: List.generate(
                      widget.items.length,
                      (index) => DropdownMenuItem(
                        value: widget.items[index],
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(widget.items[index], style: AppTextStyles.regular15),
                        ),
                      ),
                    ),
                    onChanged: (selection) => setState(() {
                      value = selection;
                    }),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (value != null) {
                            Navigator.of(context).pop(value);
                          }
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
                            "Done",
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
