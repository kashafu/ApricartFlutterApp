import 'package:apricart/constants/assets.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:apricart/viewmodels/nav_wrapper_viewmodel.dart';
import 'package:apricart/views/cart/cart_view.dart';
import 'package:apricart/views/category/category_view.dart';
import 'package:apricart/views/home/home_view.dart';
import 'package:apricart/views/shopping_list/shopping_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../more/more_view.dart';

class NavWrapperView extends StatelessWidget {
  const NavWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavWrapperViewModel>.reactive(
      viewModelBuilder: () => NavWrapperViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primary,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  child: viewModel.disengageHomeView
                      ? const SizedBox.shrink()
                      : _getViewForIndex(viewModel.navIndex, viewModel.navViewKeys),
                ),
                const SizedBox(height: 67),
              ],
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomNavBar(),
            ),
            Positioned(
              left: (screenWidth(context) - 74) / 2,
              bottom: 17.33,
              child: CartButton(
                cartCounter: viewModel.itemsInCart,
                onTap: () => viewModel.setNavIndex(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getViewForIndex(int index, List<Key> navViewKeys) {
    switch (index) {
      case 0:
        return HomeView(key: navViewKeys[0]);
      case 1:
        return CategoryView(key: navViewKeys[1]);
      case 2:
        return CartView(key: navViewKeys[2]);
      case 3:
        return ShoppingListView(key: navViewKeys[3]);
      case 4:
        return MoreView(key: navViewKeys[4]);
      default:
        return SizedBox.shrink();
    }
  }
}

class CartButton extends StatelessWidget {
  final int cartCounter;
  final VoidCallback? onTap;
  const CartButton({
    Key? key,
    this.onTap,
    required this.cartCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 74,
        height: 74,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 61,
          height: 61,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, top: 2),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        Assets.cartIcon,
                        width: 22,
                      ),
                      if (cartCounter != 0)
                        Positioned(
                          top: -7,
                          right: -9,
                          child: Container(
                            height: 19,
                            width: 19,
                            padding: const EdgeInsets.all(3.5),
                            decoration: const BoxDecoration(
                              color: AppColors.red,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              child: Text(
                                cartCounter.toString(),
                                style: AppTextStyles.medium12.copyWith(color: AppColors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  "Cart",
                  style: AppTextStyles.regular12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomNavBar extends ViewModelWidget<NavWrapperViewModel> {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, NavWrapperViewModel viewModel) {
    return Container(
      height: 67,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(flex: 340, child: SizedBox.shrink()),
                GestureDetector(
                  onTap: () {
                    viewModel.setNavIndex(0);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 1.37),
                      Image.asset(
                        Assets.homeIcon,
                        width: 24.25,
                      ),
                      const SizedBox(height: 3.37),
                      Text(
                        "Home",
                        style: AppTextStyles.regular12,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 229, child: SizedBox.shrink()),
                GestureDetector(
                  onTap: () {
                    viewModel.setNavIndex(1);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.categoryIcon,
                        width: 28,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Category",
                        style: AppTextStyles.regular12,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 146, child: SizedBox.shrink()),
              ],
            ),
          ),
          const SizedBox(width: 74),
          Expanded(
            child: Row(
              children: [
                const Expanded(flex: 126, child: SizedBox.shrink()),
                GestureDetector(
                  onTap: () {
                    viewModel.setNavIndex(3);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.shoppingListIcon,
                        width: 29.51,
                      ),
                      const SizedBox(height: 2.93),
                      Text(
                        "Shopping List",
                        style: AppTextStyles.regular12,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 210, child: SizedBox.shrink()),
                GestureDetector(
                  onTap: () {
                    viewModel.setNavIndex(4);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.profileIcon,
                        width: 34,
                      ),
                      const SizedBox(height: 1.44),
                      Text(
                        "More",
                        style: AppTextStyles.regular12,
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 580, child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
