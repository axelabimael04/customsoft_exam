import 'package:customsoft_exam/src/models/seller_contact_model.dart';

enum ProductType { auto, home, electronic }

class ProductModel {
  final String title;
  final String description;
  final List<String> images;
  final double amount;
  final double qualification;
  final int reviews;
  final String mapsURL;
  final ProductType type;
  final SellerContactModel sellerContactModel;

  ProductModel({
    required this.title,
    required this.description,
    required this.images,
    required this.amount,
    required this.qualification,
    required this.reviews,
    required this.mapsURL,
    required this.type,
    required this.sellerContactModel,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    try {
      ProductType productType = ProductType.values.firstWhere(
        (e) => e.toString() == "ProductType.${map['type'].toLowerCase()}",
        orElse: () => ProductType.auto,
      );
      return ProductModel(
        title: map['title'],
        description: map['description'],
        images: (map['images'] as List<dynamic>).map((e) => "$e").toList(),
        amount: double.parse(map['amount'].toString()),
        qualification: double.parse(map['qualification'].toString()),
        reviews: int.parse(map['reviews'].toString()),
        mapsURL: map['mapsURL'],
        type: productType,
        sellerContactModel: SellerContactModel.fromMap(map['seller_contact']),
      );
    } catch (e) {
      print("Error ProductModel.fromMap $e");
      print(map);
      throw e;
    }
  }
}
