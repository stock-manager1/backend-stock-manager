// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../models/product.dart';

class CustomProductResponse extends Product {
  final int amount;

  CustomProductResponse(
      this.amount, int id, String name, String brand, String type)
      : super(id: id, name: name, brand: brand, type: type);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'type': type,
      'amount': amount
    };
  }

}
