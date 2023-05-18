// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import './user.dart';
import 'deposit.dart';
import 'product.dart';

class Transfer {
  final Users idUser;
  final Product idProduct;
  final Deposit idOriginDepository;
  final Deposit idDestinationDepository;
  final int qntItemsTransferred;
  final DateTime transferDate;

  Transfer({
    required this.idUser,
    required this.idProduct,
    required this.idOriginDepository,
    required this.idDestinationDepository,
    this.qntItemsTransferred = 0,
    required this.transferDate,
  });

  Transfer copyWith({
    Users? idUser,
    Product? idProduct,
    Deposit? idOriginDepository,
    Deposit? idDestinationDepository,
    int? qntItemsTransferred,
    DateTime? transferDate,
  }) {
    return Transfer(
      idUser: idUser ?? this.idUser,
      idProduct: idProduct ?? this.idProduct,
      idOriginDepository: idOriginDepository ?? this.idOriginDepository,
      idDestinationDepository:
          idDestinationDepository ?? this.idDestinationDepository,
      qntItemsTransferred: qntItemsTransferred ?? this.qntItemsTransferred,
      transferDate: transferDate ?? this.transferDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser.toMap(),
      'idProduct': idProduct.toMap(),
      'idOriginDepository': idOriginDepository.toMap(),
      'idDestinationDepository': idDestinationDepository.toMap(),
      'qntItemsTransferred': qntItemsTransferred,
      'transferDate': transferDate.millisecondsSinceEpoch,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      idUser: Users.fromMap(map['idUser'] as Map<String, dynamic>),
      idProduct: Product.fromMap(map['idProduct'] as Map<String, dynamic>),
      idOriginDepository:
          Deposit.fromMap(map['idOriginDepository'] as Map<String, dynamic>),
      idDestinationDepository: Deposit.fromMap(
          map['idDestinationDepository'] as Map<String, dynamic>),
      qntItemsTransferred: (map['qntItemsTransferred'] ?? 0) as int,
      transferDate: DateTime.fromMillisecondsSinceEpoch(
          (map['transferDate'] ?? 0) as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transfer(idUser: $idUser, idProduct: $idProduct, idOriginDepository: $idOriginDepository, idDestinationDepository: $idDestinationDepository, qntItemsTransferred: $qntItemsTransferred, transferDate: $transferDate)';
  }

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) return true;

    return other.idUser == idUser &&
        other.idProduct == idProduct &&
        other.idOriginDepository == idOriginDepository &&
        other.idDestinationDepository == idDestinationDepository &&
        other.qntItemsTransferred == qntItemsTransferred &&
        other.transferDate == transferDate;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        idProduct.hashCode ^
        idOriginDepository.hashCode ^
        idDestinationDepository.hashCode ^
        qntItemsTransferred.hashCode ^
        transferDate.hashCode;
  }
}
