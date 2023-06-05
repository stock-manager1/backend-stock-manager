// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'deposit.dart';
import 'product.dart';

class AmountProduct {
  final int idDeposit;
  final int idProduct;
  final int amount;
  
  AmountProduct({
    required this.idDeposit,
    required this.idProduct,
    required this.amount,
  });

  

  AmountProduct copyWith({
    int? idDeposit,
    int? idProduct,
    int? amount,
  }) {
    return AmountProduct(
      idDeposit: idDeposit ?? this.idDeposit,
      idProduct: idProduct ?? this.idProduct,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDeposit': idDeposit,
      'idProduct': idProduct,
      'amount': amount,
    };
  }

  factory AmountProduct.fromMap(Map<String, dynamic> map) {
    return AmountProduct(
      idDeposit: map['idDeposit'] as int,
      idProduct: map['idProduct'] as int,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountProduct.fromJson(String source) => AmountProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AmountProduct(idDeposit: $idDeposit, idProduct: $idProduct, amount: $amount)';

  @override
  bool operator ==(covariant AmountProduct other) {
    if (identical(this, other)) return true;
  
    return 
      other.idDeposit == idDeposit &&
      other.idProduct == idProduct &&
      other.amount == amount;
  }

  @override
  int get hashCode => idDeposit.hashCode ^ idProduct.hashCode ^ amount.hashCode;
}
