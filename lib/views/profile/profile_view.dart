import 'package:apricart/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';
import '../../widgets/app_phone_field.dart';
import '../../widgets/app_text_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white0,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: viewModel.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Text(
                                  "Update Profile",
                                  style: AppTextStyles.semibold22,
                                ),
                                const SizedBox(height: 25),
                                AppTextField(
                                  label: "Name",
                                  controller: viewModel.nameController,
                                  focusNode: viewModel.nameFocus,
                                ),
                                const SizedBox(height: 15),
                                AppTextField(
                                  label: "Email",
                                  controller: viewModel.emailController,
                                  focusNode: viewModel.emailFocus,
                                ),
                                const SizedBox(height: 15),
                                AppPhoneField(
                                  controller: viewModel.phoneController,
                                  focusNode: viewModel.phoneFocus,
                                  isDisabled: true,
                                ),
                                const SizedBox(height: 45),
                                GestureDetector(
                                  onTap: () => viewModel.save(),
                                  child: Container(
                                    height: 50,
                                    width: 250,
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
                                            "Update",
                                            style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                          ),
                                  ),
                                ),
                              ],
                            ),
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
