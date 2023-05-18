// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Deposit {
  final int id;
  final int capacity;
  final int qntInventory;
  final String address;
  final String name;
  
  Deposit({
    this.id = 0,
    this.capacity = 0,
    this.qntInventory = 0,
    this.address = '',
    this.name = '',
  });

  Deposit copyWith({
    int? id,
    int? capacity,
    int? qntInventory,
    String? address,
    String? name,
  }) {
    return Deposit(
      id: id ?? this.id,
      capacity: capacity ?? this.capacity,
      qntInventory: qntInventory ?? this.qntInventory,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'capacity': capacity,
      'qntInventory': qntInventory,
      'address': address,
      'name': name,
    };
  }

  factory Deposit.fromMap(Map<String, dynamic> map) {
    return Deposit(
      id: (map['id'] ?? 0) as int,
      capacity: (map['capacity'] ?? 0) as int,
      qntInventory: (map['qntInventory'] ?? 0) as int,
      address: (map['address'] ?? '') as String,
      name: (map['name'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Deposit.fromJson(String source) =>
      Deposit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Depository(id: $id, capacity: $capacity, qntInventory: $qntInventory, address: $address, name: $name)';
  }

  @override
  bool operator ==(covariant Deposit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.capacity == capacity &&
        other.qntInventory == qntInventory &&
        other.address == address &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        capacity.hashCode ^
        qntInventory.hashCode ^
        address.hashCode ^
        name.hashCode;
  }
}
