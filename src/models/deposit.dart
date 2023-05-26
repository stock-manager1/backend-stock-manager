// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Deposit {
  final int id;
  final int capacity;
  final int amount;
  final String address;
  final String name;
  
  Deposit({
    this.id = 0,
    this.capacity = 0,
    this.amount = 0,
    this.address = '',
    this.name = '',
  });

  Deposit copyWith({
    int? id,
    int? capacity,
    int? amount,
    String? address,
    String? name,
  }) {
    return Deposit(
      id: id ?? this.id,
      capacity: capacity ?? this.capacity,
      amount: amount ?? this.amount,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }

  bool isEmpty() {
    if (name.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'capacity': capacity,
      'amount': amount,
      'address': address,
      'name': name,
    };
  }

  factory Deposit.fromMap(Map<String, dynamic> map) {
    return Deposit(
      id: (map['id'] ?? 0) as int,
      capacity: (map['capacity'] ?? 0) as int,
      amount: (0),
      address: (map['address'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Deposit.fromJson(String source) =>
      Deposit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Depository(id: $id, capacity: $capacity, amount: $amount, address: $address, name: $name)';
  }

  @override
  bool operator ==(covariant Deposit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.capacity == capacity &&
        other.amount == amount &&
        other.address == address &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        capacity.hashCode ^
        amount.hashCode ^
        address.hashCode ^
        name.hashCode;
  }
}
