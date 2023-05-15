// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final int qtdeInventario;
  final int qtdeDeposito;
  final String codigoProduto;
  ProductModel({
    this.id = 0,
    this.name = '',
    this.qtdeInventario = 0,
    this.qtdeDeposito = 0,
    this.codigoProduto = '',
  });

  ProductModel copyWith({
    int? id,
    String? name,
    int? qtdeInventario,
    int? qtdeDeposito,
    String? codigoProduto,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      qtdeInventario: qtdeInventario ?? this.qtdeInventario,
      qtdeDeposito: qtdeDeposito ?? this.qtdeDeposito,
      codigoProduto: codigoProduto ?? this.codigoProduto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qtdeInventario': qtdeInventario,
      'qtdeDeposito': qtdeDeposito,
      'codigoProduto': codigoProduto,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      qtdeInventario: (map['qtdeInventario'] ?? 0) as int,
      qtdeDeposito: (map['qtdeDeposito'] ?? 0) as int,
      codigoProduto: (map['codigoProduto'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, qtdeInventario: $qtdeInventario, qtdeDeposito: $qtdeDeposito, codigoProduto: $codigoProduto)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.qtdeInventario == qtdeInventario &&
        other.qtdeDeposito == qtdeDeposito &&
        other.codigoProduto == codigoProduto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        qtdeInventario.hashCode ^
        qtdeDeposito.hashCode ^
        codigoProduto.hashCode;
  }
}
