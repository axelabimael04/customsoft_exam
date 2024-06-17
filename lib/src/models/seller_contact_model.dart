class SellerContactModel {
  final String name;
  final String phone;
  final String email;

  SellerContactModel({
    required this.name,
    required this.phone,
    required this.email,
  });

  factory SellerContactModel.fromMap(Map<String, dynamic> map) {
    try {
      return SellerContactModel(
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
      );
    } catch (e) {
      print("Error SellerContactModel.fromMap $e");
      throw e;
    }
  }
}
