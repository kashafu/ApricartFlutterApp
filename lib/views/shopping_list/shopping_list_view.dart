import 'package:apricart/viewmodels/shopping_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';
import '../../widgets/product_card.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShoppingListViewModel>.reactive(
      viewModelBuilder: () => ShoppingListViewModel(),
      onModelReady: (viewModel) => viewModel.initiallizeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
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
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: AppColors.white0,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: viewModel.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : viewModel.shoppingList.isEmpty
                            ? Center(
                                child: Text(
                                  'No Items Found',
                                  style: AppTextStyles.semibold18,
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    ...[
                                      GridView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: viewModel.shoppingList.length,
                                        padding: const EdgeInsets.symmetric(horizontal: 23),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 12,
                                            crossAxisSpacing: 12,
                                            childAspectRatio: 155 / 225),
                                        itemBuilder: (_, index) => GestureDetector(
                                          onTap: () => viewModel.openProduct(viewModel.shoppingList[index]),
                                          child: ProductCard(
                                            product: viewModel.shoppingList[index],
                                            qty: viewModel.cartService
                                                .getProductQuantityFromCart(viewModel.shoppingList[index]),
                                            onAdd: (product) => viewModel.addToCart(product),
                                            onSub: (product) => viewModel.subtractFromCart(product),
                                            isFavorite: viewModel.isFavorite(viewModel.shoppingList[index]),
                                            onFavTap: () => viewModel.markFavorite(viewModel.shoppingList[index]),
                                          ),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                  ),
                  if (viewModel.isLoading)
                    Positioned.fill(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: const CircularProgressIndicator(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
