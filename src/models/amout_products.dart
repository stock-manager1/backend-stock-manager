// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'deposit.dart';
import 'product.dart';

class AmountProduct {
  final Deposit idDepository;
  final Product idProduct;
  final int qntProduct;

  AmountProduct({
    required this.idDepository,
    required this.idProduct,
    this.qntProduct = 0,
  });

  AmountProduct copyWith({
    Deposit? idDepository,
    Product? idProduct,
    int? qntProduct,
  }) {
    return AmountProduct(
      idDepository: idDepository ?? this.idDepository,
      idProduct: idProduct ?? this.idProduct,
      qntProduct: qntProduct ?? this.qntProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDepository': idDepository.toMap(),
      'idProduct': idProduct.toMap(),
      'qntProduct': qntProduct,
    };
  }

  factory AmountProduct.fromMap(Map<String, dynamic> map) {
    return AmountProduct(
      idDepository:
          Deposit.fromMap(map['idDepository'] as Map<String, dynamic>),
      idProduct: Product.fromMap(map['idProduct'] as Map<String, dynamic>),
      qntProduct: (map['qntProduct'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountProduct.fromJson(String source) =>
      AmountProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductQuantity(idDepository: $idDepository, idProduct: $idProduct, qntProduct: $qntProduct)';

  @override
  bool operator ==(covariant AmountProduct other) {
    if (identical(this, other)) return true;

    return other.idDepository == idDepository &&
        other.idProduct == idProduct &&
        other.qntProduct == qntProduct;
  }

  @override
  int get hashCode =>
      idDepository.hashCode ^ idProduct.hashCode ^ qntProduct.hashCode;
}
