import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/order_type_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/helpers.dart';
import '../../widgets/custom_carousel_slider.dart';

class OrderTypeView extends StatelessWidget {
  const OrderTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderTypeViewModel>.reactive(
      viewModelBuilder: () => OrderTypeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            SizedBox(height: statusBarHeight(context)),
            Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                Assets.appName,
                width: 110,
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.white0,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 37),
                      // CustomCarouselSlider(
                      //   items: viewModel.carousalItems,
                      //   margin: 27,
                      //   height: (screenWidth(context) - 54) * (149 / 338),
                      // ),
                      const SizedBox(height: 3),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.blue0.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 22),
                            Text(
                              "Select order type",
                              style: AppTextStyles.bold27.copyWith(color: AppColors.blue1),
                            ),
                            const SizedBox(height: 22),
                            Container(
                              height: 1,
                              alignment: Alignment.center,
                              color: AppColors.blue0.withOpacity(0.2),
                            ),
                            OrderTypeTile(
                              imagePath: Assets.orderType1,
                              title: "Big Buy \nBig Savings",
                              urduTitle: "بڑی خریداری بڑی بچت",
                              urduFontSize: 18,
                              isSelected: true,
                              onTap: () => viewModel.navigateToHome(),
                            ),
                            Container(
                              height: 1,
                              alignment: Alignment.center,
                              color: AppColors.blue0.withOpacity(0.2),
                            ),
                            OrderTypeTile(
                              imagePath: Assets.orderType2,
                              title: "Click & Collect \nMart",
                              urduTitle: "گھر سے  آرڈر کریں اور قریبی اسٹور سے  پک کریں",
                              urduFontSize: 16,
                              isSelected: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 67),
          ],
        ),
      ),
    );
  }
}

class OrderTypeTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String urduTitle;
  final double? urduFontSize;
  final bool? isSelected;
  final VoidCallback? onTap;
  const OrderTypeTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.urduTitle,
    this.urduFontSize,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Opacity(
            opacity: isSelected == true ? 1 : 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 22),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 168,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: AppTextStyles.bold22.copyWith(color: AppColors.blue1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                urduTitle,
                                style: AppTextStyles.urduBold16.copyWith(
                                  color: AppColors.blue1,
                                  height: 1.9,
                                  fontSize: urduFontSize,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected == true)
            Positioned(
              top: 10,
              right: 18,
              child: Image.asset(
                Assets.orderSelectionTickIcon,
                width: 21,
              ),
            ),
        ],
      ),
    );
  }
}
