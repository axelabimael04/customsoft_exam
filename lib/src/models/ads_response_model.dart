import 'package:customsoft_exam/src/models/product_model.dart';

class AdsResponseModel {
  final int items;
  final List<ProductModel> ads;

  AdsResponseModel({required this.items, required this.ads});

  factory AdsResponseModel.fromMap(Map<String, dynamic> map) {
    try {
      return AdsResponseModel(
        items: map['items'],
        ads: (map['ads'] as List<dynamic>).map(
          (e) {
            Map<String, dynamic> data = e as Map<String, dynamic>;
            return ProductModel.fromMap(data);
          },
        ).toList(),
      );
    } catch (e) {
      print("Error AdsResponseModel.fromMap $e");
      throw e;
    }
  }
}
