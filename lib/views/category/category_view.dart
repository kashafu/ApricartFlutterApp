import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/viewmodels/category_viewmodel.dart';
import 'package:apricart/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_text_styles.dart';
import '../../shared/helpers.dart';
import '../../widgets/custom_carousel_slider.dart';
import '../../widgets/product_card.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewModel>.reactive(
      viewModelBuilder: () => CategoryViewModel(),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      onDispose: (viewModel) => viewModel.disposeViewModel(),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          if (viewModel.searchEnabled == true) {
            viewModel.disableSearch();
            FocusManager.instance.primaryFocus?.unfocus();
            return false;
          } else if (viewModel.currentViewType == CategoryViewType.products) {
            viewModel.currentViewType = CategoryViewType.main;
            viewModel.notifyListeners();
            return false;
          }
          return true;
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
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
                    if (viewModel.searchEnabled == true || viewModel.currentViewType == CategoryViewType.products)
                      Positioned(
                        left: 0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (viewModel.searchEnabled == true) {
                                viewModel.disableSearch();
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else if (viewModel.currentViewType == CategoryViewType.products) {
                                viewModel.currentViewType = CategoryViewType.main;
                                viewModel.notifyListeners();
                              }
                            },
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
                SearchBar(
                  controller: viewModel.searchController,
                  focusNode: viewModel.searchFocus,
                  onTap: () => viewModel.enableSearch(),
                  onChanged: (p0) => viewModel.search(),
                ),
                const SizedBox(height: 21),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white0,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: viewModel.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(color: AppColors.primary),
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: NotificationListener<ScrollEndNotification>(
                                  onNotification: (scrollEnd) {
                                    final metrics = scrollEnd.metrics;
                                    if (metrics.atEdge) {
                                      bool isTop = metrics.pixels < 20;
                                      if (isTop) {
                                        null;
                                      } else {
                                        viewModel.incrementProductPage();
                                      }
                                    }
                                    return true;
                                  },
                                  child: viewModel.searchEnabled
                                      ? viewModel.searchLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15),
                                                  ...List.generate(
                                                    viewModel.searchProducts.length,
                                                    (index) => GestureDetector(
                                                      onTap: () =>
                                                          viewModel.openProduct(viewModel.searchProducts[index]),
                                                      child: Container(
                                                        height: 60,
                                                        margin: const EdgeInsets.only(bottom: 10),
                                                        color: AppColors.white,
                                                        alignment: Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              height: double.maxFinite,
                                                              width: 90,
                                                              child: Center(
                                                                child: Image.network(
                                                                  viewModel.searchProducts[index].productImageUrl ?? '',
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      '${viewModel.searchProducts[index].title}\n',
                                                                      style: AppTextStyles.regular15,
                                                                      maxLines: 1,
                                                                      textAlign: TextAlign.start,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                    const SizedBox(height: 4),
                                                                    RichText(
                                                                      text: TextSpan(
                                                                        text: 'Rs: ',
                                                                        style: AppTextStyles.regular14,
                                                                        children: <TextSpan>[
                                                                          if (viewModel.searchProducts[index]
                                                                                      .specialPrice !=
                                                                                  null &&
                                                                              viewModel.searchProducts[index]
                                                                                      .specialPrice !=
                                                                                  0.0)
                                                                            TextSpan(
                                                                              text: (viewModel.searchProducts[index]
                                                                                          .currentPrice ??
                                                                                      0)
                                                                                  .toString(),
                                                                              style: AppTextStyles.regular14.copyWith(
                                                                                  color: Colors.red,
                                                                                  decoration:
                                                                                      TextDecoration.lineThrough),
                                                                            ),
                                                                          TextSpan(
                                                                            text:
                                                                                " ${(viewModel.searchProducts[index].specialPrice != null && viewModel.searchProducts[index].specialPrice != 0.0) ? (viewModel.searchProducts[index].specialPrice ?? 0).toString() : (viewModel.searchProducts[index].currentPrice ?? 0).toString()}",
                                                                            style: AppTextStyles.regular14,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                ],
                                              ),
                                            )
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 18),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 20),
                                              //   child: Row(
                                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              //     children: [
                                              //       Image.asset(
                                              //         Assets.onlineDelivery,
                                              //         width: 163,
                                              //       ),
                                              //       Image.asset(
                                              //         Assets.clickAndCollectMart,
                                              //         width: 163,
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              // const SizedBox(height: 5),
                                              // CustomCarouselSlider(
                                              //   items: viewModel.carousalItems,
                                              //   margin: 9,
                                              //   height: (screenWidth(context) - 18) * (143 / 376),
                                              //   indicatorDistance: 8,
                                              // ),

                                              //Filter bar
                                              if (viewModel.currentViewType == CategoryViewType.products) ...[
                                                // const SizedBox(height: 20),
                                                Container(
                                                  height: 35,
                                                  color: AppColors.white,
                                                  margin: const EdgeInsets.symmetric(horizontal: 23),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () => viewModel.showSortBottomSheet(context),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                Assets.sortIcon,
                                                                height: 15,
                                                              ),
                                                              const SizedBox(width: 10),
                                                              Text(
                                                                "Sort",
                                                                style: AppTextStyles.regular15,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        color: AppColors.grey1,
                                                        alignment: Alignment.center,
                                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              Assets.productFilterIcon,
                                                              height: 15,
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Text(
                                                              "Filter",
                                                              style: AppTextStyles.regular15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1,
                                                        color: AppColors.grey1,
                                                        alignment: Alignment.center,
                                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () => viewModel.toggleProductView(),
                                                              child: Image.asset(
                                                                viewModel.showlist == false
                                                                    ? Assets.listIcon
                                                                    : Assets.gridIcon,
                                                                height: 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                              ],

                                              //Products View
                                              if (viewModel.currentViewType == CategoryViewType.products) ...[
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  itemCount: viewModel.productList.length,
                                                  padding: const EdgeInsets.symmetric(horizontal: 23),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: viewModel.showlist ? 1 : 2,
                                                      mainAxisSpacing: 12,
                                                      crossAxisSpacing: 12,
                                                      childAspectRatio: 155 / (viewModel.showlist ? 110 : 225)),
                                                  itemBuilder: (_, index) => GestureDetector(
                                                    onTap: () => viewModel.openProduct(viewModel.productList[index]),
                                                    child: ProductCard(
                                                      product: viewModel.productList[index],
                                                      qty: viewModel.cartService
                                                          .getProductQuantityFromCart(viewModel.productList[index]),
                                                      onAdd: (product) => viewModel.addToCart(product),
                                                      onSub: (product) => viewModel.subtractFromCart(product),
                                                      isFavorite: viewModel.isFavorite(viewModel.productList[index]),
                                                      onFavTap: () =>
                                                          viewModel.markFavorite(viewModel.productList[index]),
                                                    ),
                                                  ),
                                                ),
                                              ],

                                              //Main Category View
                                              if (viewModel.currentViewType == CategoryViewType.main)
                                                ...List.generate(
                                                  viewModel.categories.length,
                                                  (index) => CategorySet(
                                                    categorySet: viewModel.categories[index],
                                                    onCategoryTap: (category) =>
                                                        viewModel.loadCategoryDetailProducts(category),
                                                  ),
                                                ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
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
        ),
      ),
    );
  }
}

class CategorySet extends StatelessWidget {
  final Categories categorySet;
  final Function(Categories) onCategoryTap;
  const CategorySet({
    Key? key,
    required this.categorySet,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              categorySet.name ?? '',
              style: AppTextStyles.bold22.copyWith(color: AppColors.blue0),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(
                    categorySet.childrenData?.length ?? 0,
                    (index) => GestureDetector(
                      onTap: () {
                        onCategoryTap(categorySet.childrenData![index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 22 : 15),
                        child: SizedBox(
                          height: 150,
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(categorySet.childrenData?[index].image ?? ''),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    categorySet.childrenData?[index].name ?? '',
                                    style: AppTextStyles.medium16.copyWith(color: AppColors.blue1),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ) +
                  [const SizedBox(width: 22)],
            ),
          ),
        ),
      ],
    );
  }
}
