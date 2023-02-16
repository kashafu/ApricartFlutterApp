import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/more_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreViewModel>.reactive(
      viewModelBuilder: () => MoreViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
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
                // Positioned(
                //   left: 0,
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Container(
                //       width: 40,
                //       height: 12,
                //       margin: const EdgeInsets.only(left: 20),
                //       alignment: Alignment.center,
                //       color: Colors.transparent,
                //       child: Image.asset(
                //         Assets.arrowBackIcon,
                //         height: 12,
                //       ),
                //     ),
                //   ),
                // ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 15),
                      CustomListTile(
                        icon: Assets.moreProfileIcon,
                        title: "My Profile",
                        onTap: () => viewModel.openProfileView(),
                      ),
                      CustomListTile(
                        icon: Assets.myOrdersIcon,
                        title: "My Orders",
                        onTap: () => viewModel.openOrderHistoryView(),
                      ),
                      CustomListTile(
                        icon: Assets.shoppingListIcon,
                        title: "Shopping List",
                      ),
                      CustomListTile(
                        icon: Assets.gearIcon,
                        title: "Change Password",
                      ),
                      CustomListTile(
                        icon: Assets.myAddressesIcon,
                        title: "My Address",
                        onTap: () => viewModel.openMyAddressesView(),
                      ),
                      CustomListTile(
                        icon: Assets.faqsIcon,
                        title: "Help & FAQ's",
                        onTap: () => viewModel.launch("https://apricart.pk/faqs-mobile"),
                      ),
                      CustomListTile(
                        icon: Assets.contactUsIcon,
                        title: "Contact Us",
                        onTap: () => viewModel.openContactUsView(),
                      ),
                      CustomListTile(
                        icon: Assets.contactUsIcon,
                        title: "Change User Type",
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => viewModel.loginLogoutUser(),
                        child: Container(
                          height: 50,
                          width: 250,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (viewModel.userData != null) ...[
                                Image.asset(
                                  Assets.logoutIcon,
                                  height: 20,
                                ),
                                const SizedBox(width: 12)
                              ],
                              Text(
                                viewModel.userData == null ? "Log in" : "Log out",
                                style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Follow Us",
                        style: AppTextStyles.bold16.copyWith(color: AppColors.black),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => viewModel.launch("https://fb.com/apricartonlinegrocery"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                Assets.facebookIcon,
                                width: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => viewModel.launch("https://instagram.com/apricart.pk"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                Assets.instaIcon,
                                width: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => viewModel.launch("http://m.me/apricartonlinegrocery"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                Assets.messengerIcon,
                                width: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => viewModel.launch("https://twitter.com/ApricartPk"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                Assets.twitterIcon,
                                width: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => viewModel.launch("https://wa.link/nfv3vo"),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                Assets.whatsappIcon,
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => viewModel.launch("https://apricart.pk/terms-of-use-mobile"),
                            child: Text(
                              "Terms of use",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.blue0.withOpacity(0.35)),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blue0.withOpacity(0.35),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => viewModel.launch("https://apricart.pk/privacy-policy-mobile"),
                            child: Text(
                              "Privacy Policy",
                              style: AppTextStyles.regular14.copyWith(color: AppColors.blue0.withOpacity(0.45)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "App Version: 26-1.0.26",
                        style: AppTextStyles.semibold14.copyWith(color: AppColors.black.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(top: 10)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.blue0.withOpacity(0.3), width: 1),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 25),
            Text(
              title,
              style: AppTextStyles.medium14.copyWith(color: AppColors.black.withOpacity(0.5)),
            ),
            const Spacer(),
            Image.asset(
              Assets.arrowRightIcon,
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}
