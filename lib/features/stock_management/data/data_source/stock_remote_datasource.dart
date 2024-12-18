import '../../domain/entities/stock.dart';

abstract class StockRemoteDataSource {
  Future<List<Stock>> fetchAllStocks();
  Future<Stock> fetchStockById(String id);
  Future<void> addStock(Stock stock);
  Future<void> updateStock(String id, Stock updatedStock);
  Future<void> deleteStock(String id);
}

class StockRemoteDataSourceImpl implements StockRemoteDataSource {
  final List<Stock> _dummyDatabase = []; // Simulating a database

  @override
  Future<List<Stock>> fetchAllStocks() async {
    // Simulating network latency
    await Future.delayed(const Duration(milliseconds: 500));
    return _dummyDatabase;
  }

  @override
  Future<Stock> fetchStockById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _dummyDatabase.firstWhere((stock) => stock.id == id);
    } catch (error) {
      throw Exception('Stock not found');
    }
  }

  @override
  Future<void> addStock(Stock stock) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _dummyDatabase.add(stock);
  }

  @override
  Future<void> updateStock(String id, Stock updatedStock) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _dummyDatabase.indexWhere((stock) => stock.id == id);
    if (index == -1) {
      throw Exception('Stock not found');
    }
    _dummyDatabase[index] = updatedStock;
  }

  @override
  Future<void> deleteStock(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _dummyDatabase.removeWhere((stock) => stock.id == id);
  }
}
