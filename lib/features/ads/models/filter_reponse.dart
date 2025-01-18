import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';

class FilterResponse {
  int? totalSize;
  int? limit;
  int? offset;
  // double? minPrice;
  // double? maxPrice;
  List<Product> products = [];

  FilterResponse(
      {this.totalSize,
      this.limit,
      this.offset,
      // this.minPrice,
      // this.maxPrice,
      this.products = const []});

  FilterResponse.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    // minPrice = json['min_price'];
    // maxPrice = json['max_price'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }
}
