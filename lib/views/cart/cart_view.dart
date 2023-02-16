import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      onDispose: (viewModel) => viewModel.disposeViewModel(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
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
                  // Positioned(
                  //   left: 0,
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Container(
                  //       width: 40,
                  //       height: 12,
                  //       margin: const EdgeInsets.only(left: 20),
                  //       alignment: Alignment.center,
                  //       color: Colors.transparent,
                  //       child: Image.asset(
                  //         Assets.arrowBackIcon,
                  //         height: 12,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white0,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: viewModel.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(color: AppColors.primary),
                            )
                          : viewModel.cart.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Items Found',
                                    style: AppTextStyles.semibold18,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 25),
                                            ...List<Widget>.generate(
                                              viewModel.cart.length,
                                              (index) => Opacity(
                                                opacity: viewModel.cart[index].inStock == true ? 1 : 0.5,
                                                child: Container(
                                                  height: 110,
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets.only(left: 20, right: 20, top: 12),
                                                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        alignment: Alignment.center,
                                                        child:
                                                            Image.network(viewModel.cart[index].productImageUrl ?? ''),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Text(
                                                                viewModel.cart[index].title ?? '',
                                                                style: AppTextStyles.regular14
                                                                    .copyWith(color: AppColors.black),
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                            const SizedBox(height: 4),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    'Rs. ${(viewModel.cart[index].specialPrice != null && viewModel.cart[index].specialPrice != 0.0) ? (viewModel.cart[index].specialPrice?.round()) : (viewModel.cart[index].currentPrice?.round())} x ${viewModel.cart[index].qty} = Rs. ${((viewModel.cart[index].specialPrice != null && viewModel.cart[index].specialPrice != 0.0) ? (viewModel.cart[index].specialPrice?.round() ?? 0) : (viewModel.cart[index].currentPrice?.round() ?? 0)) * (viewModel.cart[index].qty ?? 0)}',
                                                                    style: AppTextStyles.regular14
                                                                        .copyWith(color: AppColors.black),
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      viewModel.deleteFromCart(viewModel.cart[index]),
                                                                  child: Image.asset(
                                                                    Assets.deleteIcon,
                                                                    height: 20,
                                                                    color: viewModel.cart[index].inStock == true
                                                                        ? null
                                                                        : const Color(0xFFFF3B30),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(height: 12),
                                                            if (viewModel.cart[index].inStock == true)
                                                              Align(
                                                                alignment: Alignment.topRight,
                                                                child: Container(
                                                                  height: 24,
                                                                  padding: const EdgeInsets.symmetric(
                                                                      horizontal: 7, vertical: 2),
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                      width: 1,
                                                                      color: AppColors.secondary.withOpacity(0.5),
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () => viewModel
                                                                            .subtractFromCart(viewModel.cart[index]),
                                                                        child: Image.asset(
                                                                          Assets.removeCartIcon,
                                                                          height: 14,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 13),
                                                                        child: Text(
                                                                          '${viewModel.cart[index].qty}',
                                                                          style: AppTextStyles.regular14,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            viewModel.addToCart(viewModel.cart[index]),
                                                                        child: Image.asset(
                                                                          Assets.addCartIcon,
                                                                          height: 14,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: AppColors.secondary.withOpacity(0.1),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 7),
                                          Container(
                                            height: 35,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(horizontal: 45),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: viewModel.promoController,
                                                    style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      alignLabelWithHint: true,
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      isCollapsed: true,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                                      label: Text(
                                                        "Enter promo code",
                                                        style: AppTextStyles.regular14
                                                            .copyWith(color: AppColors.grey1.withOpacity(0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Container(
                                                  width: 1,
                                                  alignment: Alignment.center,
                                                  color: AppColors.black,
                                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () => viewModel.applyPromoCode(),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 1),
                                                    child: Text(
                                                      "Apply",
                                                      style: AppTextStyles.medium16.copyWith(fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Home Delivery",
                                                  style: AppTextStyles.medium14
                                                      .copyWith(color: AppColors.black, fontSize: 15),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "",
                                                  style: AppTextStyles.regular14
                                                      .copyWith(color: AppColors.black, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Sub Total",
                                                  style: AppTextStyles.regular14
                                                      .copyWith(color: AppColors.black, fontSize: 15),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "Rs. ${viewModel.cartService.checkoutData?.subtotal ?? ''}",
                                                  style: AppTextStyles.regular14
                                                      .copyWith(color: AppColors.black, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if ((viewModel.cartService.checkoutData?.couponDiscountAmount ?? 0.0) !=
                                              0.0) ...[
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Discount",
                                                    style: AppTextStyles.regular14
                                                        .copyWith(color: AppColors.black, fontSize: 15),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "Rs. ${viewModel.cartService.checkoutData?.couponDiscountAmount ?? ''}",
                                                    style: AppTextStyles.regular14
                                                        .copyWith(color: AppColors.black, fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 9),
                                            child: Container(
                                              color: AppColors.green,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 1),
                                                    Text(
                                                      "Delivery Charges",
                                                      style: AppTextStyles.regular14
                                                          .copyWith(color: AppColors.black, fontSize: 15),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      "Rs. ${viewModel.cartService.checkoutData?.shippingAmount ?? ''}",
                                                      style: AppTextStyles.regular14
                                                          .copyWith(color: AppColors.black, fontSize: 15),
                                                    ),
                                                    const SizedBox(width: 1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          HtmlWidget(
                                            viewModel.cartService.checkoutData?.shipmentMessage ?? '',
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              Text(
                                                "Total",
                                                style: AppTextStyles.medium14.copyWith(color: AppColors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "Rs. ${viewModel.cartService.checkoutData?.grandTotal ?? ''}",
                                                style: AppTextStyles.medium14.copyWith(color: AppColors.black),
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.moveToOrderDetailView();
                                            },
                                            child: Container(
                                              height: 45,
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.symmetric(horizontal: 45),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondary,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child:
                                                  // viewModel.isLoading
                                                  //     ? const SizedBox(
                                                  //         height: 25,
                                                  //         width: 25,
                                                  //         child: CircularProgressIndicator(
                                                  //           color: AppColors.white,
                                                  //           strokeWidth: 3,
                                                  //         ),
                                                  //       )
                                                  //     :
                                                  Text(
                                                "Continue",
                                                style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                    if (viewModel.isLoading)
                      Positioned.fill(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: const CircularProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
