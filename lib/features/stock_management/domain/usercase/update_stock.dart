import '../entities/stock.dart';
import '../repositories/stock_repos.dart';

class UpdateStock {
  final StockRepository repository;

  UpdateStock(this.repository);

  Future<void> call(String id, Stock updatedStock) async {
    await repository.updateStock(id, updatedStock);
  }
}
