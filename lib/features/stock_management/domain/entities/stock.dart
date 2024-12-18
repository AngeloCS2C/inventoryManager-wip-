import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String itemName;
  final String sku;
  final double costPrice;
  final double sellingPrice;
  final int quantity;
  final int minimumStockLevel; // For low stock alerts
  final String description;

  const Stock({
    required this.id,
    required this.itemName,
    required this.sku,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.minimumStockLevel,
    required this.description,
  });

  @override
  List<Object> get props => [id];
}
