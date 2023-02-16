import 'package:apricart/viewmodels/delivery_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class DeliveryDetailsView extends StatelessWidget {
  const DeliveryDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryDetailsViewModel>.reactive(
      viewModelBuilder: () => DeliveryDetailsViewModel(context),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
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
                  child: viewModel.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 25),
                                  Text(
                                    viewModel.orderType == 'delivery' ? "Delivery Details" : "Pickup Details",
                                    style: AppTextStyles.semibold22,
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    margin: const EdgeInsets.symmetric(horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.grey0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          color: AppColors.grey1.withOpacity(0.1),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 7),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Image.asset(
                                                  Assets.moreProfileIcon,
                                                  height: 15,
                                                  color: AppColors.black,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "Personal Information",
                                                  style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 25),
                                              SizedBox(
                                                width: 60,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Name:",
                                                      style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  viewModel.name,
                                                  style: AppTextStyles.regular14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 25),
                                              SizedBox(
                                                width: 60,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Phone:",
                                                      style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  viewModel.phone,
                                                  style: AppTextStyles.regular14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  if (viewModel.orderType == 'delivery')
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: const EdgeInsets.symmetric(horizontal: 25),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.grey0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            color: AppColors.grey1.withOpacity(0.1),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 7),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  Image.asset(
                                                    Assets.locationIcon,
                                                    height: 15,
                                                    color: AppColors.black,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Delivery Address",
                                                    style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(minHeight: 25),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Text(
                                                  viewModel.selectedAddress?.address ?? "No address found",
                                                  style: AppTextStyles.regular14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          GestureDetector(
                                            onTap: () => viewModel.moveToMyAddressesView(),
                                            child: Container(
                                              height: 32,
                                              width: 130,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.secondary,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                "Select Address",
                                                style: AppTextStyles.regular14.copyWith(color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 11),
                                        ],
                                      ),
                                    ),
                                  if (viewModel.orderType == 'pickup') ...[
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: const EdgeInsets.symmetric(horizontal: 25),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.grey0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            color: AppColors.grey1.withOpacity(0.1),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 7),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  Image.asset(
                                                    Assets.locationIcon,
                                                    height: 15,
                                                    color: AppColors.black,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Pickup Address",
                                                    style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          GestureDetector(
                                            onTap: () => viewModel.selectPickupAddress(),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border:
                                                        Border.all(width: 2, color: AppColors.grey1.withOpacity(0.6)),
                                                  ),
                                                  child: Text(
                                                    viewModel.pickupAddress?.name ?? 'Select Address',
                                                    style: AppTextStyles.medium14.copyWith(
                                                        color: viewModel.pickupAddress != null
                                                            ? AppColors.black
                                                            : AppColors.grey1.withOpacity(0.6)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 30,
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Image.asset(
                                                      Assets.arrowRightIcon,
                                                      color: AppColors.grey1,
                                                      width: 7,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: const EdgeInsets.symmetric(horizontal: 25),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.grey0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            color: AppColors.grey1.withOpacity(0.1),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 7),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  Image.asset(
                                                    Assets.calendarIcon,
                                                    height: 15,
                                                    color: AppColors.black,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Preferred Pick-up Day",
                                                    style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          GestureDetector(
                                            onTap: () => viewModel.selectPickupDay(),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border:
                                                        Border.all(width: 2, color: AppColors.grey1.withOpacity(0.6)),
                                                  ),
                                                  child: Text(
                                                    viewModel.selectedPickupDay?.displayDate ?? 'Select Pickup Day',
                                                    style: AppTextStyles.medium14.copyWith(
                                                        color: viewModel.selectedPickupDay != null
                                                            ? AppColors.black
                                                            : AppColors.grey1.withOpacity(0.6)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 30,
                                                  child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Image.asset(
                                                      Assets.arrowRightIcon,
                                                      color: AppColors.grey1,
                                                      width: 7,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                    if (viewModel.pickupAddress != null && viewModel.selectedPickupDay != null) ...[
                                      const SizedBox(height: 25),
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        margin: const EdgeInsets.symmetric(horizontal: 25),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.grey0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              color: AppColors.grey1.withOpacity(0.1),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 7),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 8),
                                                    Image.asset(
                                                      Assets.clockIcon,
                                                      height: 15,
                                                      color: AppColors.black,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      "Preferred Pick-up Time",
                                                      style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            GestureDetector(
                                              onTap: () => viewModel.selectPickupTime(),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: double.maxFinite,
                                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border:
                                                          Border.all(width: 2, color: AppColors.grey1.withOpacity(0.6)),
                                                    ),
                                                    child: Text(
                                                      viewModel.selectedPickupTime?.displayTime ?? 'Select Pickup Time',
                                                      style: AppTextStyles.medium14.copyWith(
                                                          color: viewModel.selectedPickupTime != null
                                                              ? AppColors.black
                                                              : AppColors.grey1.withOpacity(0.6)),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 30,
                                                    child: RotatedBox(
                                                      quarterTurns: 1,
                                                      child: Image.asset(
                                                        Assets.arrowRightIcon,
                                                        color: AppColors.grey1,
                                                        width: 7,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                  const SizedBox(height: 25),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    margin: const EdgeInsets.symmetric(horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.grey0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          color: AppColors.grey1.withOpacity(0.1),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 7),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Image.asset(
                                                  Assets.commentIcon,
                                                  height: 15,
                                                  color: AppColors.black,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "Special Instructions",
                                                  style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: TextField(
                                            controller: viewModel.deliveryInstructionsController,
                                            focusNode: viewModel.deliveryInstructionsFocus,
                                            style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                            maxLines: null,
                                            expands: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              alignLabelWithHint: true,
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              isCollapsed: true,
                                              label: Text(
                                                "Delivery Instructions",
                                                style: AppTextStyles.regular14
                                                    .copyWith(color: AppColors.grey1.withOpacity(0.6)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () => viewModel.moveToPaymentMethodSelectionView(),
                                    child: Container(
                                      height: 45,
                                      width: 220,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: viewModel.isLoading
                                          ? const SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                color: AppColors.white,
                                                strokeWidth: 3,
                                              ),
                                            )
                                          : Text(
                                              "Continue",
                                              style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 67),
            ],
          ),
        ),
      ),
    );
  }
}
