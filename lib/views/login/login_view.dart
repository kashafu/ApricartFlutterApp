import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/helpers.dart';
import '../../widgets/app_password_field.dart';
import '../../widgets/app_phone_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                            "Log In",
                            style: AppTextStyles.semibold22,
                          ),
                          const SizedBox(height: 25),
                          AppPhoneField(
                            controller: viewModel.phoneController,
                            focusNode: viewModel.phoneFocus,
                          ),
                          const SizedBox(height: 15),
                          AppPasswordField(
                            controller: viewModel.passwordController,
                            focusNode: viewModel.passwordFocus,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => viewModel.moveToForgotPasswordView(),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 42),
                                child: Text(
                                  "Forgot Password?",
                                  style: AppTextStyles.medium16.copyWith(
                                    color: AppColors.grey1.withOpacity(0.7),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 75),
                          GestureDetector(
                            onTap: () => viewModel.validateAndLogin(),
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
                                      "Log in",
                                      style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () => viewModel.moveToCreateAccountView(),
                            child: Text(
                              "Create Account",
                              style: AppTextStyles.regular12.copyWith(
                                color: AppColors.grey1,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
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
