import 'package:apricart/constants/assets.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SortBottomSheet extends StatelessWidget {
  final bool? highToLowSelected;
  const SortBottomSheet({Key? key, required this.highToLowSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Text(
              "Sort by",
              style: AppTextStyles.medium14.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 5),
            Container(
              height: 45,
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price: Low to High",
                        style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                  Radio(
                    value: false,
                    groupValue: highToLowSelected,
                    onChanged: (value) => Navigator.of(context).pop(value),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price: High to low",
                        style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                  Radio(
                    value: true,
                    groupValue: highToLowSelected,
                    onChanged: (value) => Navigator.of(context).pop(value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
