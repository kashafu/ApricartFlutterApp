import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/viewmodels/contact_us_viewmodel.dart';
import 'package:apricart/widgets/app_phone_field.dart';
import 'package:apricart/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';

class ContactUsview extends StatelessWidget {
  const ContactUsview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactUsViewModel>.reactive(
      viewModelBuilder: () => ContactUsViewModel(),
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            "Contact Us",
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
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 103,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: AppColors.grey0,
                              ),
                            ),
                            child: TextField(
                              controller: viewModel.commentController,
                              focusNode: viewModel.commentFocus,
                              style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                              expands: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  label: Text(
                                    "Type your Comments...",
                                    style: AppTextStyles.medium14.copyWith(color: AppColors.grey1.withOpacity(0.6)),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () => viewModel.sendContactUsInfo(),
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
                                      "Send",
                                      style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  Assets.phoneIcon,
                                  width: 15,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "03041110195",
                                  style: AppTextStyles.regular12.copyWith(color: AppColors.grey1),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                            color: AppColors.grey1.withOpacity(0.8),
                          ),
                          const SizedBox(height: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.emailIcon,
                                  width: 15,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "support@apricart.pk",
                                  style: AppTextStyles.regular12.copyWith(color: AppColors.grey1),
                                ),
                              ],
                            ),
                          )
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
