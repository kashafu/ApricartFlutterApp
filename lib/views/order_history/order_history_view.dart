import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/order_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryViewModel>.reactive(
      viewModelBuilder: () => OrderHistoryViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      builder: (context, viewModel, child) => DefaultTabController(
        length: 3,
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
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white0,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: AppColors.secondary,
                            height: 60,
                            child: TabBar(
                              indicatorColor: AppColors.white,
                              tabs: [
                                Tab(
                                  text: 'Pending',
                                ),
                                Tab(
                                  text: 'Completed',
                                ),
                                Tab(
                                  text: 'Cancelled',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(children: [
                            Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: viewModel.isBusy
                                  ? const Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    )
                                  : viewModel.orderHistory == null ||
                                          (viewModel.orderHistory?.pending?.isEmpty ?? false)
                                      ? Center(
                                          child: Text(
                                            "No Data Found",
                                            style: AppTextStyles.regular16,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                viewModel.orderHistory?.pending?.length ?? 0,
                                                (index) => Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: index == 0
                                                        ? null
                                                        : Border(
                                                            top: BorderSide(
                                                                width: 1, color: AppColors.grey1.withOpacity(0.6)),
                                                          ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 18),
                                                        Text(
                                                          "Order no: ${viewModel.orderHistory?.pending?[index].orderId}",
                                                          style: AppTextStyles.regular15,
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Date: ${viewModel.orderHistory?.pending?[index].createdAt}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Items: ${viewModel.orderHistory?.pending?[index].productCount}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Amount: Rs. ${viewModel.orderHistory?.pending?[index].grandTotal?.round()}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Type: ${viewModel.orderHistory?.pending?[index].orderType == 'delivery' ? 'Bulk Buy' : 'Pickup/Click & Collect'}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 9),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            if (DateTime.parse(
                                                                    viewModel.orderHistory!.pending![index].createdAt ??
                                                                        '')
                                                                .add(const Duration(minutes: 10))
                                                                .isAfter(DateTime.now())) ...[
                                                              GestureDetector(
                                                                onTap: () => viewModel.cancelOrder(
                                                                    viewModel.orderHistory!.pending![index]),
                                                                child: Container(
                                                                  height: 35,
                                                                  width: 100,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.grey0,
                                                                    borderRadius: BorderRadius.circular(20),
                                                                  ),
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: AppTextStyles.medium14
                                                                        .copyWith(color: AppColors.black),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 15),
                                                            ],
                                                            GestureDetector(
                                                              onTap: () => viewModel.openOrderDetail(
                                                                  viewModel.orderHistory?.pending?[index].orderId ?? '',
                                                                  viewModel.orderHistory?.pending?[index].mapLat,
                                                                  viewModel.orderHistory?.pending?[index].mapLong),
                                                              child: Container(
                                                                height: 35,
                                                                width: 100,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.secondary,
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Text(
                                                                  "Details",
                                                                  style: AppTextStyles.medium14
                                                                      .copyWith(color: AppColors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 12),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                            ),
                            Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: viewModel.isBusy
                                  ? const Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    )
                                  : viewModel.orderHistory == null ||
                                          (viewModel.orderHistory?.completed?.isEmpty ?? false)
                                      ? Center(
                                          child: Text(
                                            "No Data Found",
                                            style: AppTextStyles.regular16,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                viewModel.orderHistory?.completed?.length ?? 0,
                                                (index) => Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: index == 0
                                                        ? null
                                                        : Border(
                                                            top: BorderSide(
                                                                width: 1, color: AppColors.grey1.withOpacity(0.6)),
                                                          ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 18),
                                                        Text(
                                                          "Order no: ${viewModel.orderHistory?.completed?[index].orderId}",
                                                          style: AppTextStyles.regular15,
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Date: ${viewModel.orderHistory?.completed?[index].createdAt}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Items: ${viewModel.orderHistory?.completed?[index].productCount}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Amount: Rs. ${viewModel.orderHistory?.completed?[index].grandTotal?.round()}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Type: ${viewModel.orderHistory?.completed?[index].orderType == 'delivery' ? 'Bulk Buy' : 'Pickup/Click & Collect'}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 9),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () => viewModel.openOrderDetail(
                                                                  viewModel.orderHistory?.completed?[index].orderId ??
                                                                      '',
                                                                  viewModel.orderHistory?.completed?[index].mapLat,
                                                                  viewModel.orderHistory?.completed?[index].mapLong),
                                                              child: Container(
                                                                height: 35,
                                                                width: 100,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.secondary,
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Text(
                                                                  "Details",
                                                                  style: AppTextStyles.medium14
                                                                      .copyWith(color: AppColors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 12),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                            ),
                            Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: viewModel.isBusy
                                  ? const Center(
                                      child: CircularProgressIndicator(color: AppColors.primary),
                                    )
                                  : viewModel.orderHistory == null ||
                                          (viewModel.orderHistory?.cancelled?.isEmpty ?? false)
                                      ? Center(
                                          child: Text(
                                            "No Data Found",
                                            style: AppTextStyles.regular16,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                viewModel.orderHistory?.cancelled?.length ?? 0,
                                                (index) => Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: index == 0
                                                        ? null
                                                        : Border(
                                                            top: BorderSide(
                                                                width: 1, color: AppColors.grey1.withOpacity(0.6)),
                                                          ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: 18),
                                                        Text(
                                                          "Order no: ${viewModel.orderHistory?.cancelled?[index].orderId}",
                                                          style: AppTextStyles.regular15,
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Date: ${viewModel.orderHistory?.cancelled?[index].createdAt}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Items: ${viewModel.orderHistory?.cancelled?[index].productCount}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Total Amount: Rs. ${viewModel.orderHistory?.cancelled?[index].grandTotal?.round()}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Order Type: ${viewModel.orderHistory?.cancelled?[index].orderType == 'delivery' ? 'Bulk Buy' : 'Pickup/Click & Collect'}",
                                                          style:
                                                              AppTextStyles.regular14.copyWith(color: AppColors.grey1),
                                                        ),
                                                        const SizedBox(height: 9),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () => viewModel.openOrderDetail(
                                                                  viewModel.orderHistory?.cancelled?[index].orderId ??
                                                                      '',
                                                                  viewModel.orderHistory?.cancelled?[index].mapLat,
                                                                  viewModel.orderHistory?.cancelled?[index].mapLong),
                                                              child: Container(
                                                                height: 35,
                                                                width: 100,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.secondary,
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Text(
                                                                  "Details",
                                                                  style: AppTextStyles.medium14
                                                                      .copyWith(color: AppColors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 12),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                            ),
                          ]))
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
              const SizedBox(height: 67),
            ],
          ),
        ),
      ),
    );
  }
}
