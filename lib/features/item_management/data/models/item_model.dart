import 'dart:convert';

import 'package:task/features/item_management/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.category,
    required super.supplier,
    required super.costPrice,
    required super.sellingPrice,
    required super.quantity,
    required super.description,
  });

  /// Factory method to create an instance of ItemModel from a Map (e.g., from a database).
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      category: map['category'],
      supplier: map['supplier'],
      costPrice: map['costPrice'].toDouble(),
      sellingPrice: map['sellingPrice'].toDouble(),
      quantity: map['quantity'],
      description: map['description'],
    );
  }

  /// Factory method to create an instance of ItemModel from JSON (e.g., from an API response).
  factory ItemModel.fromJson(String source) {
    return ItemModel.fromMap(json.decode(source));
  }

  /// Converts the ItemModel instance into a Map (e.g., for saving to a database).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'supplier': supplier,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'description': description,
    };
  }

  /// Converts the ItemModel instance into a JSON string (e.g., for API requests).
  String toJson() {
    return json.encode(toMap());
  }
}
