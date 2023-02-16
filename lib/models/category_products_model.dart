import 'package:apricart/models/home_data_model.dart';

class MergeCategoryProducts {
  List<Categories> categories = <Categories>[];
  List<Products> products = <Products>[];
  MergeCategoryProducts({required this.categories, required this.products});

  MergeCategoryProducts.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      (json['categories'] as List).forEach((element) {
        categories.add(Categories.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      (json['products'] as List).forEach((element) {
        products.add(Products.fromJson(element));
      });
    }
  }
}
