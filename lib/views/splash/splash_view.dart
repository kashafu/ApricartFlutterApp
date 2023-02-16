import 'package:apricart/app/locator.dart';
import 'package:apricart/constants/assets.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:apricart/viewmodels/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => locator<SplashViewModel>(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(context),
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.primary,
        body: SizedBox.expand(
          child: Column(
            children: [
              const Expanded(
                flex: 262,
                child: SizedBox.shrink(),
              ),
              Image.asset(
                Assets.appLogo,
                width: screenWidth(context, multiplier: 81 / 393),
              ),
              const Expanded(
                flex: 65,
                child: SizedBox.shrink(),
              ),
              Image.asset(
                Assets.appName,
                width: screenWidth(context, multiplier: 239 / 393),
              ),
              const Expanded(
                flex: 365,
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
