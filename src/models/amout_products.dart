// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'deposit.dart';
import 'product.dart';

class AmountProducts {
  final Deposit idDepository;
  final Product idProduct;
  final int qntProduct;
  
  AmountProducts({
    required this.idDepository,
    required this.idProduct,
    this.qntProduct = 0,
  });

  AmountProducts copyWith({
    Deposit? idDepository,
    Product? idProduct,
    int? qntProduct,
  }) {
    return AmountProducts(
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

  factory AmountProducts.fromMap(Map<String, dynamic> map) {
    return AmountProducts(
      idDepository:
          Deposit.fromMap(map['idDepository'] as Map<String, dynamic>),
      idProduct: Product.fromMap(map['idProduct'] as Map<String, dynamic>),
      qntProduct: (map['qntProduct'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountProducts.fromJson(String source) =>
      AmountProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductQuantity(idDepository: $idDepository, idProduct: $idProduct, qntProduct: $qntProduct)';

  @override
  bool operator ==(covariant AmountProducts other) {
    if (identical(this, other)) return true;

    return other.idDepository == idDepository &&
        other.idProduct == idProduct &&
        other.qntProduct == qntProduct;
  }

  @override
  int get hashCode =>
      idDepository.hashCode ^ idProduct.hashCode ^ qntProduct.hashCode;
}
