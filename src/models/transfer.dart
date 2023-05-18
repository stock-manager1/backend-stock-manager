// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transfer {
  final int idUser;
  final int idProduct;
  final int idOriginDepository;
  final int idDestinationDepository;
  final int qntItemsTransferred;
  final DateTime transferDate;
  Transfer({
    this.idUser = 0,
    this.idProduct = 0,
    this.idOriginDepository = 0,
    this.idDestinationDepository = 0,
    this.qntItemsTransferred = 0,
    required this.transferDate,
  });

  Transfer copyWith({
    int? idUser,
    int? idProduct,
    int? idOriginDepository,
    int? idDestinationDepository,
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
      'idUser': idUser,
      'idProduct': idProduct,
      'idOriginDepository': idOriginDepository,
      'idDestinationDepository': idDestinationDepository,
      'qntItemsTransferred': qntItemsTransferred,
      'transferDate': transferDate.millisecondsSinceEpoch,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      idUser: (map['idUser'] ?? 0) as int,
      idProduct: (map['idProduct'] ?? 0) as int,
      idOriginDepository: (map['idOriginDepository'] ?? 0) as int,
      idDestinationDepository: (map['idDestinationDepository'] ?? 0) as int,
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
