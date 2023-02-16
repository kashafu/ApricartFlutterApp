import 'package:apricart/models/address_model.dart';
import 'package:apricart/viewmodels/add_address_viewmodel.dart';
import 'package:apricart/widgets/app_dropdown_field.dart';
import 'package:apricart/widgets/app_phone_field.dart';
import 'package:apricart/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class AddAddressView extends StatelessWidget {
  final Address? initialAddress;
  const AddAddressView({
    Key? key,
    this.initialAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isKeyboardActive = MediaQuery.of(context).viewInsets.bottom > 20;
    return ViewModelBuilder<AddAddressViewModel>.reactive(
      viewModelBuilder: () => AddAddressViewModel(context, initialAddress),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      onDispose: (viewModel) => viewModel.disposeViewModel(),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Add Delivery Address",
                          style: AppTextStyles.semibold22,
                        ),
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Deliver To",
                              style: AppTextStyles.medium14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        AppTextField(
                          label: "Name",
                          controller: viewModel.nameController,
                          focusNode: viewModel.nameFocus,
                        ),
                        const SizedBox(height: 11),
                        AppPhoneField(
                          controller: viewModel.phoneController,
                          focusNode: viewModel.phoneFocus,
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Deliver At",
                              style: AppTextStyles.medium14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        AppDropdownField(
                          label: "Select City",
                          onTap: () => viewModel.openCitySelectionDialog(),
                          data: viewModel.selectedCity?.city,
                        ),
                        const SizedBox(height: 11),
                        AppDropdownField(
                          label: "Select Area",
                          onTap: () => viewModel.openAreaSelectionDialog(),
                          data: viewModel.selectedArea?.town,
                        ),
                        const SizedBox(height: 11),
                        GestureDetector(
                          onTap: () => viewModel.selectLocation(context),
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11.5),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: AppColors.grey0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.selectedLocation ?? "Select Location",
                                    style: AppTextStyles.medium14.copyWith(
                                        color: viewModel.selectedLocation == null
                                            ? AppColors.grey1.withOpacity(0.6)
                                            : AppColors.black),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Image.asset(
                                  Assets.locationIcon,
                                  height: 16,
                                  color: AppColors.grey1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        AppTextField(
                          label: "Additional address details",
                          controller: viewModel.additionalDetailsController,
                          focusNode: viewModel.additionalDetailsFocus,
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () => viewModel.submitAddress(),
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
                                    "Confirm",
                                    style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (isKeyboardActive) const SizedBox(height: 250),
                      ],
                    ),
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
