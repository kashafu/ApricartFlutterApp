import 'package:apricart/viewmodels/order_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class OrderDetailView extends StatelessWidget {
  final String id;
  final String? lat;
  final String? long;
  const OrderDetailView({
    Key? key,
    required this.id,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailViewModel>.reactive(
      viewModelBuilder: () => OrderDetailViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(id),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.primary,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: statusBarHeight(context)),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Image.asset(
                        Assets.appName,
                        width: 110,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 30,
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Image.asset(
                          Assets.arrowBackIcon,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: AppColors.white0,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            const SizedBox(height: 12),
                            Text(
                              "Order no: ${viewModel.item?.orderId}",
                              style: AppTextStyles.regular15.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Order Date: ${viewModel.item?.createdAt}",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Address: ${viewModel.item?.addressUsed}",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Payment Method: ${viewModel.item?.paymentMethod}",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Payment Status: ${viewModel.item?.paymentStatus}",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                            ),
                            if ((viewModel.item?.orderType ?? '') == 'pickup') ...[
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => viewModel.openLocation(lat, long),
                                    child: Container(
                                      height: 32,
                                      width: 140,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "Pickup Location",
                                        style: AppTextStyles.medium14.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.grey1.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            const SizedBox(height: 7),
                            Text(
                              "Items",
                              style: AppTextStyles.semibold18.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  viewModel.item?.products?.length ?? 0,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 45,
                                          child: Center(
                                              child: Image.network(
                                                  viewModel.item?.products?[index].productImageUrl ?? '')),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  viewModel.item?.products?[index].title ?? '',
                                                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "Rs. ${viewModel.item?.products?[index].currentPrice?.round()} x ${viewModel.item?.products?[index].qty} = Rs. ${(viewModel.item?.products?[index].currentPrice?.round() ?? 0) * (viewModel.item?.products?[index].qty ?? 0)}",
                                                  style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Sub Total',
                                  style: AppTextStyles.regular15.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Rs. ${viewModel.item?.subtotal?.round().toString() ?? ''}',
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            if ((viewModel.item?.couponDiscountAmount?.round() ?? 0) != 0) ...[
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Discount',
                                    style: AppTextStyles.regular15.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Rs. ${viewModel.item?.couponDiscountAmount?.round().toString() ?? ''}',
                                    style: AppTextStyles.regular14.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if ((viewModel.item?.shippingAmount?.round() ?? 0) != 0) ...[
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Delivery Charges',
                                    style: AppTextStyles.regular15.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Rs. ${viewModel.item?.shippingAmount?.round().toString() ?? ''}',
                                    style: AppTextStyles.regular14.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: AppTextStyles.medium16.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Rs. ${viewModel.item?.grandTotal?.round().toString() ?? ''}',
                                  style: AppTextStyles.medium14.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
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
