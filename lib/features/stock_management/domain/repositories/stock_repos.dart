import '../entities/stock.dart';

abstract class StockRepository {
  Future<List<Stock>> getAllStocks();
  Future<Stock> getStockById(String id);
  Future<void> createStock(Stock stock);
  Future<void> updateStock(String id, Stock updatedStock);
  Future<void> deleteStock(String id);
}
