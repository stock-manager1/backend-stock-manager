// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductDTO {
  final int? id;
  final String? name;
  final int? qtdeInventario;
  final int? qtdeDeposito;
  final String? codigoProduto;
  ProductDTO({
    this.id,
    this.name,
    this.qtdeInventario,
    this.qtdeDeposito,
    this.codigoProduto,
  });

  ProductDTO copyWith({
    int? id,
    String? name,
    int? qtdeInventario,
    int? qtdeDeposito,
    String? codigoProduto,
  }) {
    return ProductDTO(
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

  factory ProductDTO.fromMap(Map<String, dynamic> map) {
    return ProductDTO(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      qtdeInventario:
          map['qtdeInventario'] != null ? map['qtdeInventario'] as int : null,
      qtdeDeposito:
          map['qtdeDeposito'] != null ? map['qtdeDeposito'] as int : null,
      codigoProduto:
          map['codigoProduto'] != null ? map['codigoProduto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDTO.fromJson(String source) =>
      ProductDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductDTO(id: $id, name: $name, qtdeInventario: $qtdeInventario, qtdeDeposito: $qtdeDeposito, codigoProduto: $codigoProduto)';
  }

  @override
  bool operator ==(covariant ProductDTO other) {
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
