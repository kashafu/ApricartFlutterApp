import 'package:apricart/models/address_model.dart';
import 'package:apricart/models/payment_method_model.dart';
import 'package:apricart/viewmodels/payment_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class PaymentInfoView extends StatelessWidget {
  final Address address;
  final String notes;
  final String day;
  final String startTime;
  final String endTime;
  const PaymentInfoView({
    Key? key,
    required this.address,
    required this.notes,
    this.day = '',
    this.startTime = '',
    this.endTime = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentInfoViewModel>.reactive(
      viewModelBuilder: () => PaymentInfoViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white0,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            "Payment Details",
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
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          "Select Payment Method",
                                          style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                ...List.generate(
                                  viewModel.paymentMethods.length,
                                  (index) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (index != 0)
                                        Container(
                                          height: 2,
                                          alignment: Alignment.center,
                                          color: AppColors.grey0,
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                        ),
                                      Container(
                                        height: 70,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 15),
                                            Icon(
                                              Icons.credit_card_outlined,
                                              color: AppColors.secondary,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                viewModel.paymentMethods[index].name ?? 'unknown',
                                                style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                              ),
                                            ),
                                            Radio<PaymentMethod>(
                                              value: viewModel.paymentMethods[index],
                                              groupValue: viewModel.selectedMethod,
                                              onChanged: (method) {
                                                viewModel.selectedMethod = method;
                                                viewModel.notifyListeners();
                                              },
                                            ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
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
                            onTap: () => viewModel.processOrder(address.id ?? -1, notes, day, startTime, endTime),
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
                                      "Place Order",
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
    );
  }
}
