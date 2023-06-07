// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../models/product.dart';

class CustomProductResponse extends Product {
  final int amount;

  CustomProductResponse(
      int id, String name, String brand, String type, this.amount)
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

  factory CustomProductResponse.fromMap(Map<String, dynamic> map) {
    return CustomProductResponse(
      (map['id'] ?? 0) as int, 
      (map['name'] ?? '').toString(),
      (map['brand'] ?? '').toString(),
      (map['type'] ?? '').toString(),
      (map['amount'] ?? 0) as int
    );
  }

  factory CustomProductResponse.fromJson(String source) =>
      CustomProductResponse.fromMap(json.decode(source) as Map<String, dynamic>);

}
