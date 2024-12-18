import '../../domain/entities/stock.dart';

class StockModel extends Stock {
  const StockModel({
    required super.id,
    required super.itemName,
    required super.sku,
    required super.costPrice,
    required super.sellingPrice,
    required super.quantity,
    required super.minimumStockLevel,
    required super.description,
  });

  // Factory constructor for creating a StockModel from a JSON object
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'] as String,
      itemName: json['itemName'] as String,
      sku: json['sku'] as String,
      costPrice: (json['costPrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
      minimumStockLevel: json['minimumStockLevel'] as int,
      description: json['description'] as String,
    );
  }

  // Method for converting a StockModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'sku': sku,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'minimumStockLevel': minimumStockLevel,
      'description': description,
    };
  }
}
