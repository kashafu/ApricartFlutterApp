import 'package:apricart/viewmodels/online_payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app.router.dart';
import '../../app/locator.dart';
import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class OnlinePaymentView extends StatelessWidget {
  final String webViewUrl;
  const OnlinePaymentView({
    Key? key,
    required this.webViewUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnlinePaymentViewModel>.nonReactive(
      viewModelBuilder: () => OnlinePaymentViewModel(),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          locator<NavigationService>().popUntil(ModalRoute.withName(Routes.navWrapperView));
          return false;
        },
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
                        onTap: () => locator<NavigationService>().popUntil(ModalRoute.withName(Routes.navWrapperView)),
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
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white0,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: WebView(
                    initialUrl: webViewUrl,
                    javascriptMode: JavascriptMode.unrestricted,
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
