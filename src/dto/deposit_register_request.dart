// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DepositRegisterRequest {
  final int capacity;
  final int amount;
  final String address;
  final String name;
  DepositRegisterRequest({
    required this.capacity,
    required this.amount,
    required this.address,
    required this.name,
  });

  DepositRegisterRequest copyWith({
    int? capacity,
    int? amount,
    String? address,
    String? name,
  }) {
    return DepositRegisterRequest(
      capacity: capacity ?? this.capacity,
      amount: amount ?? this.amount,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capacity': capacity,
      'amount': amount,
      'address': address,
      'name': name,
    };
  }

  factory DepositRegisterRequest.fromMap(Map<String, dynamic> map) {
    return DepositRegisterRequest(
      capacity: map['capacity'] as int,
      amount: map['amount'] as int,
      address: map['address'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepositRegisterRequest.fromJson(String source) =>
      DepositRegisterRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepositRegisterRequest(capacity: $capacity, amount: $amount, address: $address, name: $name)';
  }

  @override
  bool operator ==(covariant DepositRegisterRequest other) {
    if (identical(this, other)) return true;

    return other.capacity == capacity &&
        other.amount == amount &&
        other.address == address &&
        other.name == name;
  }

  @override
  int get hashCode {
    return capacity.hashCode ^
        amount.hashCode ^
        address.hashCode ^
        name.hashCode;
  }
}
