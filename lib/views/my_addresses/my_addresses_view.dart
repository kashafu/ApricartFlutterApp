import 'package:apricart/viewmodels/my_addresses_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class MyAddressesView extends StatelessWidget {
  const MyAddressesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAddressesViewModel>.reactive(
      viewModelBuilder: () => MyAddressesViewModel(),
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
                child: viewModel.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Text(
                                  "My Addresses",
                                  style: AppTextStyles.semibold22,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => viewModel.moveToAddAddressView(),
                                  child: Container(
                                    height: 32,
                                    width: 130,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "Add Address",
                                      style: AppTextStyles.medium14.copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  viewModel.addresses.length,
                                  (index) => GestureDetector(
                                    onTap: () => viewModel.saveAddress(viewModel.addresses[index]),
                                    child: Container(
                                      height: 85,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        border: Border(
                                          top: BorderSide(width: 1, color: AppColors.grey0),
                                          bottom: BorderSide(width: 1, color: AppColors.grey0),
                                          left: BorderSide(width: 1, color: AppColors.grey0),
                                          right: BorderSide(width: 1, color: AppColors.grey0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          IgnorePointer(
                                            ignoring: true,
                                            child: Radio<int?>(
                                              value: viewModel.addresses[index].id,
                                              groupValue: viewModel.selectedAddress?.id,
                                              onChanged: (value) {},
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              viewModel.addresses[index].address ?? 'unknown',
                                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () =>
                                                viewModel.moveToAddAddressViewForEditting(viewModel.addresses[index]),
                                            child: Image.asset(
                                              Assets.editIcon,
                                              height: 20,
                                              color: AppColors.grey1,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          GestureDetector(
                                            onTap: () => viewModel.deleteAddress(viewModel.addresses[index].id),
                                            child: Image.asset(
                                              Assets.deleteIcon,
                                              height: 20,
                                              color: AppColors.grey1,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
