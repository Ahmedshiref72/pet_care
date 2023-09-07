import 'package:demo_project/src/models/productDetail_model.dart';

class GetProdByCatID {
  String? responseCode;
  String? message;
  List<Product>? products;
  String? status;

  GetProdByCatID({this.responseCode, this.message, this.products, this.status});

  GetProdByCatID.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}