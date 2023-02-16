import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/assets.dart';
import '../models/home_data_model.dart';
import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final int qty;
  final Function(Products)? onAdd;
  final Function(Products)? onSub;
  final bool isFavorite;
  final VoidCallback? onFavTap;
  const ProductCard({
    Key? key,
    required this.product,
    required this.qty,
    this.onAdd,
    this.onSub,
    required this.isFavorite,
    this.onFavTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: product.productImageUrl == null || (product.productImageUrl?.isEmpty ?? true)
                  ? null
                  : Image.network(product.productImageUrl ?? ''),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${product.title}\n',
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
                if (product.specialPrice != null && product.specialPrice != 0.0)
                  TextSpan(
                    text: (product.currentPrice ?? 0).toString(),
                    style: AppTextStyles.regular14.copyWith(color: Colors.red, decoration: TextDecoration.lineThrough),
                  ),
                TextSpan(
                  text:
                      " ${(product.specialPrice != null && product.specialPrice != 0.0) ? (product.specialPrice ?? 0).toString() : (product.currentPrice ?? 0).toString()}",
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
                if (qty == 0 && product.inStock == false)
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
                if (qty == 0 && product.inStock == true)
                  GestureDetector(
                    onTap: () {
                      if (onAdd != null) {
                        onAdd!(product);
                      }
                    },
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
                if (qty > 0)
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
                          onTap: () {
                            if (onSub != null) {
                              onSub!(product);
                            }
                          },
                          child: Image.asset(
                            Assets.removeCartIcon,
                            height: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text(
                            qty.toString(),
                            style: AppTextStyles.regular14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (onAdd != null) {
                              onAdd!(product);
                            }
                          },
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
                  onTap: onFavTap,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.red[500] : AppColors.secondary,
                    size: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
