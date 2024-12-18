import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String sku;
  final String category;
  final String supplier;
  final double costPrice;
  final double sellingPrice;
  final int quantity;
  final String description;

  const Item({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.supplier,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.description,
  });

  @override
  List<Object> get props => [id];

  static fromMap(String id, Map<String, dynamic> data) {}
}

// Firestore-related extensions
extension ItemFirestore on Item {
  Map<String, dynamic> toMap() {
    return {
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

  static Item fromMap(String id, Map<String, dynamic> map) {
    return Item(
      id: id,
      name: map['name'] as String,
      sku: map['sku'] as String,
      category: map['category'] as String,
      supplier: map['supplier'] as String,
      costPrice: (map['costPrice'] as num).toDouble(),
      sellingPrice: (map['sellingPrice'] as num).toDouble(),
      quantity: map['quantity'] as int,
      description: map['description'] as String,
    );
  }
}
