import 'package:apricart/constants/assets.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:apricart/viewmodels/home_viewmodel.dart';
import 'package:apricart/widgets/custom_carousel_slider.dart';
import 'package:apricart/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marquee/marquee.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/search_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      onModelReady: (viewModel) => viewModel.initializeViewModel(),
      onDispose: (viewModel) => viewModel.disposeViewModel(),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async {
          if (viewModel.searchEnabled == true) {
            viewModel.disableSearch();
            FocusManager.instance.primaryFocus?.unfocus();
            return false;
          } else if (viewModel.currentViewType == HomeViewType.categoryProductsMerged) {
            viewModel.currentViewType = HomeViewType.main;
            viewModel.notifyListeners();
            return false;
          } else if (viewModel.currentViewType == HomeViewType.category) {
            viewModel.currentViewType = HomeViewType.main;
            viewModel.notifyListeners();
            return false;
          } else if (viewModel.currentViewType == HomeViewType.categoryProducts) {
            if (viewModel.categoryDetailList.isEmpty) {
              viewModel.currentViewType = HomeViewType.main;
              viewModel.notifyListeners();
              return false;
            }
            viewModel.currentViewType = HomeViewType.category;
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
                    if (viewModel.searchEnabled == true ||
                        viewModel.currentViewType == HomeViewType.categoryProductsMerged ||
                        viewModel.currentViewType == HomeViewType.category ||
                        viewModel.currentViewType == HomeViewType.categoryProducts)
                      Positioned(
                        left: 0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (viewModel.searchEnabled == true) {
                                viewModel.disableSearch();
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else if (viewModel.currentViewType == HomeViewType.categoryProductsMerged) {
                                viewModel.currentViewType = HomeViewType.main;
                                viewModel.notifyListeners();
                              } else if (viewModel.currentViewType == HomeViewType.category) {
                                viewModel.currentViewType = HomeViewType.main;
                                viewModel.notifyListeners();
                              } else if (viewModel.currentViewType == HomeViewType.categoryProducts) {
                                if (viewModel.categoryDetailList.isEmpty) {
                                  viewModel.currentViewType = HomeViewType.main;
                                  viewModel.notifyListeners();
                                  return;
                                }
                                viewModel.currentViewType = HomeViewType.category;
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
                LocationPointer(),
                const SizedBox(height: 5),
                MovingTextBanner(
                  text: viewModel.data?.ticker ?? ' ',
                ),
                const SizedBox(height: 7),
                SearchBar(
                  controller: viewModel.searchController,
                  focusNode: viewModel.searchFocus,
                  onTap: () => viewModel.enableSearch(),
                  onChanged: (p0) => viewModel.search(),
                ),
                const SizedBox(height: 7),
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
                        child: viewModel.dataLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : viewModel.currentCity == null
                                ? const SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.topCenter,
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
                                                                    viewModel.searchProducts[index].productImageUrl ??
                                                                        '',
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        : Column(
                                            children: [
                                              if (viewModel.currentViewType == HomeViewType.categoryProducts ||
                                                  viewModel.currentViewType == HomeViewType.categoryProductsMerged) ...[
                                                const SizedBox(height: 20),
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
                                                const SizedBox(height: 1),
                                              ],
                                              if (viewModel.currentViewType == HomeViewType.categoryProductsMerged) ...[
                                                const SizedBox(height: 8),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: 8),
                                                        ...List.generate(
                                                          viewModel.mergeCategories.length,
                                                          (index) => GestureDetector(
                                                            onTap: () => viewModel.loadMergeCategoryProducts(
                                                                viewModel.mergeCategories[index]),
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 15, vertical: 9),
                                                              margin:
                                                                  EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                                                              decoration: BoxDecoration(
                                                                color: viewModel.mergeCategories[index].id ==
                                                                        (viewModel.selectedMergeCategory?.id ?? 0)
                                                                    ? Colors.blue[200]
                                                                    : AppColors.white,
                                                                borderRadius: BorderRadius.circular(7),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Text(
                                                                    viewModel.mergeCategories[index].name.toString(),
                                                                    style: AppTextStyles.regular14,
                                                                  ),
                                                                  const SizedBox(width: 5),
                                                                  GestureDetector(
                                                                    onTap: () =>
                                                                        viewModel.loadMergeMainCategoryProducts(
                                                                            viewModel.selectedMainCategory!),
                                                                    child: const Icon(
                                                                      Icons.close,
                                                                      size: 17,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                              Expanded(
                                                child: NotificationListener<ScrollEndNotification>(
                                                  onNotification: (scrollEnd) {
                                                    final metrics = scrollEnd.metrics;
                                                    if (metrics.atEdge) {
                                                      bool isTop = metrics.pixels < 20;
                                                      if (isTop) {
                                                        null;
                                                      } else {
                                                        if (viewModel.currentViewType ==
                                                            HomeViewType.categoryProducts) {
                                                          viewModel.incrementProductPage();
                                                        } else if (viewModel.currentViewType ==
                                                            HomeViewType.categoryProductsMerged) {
                                                          viewModel.incrementMergeProductPage();
                                                        }
                                                      }
                                                    }
                                                    return true;
                                                  },
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                            height: viewModel.currentViewType == HomeViewType.category
                                                                ? 18
                                                                : 11),

                                                        if (viewModel.currentViewType == HomeViewType.main)
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  height: 42,
                                                                  width: screenWidth(context, multiplier: 0.4),
                                                                  alignment: Alignment.center,
                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width: 1.5, color: AppColors.secondary),
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: DropdownButton<String>(
                                                                    isExpanded: true,
                                                                    underline: const SizedBox.shrink(),
                                                                    value: viewModel.selectedDropdownValue,
                                                                    hint: Container(
                                                                      height: 40,
                                                                      alignment: Alignment.center,
                                                                      child: Text(
                                                                        'Select',
                                                                        style: AppTextStyles.regular15,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    items: List.generate(
                                                                      2,
                                                                      (index) => DropdownMenuItem(
                                                                        value: [
                                                                          'Online Delivery',
                                                                          'Click & Collect Mart'
                                                                        ][index],
                                                                        child: Container(
                                                                          height: 50,
                                                                          alignment: Alignment.center,
                                                                          child: Text(
                                                                            [
                                                                              'Online Delivery',
                                                                              'Click & Collect Mart'
                                                                            ][index],
                                                                            style: AppTextStyles.regular15,
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onChanged: (selection) {
                                                                      if (selection == 'Online Delivery') {
                                                                        viewModel.selectOnlineDelivery();
                                                                      } else {
                                                                        viewModel.selectClickAndCollect();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                // GestureDetector(
                                                                //   onTap: () => viewModel.selectOnlineDelivery(),
                                                                //   child: Image.asset(
                                                                //     Assets.onlineDelivery,
                                                                //     width: 163,
                                                                //   ),
                                                                // ),
                                                                // GestureDetector(
                                                                //   onTap: () => viewModel.selectClickAndCollect(),
                                                                //   child: Image.asset(
                                                                //     Assets.clickAndCollectMart,
                                                                //     width: 163,
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),

                                                        // Carousal and Banners
                                                        if (viewModel.currentViewType == HomeViewType.main) ...[
                                                          const SizedBox(height: 5),
                                                          CustomCarouselSlider(
                                                            items: viewModel.carousalItems.isEmpty
                                                                ? <String>['']
                                                                : viewModel.carousalItems,
                                                            ids: viewModel.carousalItemIds,
                                                            margin: 9,
                                                            height: (screenWidth(context) - 18) * (143 / 376),
                                                            indicatorDistance: 8,
                                                            onBannerTap: (offerId) =>
                                                                viewModel.loadOfferProducts(offerId),
                                                          ),
                                                          const SizedBox(height: 13),
                                                        ],
                                                        if (viewModel.selectedCategoryBanner != null &&
                                                            viewModel.currentViewType == HomeViewType.category) ...[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: viewModel.selectedCategoryBanner!.isEmpty
                                                                    ? Container(
                                                                        height: 70,
                                                                        alignment: Alignment.center,
                                                                        color: AppColors.primary,
                                                                      )
                                                                    : Image.network(
                                                                        viewModel.selectedCategoryBanner ?? '')),
                                                          ),
                                                          const SizedBox(height: 7)
                                                        ],

                                                        //Category Prodcuts View
                                                        if (viewModel.currentViewType ==
                                                                HomeViewType.categoryProducts ||
                                                            viewModel.currentViewType ==
                                                                HomeViewType.categoryProductsMerged) ...[
                                                          GridView.builder(
                                                            shrinkWrap: true,
                                                            primary: false,
                                                            itemCount: viewModel.productList.length,
                                                            padding: const EdgeInsets.symmetric(horizontal: 23),
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount: viewModel.showlist ? 1 : 2,
                                                                mainAxisSpacing: 12,
                                                                crossAxisSpacing: 12,
                                                                childAspectRatio:
                                                                    155 / (viewModel.showlist ? 110 : 225)),
                                                            itemBuilder: (_, index) => GestureDetector(
                                                              onTap: () =>
                                                                  viewModel.openProduct(viewModel.productList[index]),
                                                              child: ProductCard(
                                                                product: viewModel.productList[index],
                                                                qty: viewModel.cartService.getProductQuantityFromCart(
                                                                    viewModel.productList[index]),
                                                                onAdd: (product) => viewModel.addToCart(product),
                                                                onSub: (product) => viewModel.subtractFromCart(product),
                                                                isFavorite:
                                                                    viewModel.isFavorite(viewModel.productList[index]),
                                                                onFavTap: () => viewModel
                                                                    .markFavorite(viewModel.productList[index]),
                                                              ),
                                                            ),
                                                          ),
                                                        ],

                                                        //Category Detail View
                                                        if (viewModel.currentViewType == HomeViewType.category) ...[
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 23),
                                                              child: Text(
                                                                viewModel.selectedCategoryName ?? '',
                                                                style: AppTextStyles.bold22
                                                                    .copyWith(color: AppColors.blue0),
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
                                                                      viewModel.categoryDetailList.length,
                                                                      (index) => Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: index == 0 ? 22 : 15),
                                                                        child: GestureDetector(
                                                                          onTap: () =>
                                                                              viewModel.loadCategoryDetailProducts(
                                                                                  viewModel.categoryDetailList[index]),
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
                                                                                  child: Image.network(viewModel
                                                                                          .categoryDetailList[index]
                                                                                          .image ??
                                                                                      ''),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      viewModel
                                                                                              .categoryDetailList[index]
                                                                                              .name ??
                                                                                          '',
                                                                                      style: AppTextStyles.medium16
                                                                                          .copyWith(
                                                                                              color: AppColors.blue1),
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
                                                          )
                                                        ],

                                                        // Main View
                                                        if (viewModel.currentViewType == HomeViewType.main) ...[
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 23)
                                                                .add(const EdgeInsets.only(right: 10)),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Shop By Category",
                                                                  style: AppTextStyles.bold22
                                                                      .copyWith(color: AppColors.blue0),
                                                                ),
                                                                const Spacer(),
                                                                Image.asset(
                                                                  Assets.filterIcon,
                                                                  width: 24,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 26),
                                                            child: GridView.count(
                                                              primary: false,
                                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                                              crossAxisCount: 4,
                                                              crossAxisSpacing: 7.5,
                                                              mainAxisSpacing: 12.5,
                                                              childAspectRatio: 80 / 120,
                                                              shrinkWrap: true,
                                                              children: List.generate(
                                                                viewModel.data?.categories?.length ?? 0,
                                                                (index) => LayoutBuilder(
                                                                  builder: (context, constraints) => GestureDetector(
                                                                    onTap: () => viewModel.loadCategoryDetail(
                                                                        viewModel.data!.categories![index]),
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                          height: constraints.maxWidth,
                                                                          width: constraints.maxWidth,
                                                                          clipBehavior: Clip.hardEdge,
                                                                          padding: const EdgeInsets.all(4),
                                                                          alignment: Alignment.center,
                                                                          decoration: const BoxDecoration(
                                                                            color: AppColors.white,
                                                                            shape: BoxShape.circle,
                                                                          ),
                                                                          child: Image.network(viewModel
                                                                                  .data?.categories?[index].image ??
                                                                              ''),
                                                                        ),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              viewModel.data?.categories?[index].name ??
                                                                                  '',
                                                                              style: AppTextStyles.medium12
                                                                                  .copyWith(color: AppColors.blue1),
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
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: List.generate(
                                                              viewModel.data?.products?.length ?? 0,
                                                              (index) => Padding(
                                                                padding: EdgeInsets.only(top: index == 0 ? 10 : 25),
                                                                child: FeaturedProductSet(
                                                                  product: viewModel.data!.products![index],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                        const SizedBox(height: 15.6),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
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
        ),
      ),
    );
  }
}

class FeaturedProductSet extends ViewModelWidget<HomeViewModel> {
  final HomeProducts product;

  const FeaturedProductSet({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (product.bannerImage != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: product.bannerImage!.isEmpty
                    ? Container(
                        height: 70,
                        alignment: Alignment.center,
                        color: AppColors.primary,
                      )
                    : Image.network(product.bannerImage ?? '')),
          ),
          const SizedBox(height: 16)
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              product.name ?? '',
              style: AppTextStyles.bold22.copyWith(color: AppColors.blue0),
            ),
          ),
        ),
        const SizedBox(height: 17),
        if (product.identifier == "otherstores")
          GestureDetector(
            // onTap: () => viewModel.submitAddress(),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 45,
                width: 220,
                margin: const EdgeInsets.only(bottom: 10, left: 23, right: 23),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Manual Order",
                  style: AppTextStyles.medium16.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        if (product.identifier != "otherstores")
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(
                      product.data?.length ?? 0,
                      (index) => GestureDetector(
                        onTap: () => viewModel.openProduct(product.data![index]),
                        child: Container(
                          height: 225,
                          width: 155,
                          margin: EdgeInsets.only(left: index == 0 ? 22 : 12),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: product.data?[index].productImageUrl == null ||
                                          (product.data?[index].productImageUrl?.isEmpty ?? true)
                                      ? null
                                      : Image.network(product.data?[index].productImageUrl ?? ''),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${product.data?[index].title}\n',
                                style: AppTextStyles.medium16,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7),
                              RichText(
                                text: TextSpan(
                                  text: 'Rs: ',
                                  style: AppTextStyles.regular14,
                                  children: <TextSpan>[
                                    if (product.data?[index].specialPrice != null &&
                                        product.data?[index].specialPrice != 0.0)
                                      TextSpan(
                                        text: (product.data?[index].currentPrice ?? 0).toString(),
                                        style: AppTextStyles.regular14
                                            .copyWith(color: Colors.red, decoration: TextDecoration.lineThrough),
                                      ),
                                    TextSpan(
                                      text:
                                          " ${(product.data?[index].specialPrice != null && product.data?[index].specialPrice != 0.0) ? (product.data?[index].specialPrice ?? 0).toString() : (product.data?[index].currentPrice ?? 0).toString()}",
                                      style: AppTextStyles.regular14,
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    if (viewModel.cartService.getProductQuantityFromCart(product.data![index]) == 0 &&
                                        product.data![index].inStock == false)
                                      GestureDetector(
                                        onTap: () {},
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              "Sold out",
                                              style: AppTextStyles.regular12.copyWith(color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (viewModel.cartService.getProductQuantityFromCart(product.data![index]) == 0 &&
                                        product.data![index].inStock == true)
                                      GestureDetector(
                                        onTap: () => viewModel.addToCart(product.data![index]),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Add to Cart",
                                            style: AppTextStyles.regular12.copyWith(color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                    if (viewModel.cartService.getProductQuantityFromCart(product.data![index]) > 0)
                                      Container(
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.secondary.withOpacity(0.5),
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () => viewModel.subtractFromCart(product.data![index]),
                                              child: Image.asset(
                                                Assets.removeCartIcon,
                                                height: 14,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 9),
                                              child: Text(
                                                viewModel.cartService
                                                    .getProductQuantityFromCart(product.data![index])
                                                    .toString(),
                                                style: AppTextStyles.regular14,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => viewModel.addToCart(product.data![index]),
                                              child: Image.asset(
                                                Assets.addCartIcon,
                                                height: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => viewModel.markFavorite(product.data![index]),
                                      child: Icon(
                                        viewModel.isFavorite(product.data![index])
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: viewModel.isFavorite(product.data![index])
                                            ? Colors.red[500]
                                            : AppColors.secondary,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) +
                    [
                      const SizedBox(width: 22),
                    ],
              ),
            ),
          ),
      ],
    );
  }
}

class ExclusiveOfferWidget extends StatelessWidget {
  const ExclusiveOfferWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 103.5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 1,
          color: AppColors.black.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(Assets.nationalIcon),
    );
  }
}

class LocationPointer extends ViewModelWidget<HomeViewModel> {
  const LocationPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: GestureDetector(
        onTap: () {
          if (viewModel.homeDataType != 'delivery') {
            viewModel.selectPickupAddress();
          } else {
            viewModel.selectDeliveryLocation();
          }
        },
        child: Row(
          children: [
            Image.asset(
              Assets.pointerIcon,
              width: 17,
              color: (viewModel.homeDataType != 'delivery' && viewModel.selectedPickupAddress == null)
                  ? Colors.transparent
                  : null,
            ),
            const SizedBox(width: 3),
            viewModel.isBusy
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                : Text(
                    viewModel.homeDataType == 'delivery'
                        ? (viewModel.currentCity ?? 'Unknown')
                        : (viewModel.selectedPickupAddress?.name ?? ''),
                    style: AppTextStyles.medium16,
                  ),
          ],
        ),
      ),
    );
  }
}

class MovingTextBanner extends StatelessWidget {
  final String text;
  const MovingTextBanner({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      alignment: Alignment.center,
      color: AppColors.secondary,
      child: Marquee(
        text: text,
        blankSpace: 40,
        style: AppTextStyles.regular9.copyWith(color: AppColors.white, letterSpacing: 0.18),
        velocity: 30,
        fadingEdgeStartFraction: 0.05,
        fadingEdgeEndFraction: 0.05,
      ),
    );
  }
}

// Align(
  //   alignment: Alignment.center,
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 22),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: List.generate(
  //           viewModel.topDeals.length,
  //           (index) => Padding(
  //             padding: EdgeInsets.only(left: index == 0 ? 0 : 7),
  //             child: Image.asset(
  //               viewModel.topDeals[index],
  //               height: 68,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   ),
  // ),
  // const SizedBox(height: 6),
  // Align(
  //   alignment: Alignment.centerLeft,
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 23),
  //     child: Text(
  //       "Exclusive Offer",
  //       style: AppTextStyles.bold22.copyWith(color: AppColors.blue0),
  //     ),
  //   ),
  // ),
  // const SizedBox(height: 6.75),
  // Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 22),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       ExclusiveOfferWidget(),
  //       ExclusiveOfferWidget(),
  //       ExclusiveOfferWidget(),
  //     ],
  //   ),
  // ),
  // const SizedBox(height: 15.6),
  // Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 22),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       ExclusiveOfferWidget(),
  //       ExclusiveOfferWidget(),
  //       ExclusiveOfferWidget(),
  //     ],
  //   ),
  // )
