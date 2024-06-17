import 'package:customsoft_exam/src/models/seller_contact_model.dart';

class ProductModel {
  final String title;
  final String description;
  final List<String> images;
  final double amount;
  final double qualification;
  final int reviews;
  final String mapsURL;
  final SellerContactModel sellerContactModel;

  ProductModel({
    required this.title,
    required this.description,
    required this.images,
    required this.amount,
    required this.qualification,
    required this.reviews,
    required this.mapsURL,
    required this.sellerContactModel,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    try {
      return ProductModel(
        title: map['title'],
        description: map['description'],
        images: (map['images'] as List<dynamic>).map((e) => "$e").toList(),
        amount: double.parse(map['amount'].toString()),
        qualification: double.parse(map['qualification'].toString()),
        reviews: int.parse(map['reviews'].toString()),
        mapsURL: map['mapsURL'],
        sellerContactModel: SellerContactModel.fromMap(map['seller_contact']),
      );
    } catch (e) {
      print("Error ProductModel.fromMap $e");
      print(map);
      throw e;
    }
  }
}
