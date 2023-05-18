// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductQuantity {
  final int idDepository;
  final int idProduct;
  final int qntProduct;
  ProductQuantity({
    this.idDepository = 0,
    this.idProduct = 0,
    this.qntProduct = 0,
  });

  ProductQuantity copyWith({
    int? idDepository,
    int? idProduct,
    int? qntProduct,
  }) {
    return ProductQuantity(
      idDepository: idDepository ?? this.idDepository,
      idProduct: idProduct ?? this.idProduct,
      qntProduct: qntProduct ?? this.qntProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDepository': idDepository,
      'idProduct': idProduct,
      'qntProduct': qntProduct,
    };
  }

  factory ProductQuantity.fromMap(Map<String, dynamic> map) {
    return ProductQuantity(
      idDepository: (map['idDepository'] ?? 0) as int,
      idProduct: (map['idProduct'] ?? 0) as int,
      qntProduct: (map['qntProduct'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductQuantity.fromJson(String source) =>
      ProductQuantity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductQuantity(idDepository: $idDepository, idProduct: $idProduct, qntProduct: $qntProduct)';

  @override
  bool operator ==(covariant ProductQuantity other) {
    if (identical(this, other)) return true;

    return other.idDepository == idDepository &&
        other.idProduct == idProduct &&
        other.qntProduct == qntProduct;
  }

  @override
  int get hashCode =>
      idDepository.hashCode ^ idProduct.hashCode ^ qntProduct.hashCode;
}
