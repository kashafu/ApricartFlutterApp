import 'package:apricart/viewmodels/forgot_password_viewmodel.dart';
import 'package:apricart/widgets/app_phone_field.dart';
import 'package:apricart/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';
import '../../widgets/app_password_field.dart';
import '../../widgets/code_box.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
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
                            "Forgot your Password?",
                            style: AppTextStyles.semibold22,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Enter your mobile number for OTP\nverification",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.grey1.withOpacity(0.8)),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 40),
                          AppPhoneField(
                            controller: viewModel.phoneController,
                            focusNode: viewModel.phoneFocus,
                          ),
                          if (viewModel.otpSent == true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 18),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Didn't receive code? ",
                                      style: AppTextStyles.regular14.copyWith(color: AppColors.grey1.withOpacity(0.8)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Resend",
                                            style: AppTextStyles.regular14.copyWith(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()..onTap = () => viewModel.sendOtp()),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                AppPasswordField(
                                  label: 'Please reset your new password',
                                  controller: viewModel.passwordController,
                                  focusNode: viewModel.passwordFocus,
                                ),
                                const SizedBox(height: 22),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: SizedBox(
                                    width: 240,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Enter Verification Code",
                                            style: AppTextStyles.regular14
                                                .copyWith(color: AppColors.grey1.withOpacity(0.8)),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            4,
                                            (index) => CodeBox(
                                              controller: viewModel.codeControllers[index],
                                              focusNode: viewModel.codeFocusNodes[index],
                                              onChanged: (value) {
                                                if (value.length > 1 && index != 3) {
                                                  final text = value;
                                                  viewModel.codeControllers[index].text = text[0];
                                                  viewModel.codeControllers[index + 1].text = text[1];
                                                  FocusScope.of(context)
                                                      .requestFocus(viewModel.codeFocusNodes[index + 1]);
                                                } else if (value.length > 1 && index == 3) {
                                                  final text = value;
                                                  viewModel.codeControllers[index].text = text[1];
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                } else if (value.isEmpty &&
                                                    index != 0 &&
                                                    viewModel.previousValues[index].isEmpty) {
                                                  viewModel.codeControllers[index - 1].text = '';
                                                  FocusScope.of(context)
                                                      .requestFocus(viewModel.codeFocusNodes[index - 1]);
                                                } else if (value.isNotEmpty && index != 3) {
                                                  FocusScope.of(context)
                                                      .requestFocus(viewModel.codeFocusNodes[index + 1]);
                                                  viewModel.codeControllers[index + 1].selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: viewModel.codeControllers[index + 1].text.length);
                                                } else if (value.isNotEmpty && index == 3) {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                }
                                                viewModel.updatePreviousValue();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          const SizedBox(height: 27),
                          GestureDetector(
                            onTap: () {
                              if (viewModel.otpSent) {
                                viewModel.changePassword();
                              } else {
                                viewModel.sendOtp();
                              }
                            },
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
                                      viewModel.otpSent ? "Update Password" : "Send OTP",
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
