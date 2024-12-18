import 'dart:async';
import '../../domain/entities/stock.dart';
import '../../domain/repositories/stock_repos.dart';
import '../data_source/stock_remote_datasource.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource remoteDataSource;

  StockRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Stock>> getAllStocks() async {
    try {
      final stocks = await remoteDataSource.fetchAllStocks();
      return stocks;
    } catch (error) {
      throw Exception('Failed to fetch stocks: $error');
    }
  }

  @override
  Future<Stock> getStockById(String id) async {
    try {
      final stock = await remoteDataSource.fetchStockById(id);
      return stock;
    } catch (error) {
      throw Exception('Failed to fetch stock by ID: $error');
    }
  }

  @override
  Future<void> createStock(Stock stock) async {
    try {
      await remoteDataSource.addStock(stock);
    } catch (error) {
      throw Exception('Failed to create stock: $error');
    }
  }

  @override
  Future<void> updateStock(String id, Stock updatedStock) async {
    try {
      await remoteDataSource.updateStock(id, updatedStock);
    } catch (error) {
      throw Exception('Failed to update stock: $error');
    }
  }

  @override
  Future<void> deleteStock(String id) async {
    try {
      await remoteDataSource.deleteStock(id);
    } catch (error) {
      throw Exception('Failed to delete stock: $error');
    }
  }
}
