import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/order_placed_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class OrderPlacedView extends StatefulWidget {
  final String message;
  final String? lat;
  final String? long;
  const OrderPlacedView({Key? key, required this.message, this.lat, this.long}) : super(key: key);

  @override
  State<OrderPlacedView> createState() => _OrderPlacedViewState();
}

class _OrderPlacedViewState extends State<OrderPlacedView> with TickerProviderStateMixin {
  FlutterGifController? controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderPlacedViewModel>.reactive(
      viewModelBuilder: () => OrderPlacedViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(controller),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          locator<NavigationService>().popUntil(ModalRoute.withName(Routes.navWrapperView));
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: viewModel.videoController!,
                // showVideoProgressIndicator: true,
                width: screenWidth(context) - 60,
                onEnded: (metaData) {
                  viewModel.videoController?.seekTo(Duration(seconds: 0));
                  viewModel.videoController?.pause();
                },
                // bottomActions: [
                //   ProgressBar(),
                // ],
              ),
              onExitFullScreen: () => SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.manual,
                overlays: [
                  SystemUiOverlay.top,
                  SystemUiOverlay.bottom,
                ],
              ),
              builder: (context, player) => Column(
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
                            onTap: () =>
                                locator<NavigationService>().popUntil(ModalRoute.withName(Routes.navWrapperView)),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white0,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                viewModel.dataService.homeDataType == 'delivery'
                                    ? "Bulk Order"
                                    : "Apricart Click & Collect Store",
                                style: AppTextStyles.medium16,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                  width: screenWidth(context, multiplier: 0.55),
                                  child: GifImage(image: AssetImage(Assets.thankyouGif), controller: controller!)),
                              HtmlWidget(
                                widget.message,
                                customStylesBuilder: (element) {
                                  return {'text-align': 'center'};
                                },
                              ),
                              if (viewModel.dataService.homeDataType == 'pickup') ...[
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () => viewModel.openLocation(widget.lat, widget.long),
                                  child: Container(
                                    height: 38,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "Pickup Location",
                                      style: AppTextStyles.medium14.copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 20),
                              if (viewModel.videoId != null && viewModel.videoController != null) ...[
                                player,
                                const SizedBox(height: 20),
                              ],
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
        ),
      ),
    );
  }
}
