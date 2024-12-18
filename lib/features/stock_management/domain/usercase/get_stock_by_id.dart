import '../entities/stock.dart';
import '../repositories/stock_repos.dart';

class GetStockById {
  final StockRepository repository;

  GetStockById(this.repository);

  Future<Stock> call(String id) async {
    return await repository.getStockById(id);
  }
}
