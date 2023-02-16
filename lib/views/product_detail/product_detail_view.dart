import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/viewmodels/product_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

import '../../constants/assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/helpers.dart';

class ProductDetailView extends StatelessWidget {
  final String sku;
  const ProductDetailView({
    Key? key,
    required this.sku,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (viewModel) => viewModel.loadProductData(sku),
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
                        : viewModel.prodData == null
                            ? Center(
                                child: Text(
                                  'No Data Found',
                                  style: AppTextStyles.semibold18,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        height: 190,
                                        width: double.maxFinite,
                                        child: Center(
                                          child: GestureDetector(
                                              onTap: () => Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) => Scaffold(
                                                        backgroundColor: AppColors.black,
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
                                                                        color: Colors.transparent,
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
                                                                        height: 12,
                                                                        margin: const EdgeInsets.only(left: 20),
                                                                        alignment: Alignment.center,
                                                                        color: Colors.transparent,
                                                                        child: Image.asset(
                                                                          Assets.arrowBackIcon,
                                                                          color: AppColors.white,
                                                                          height: 12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: PhotoView(
                                                                imageProvider: NetworkImage(
                                                                    viewModel.prodData!.productImageUrl ?? ''),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              child: Image.network(viewModel.prodData!.productImageUrl ?? '')),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        viewModel.prodData!.title ?? '',
                                        style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                                      ),
                                      const SizedBox(height: 12),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Rs: ',
                                          style: AppTextStyles.regular14,
                                          children: <TextSpan>[
                                            if (viewModel.prodData!.specialPrice != null &&
                                                viewModel.prodData!.specialPrice != 0.0)
                                              TextSpan(
                                                text: (viewModel.prodData!.currentPrice ?? 0).toString(),
                                                style: AppTextStyles.regular14.copyWith(
                                                    color: Colors.red, decoration: TextDecoration.lineThrough),
                                              ),
                                            TextSpan(
                                              text:
                                                  " ${(viewModel.prodData!.specialPrice != null && viewModel.prodData!.specialPrice != 0.0) ? (viewModel.prodData!.specialPrice ?? 0).toString() : (viewModel.prodData!.currentPrice ?? 0).toString()}",
                                              style: AppTextStyles.regular14,
                                            ),
                                          ],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                        viewModel.prodData!.description ?? '',
                                        style: AppTextStyles.regular14.copyWith(color: AppColors.black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        viewModel.prodData!.sku ?? '',
                                        style: AppTextStyles.regular14
                                            .copyWith(fontSize: 13, color: AppColors.grey1.withOpacity(0.8)),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Container(
                                            height: 38,
                                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    viewModel.decrementQuantity();
                                                  },
                                                  child: Image.asset(
                                                    Assets.removeCartIcon,
                                                    height: 25,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 13),
                                                  child: Text(
                                                    viewModel.qty.toString(),
                                                    style: AppTextStyles.regular14,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    viewModel.incrementQuantity();
                                                  },
                                                  child: Image.asset(
                                                    Assets.addCartIcon,
                                                    height: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => viewModel.addQtyToCart(),
                                              child: Container(
                                                height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  'Add to Cart',
                                                  style: AppTextStyles.medium16.copyWith(color: AppColors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (viewModel.recommendedProducts.isNotEmpty)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Recommended',
                                              style: AppTextStyles.bold22.copyWith(color: AppColors.blue0),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(height: 17),
                                      if (viewModel.recommendedProducts.isNotEmpty)
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List<Widget>.generate(
                                                viewModel.recommendedProducts.length,
                                                (index) => GestureDetector(
                                                  onTap: () =>
                                                      viewModel.openProduct(viewModel.recommendedProducts[index]),
                                                  child: Container(
                                                    height: 225,
                                                    width: 155,
                                                    // margin: EdgeInsets.only(left: index == 0 ? 22 : 12),
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
                                                            child:
                                                                viewModel.recommendedProducts[index].productImageUrl ==
                                                                            null ||
                                                                        (viewModel.recommendedProducts[index]
                                                                                .productImageUrl?.isEmpty ??
                                                                            true)
                                                                    ? null
                                                                    : Image.network(viewModel.recommendedProducts[index]
                                                                            .productImageUrl ??
                                                                        ''),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Text(
                                                          '${viewModel.recommendedProducts[index].title}\n',
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
                                                              if (viewModel.recommendedProducts[index].specialPrice !=
                                                                      null &&
                                                                  viewModel.recommendedProducts[index].specialPrice !=
                                                                      0.0)
                                                                TextSpan(
                                                                  text: (viewModel.recommendedProducts[index]
                                                                              .currentPrice ??
                                                                          0)
                                                                      .toString(),
                                                                  style: AppTextStyles.regular14.copyWith(
                                                                      color: Colors.red,
                                                                      decoration: TextDecoration.lineThrough),
                                                                ),
                                                              TextSpan(
                                                                text:
                                                                    " ${(viewModel.recommendedProducts[index].specialPrice != null && viewModel.recommendedProducts[index].specialPrice != 0.0) ? (viewModel.recommendedProducts[index].specialPrice ?? 0).toString() : (viewModel.recommendedProducts[index].currentPrice ?? 0).toString()}",
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
                                                              if (viewModel.cartService.getProductQuantityFromCart(
                                                                      viewModel.recommendedProducts[index]) ==
                                                                  0)
                                                                GestureDetector(
                                                                  onTap: () => viewModel
                                                                      .addToCart(viewModel.recommendedProducts[index]),
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: 7, vertical: 5),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.secondary,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                    ),
                                                                    child: Text(
                                                                      "Add to Cart",
                                                                      style: AppTextStyles.regular12
                                                                          .copyWith(color: AppColors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (viewModel.cartService.getProductQuantityFromCart(
                                                                      viewModel.recommendedProducts[index]) >
                                                                  0)
                                                                Container(
                                                                  height: 30,
                                                                  padding: const EdgeInsets.symmetric(
                                                                      horizontal: 7, vertical: 5),
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
                                                                        onTap: () => viewModel.subtractFromCart(
                                                                            viewModel.recommendedProducts[index]),
                                                                        child: Image.asset(
                                                                          Assets.removeCartIcon,
                                                                          height: 14,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 9),
                                                                        child: Text(
                                                                          viewModel.cartService
                                                                              .getProductQuantityFromCart(
                                                                                  viewModel.recommendedProducts[index])
                                                                              .toString(),
                                                                          style: AppTextStyles.regular14,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () => viewModel.addToCart(
                                                                            viewModel.recommendedProducts[index]),
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
                                                                onTap: () => viewModel
                                                                    .markFavorite(viewModel.recommendedProducts[index]),
                                                                child: Icon(
                                                                  viewModel.isFavorite(
                                                                          viewModel.recommendedProducts[index])
                                                                      ? Icons.favorite
                                                                      : Icons.favorite_outline,
                                                                  color: viewModel.isFavorite(
                                                                          viewModel.recommendedProducts[index])
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
                                              ),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(height: 20),
                                    ],
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
            const SizedBox(height: 67),
          ],
        ),
      ),
    );
  }
}
