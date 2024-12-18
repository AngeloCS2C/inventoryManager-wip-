import '../entities/stock.dart';
import '../repositories/stock_repos.dart';

class GetAllStocks {
  final StockRepository repository;

  GetAllStocks(this.repository);

  Future<List<Stock>> call() async {
    return await repository.getAllStocks();
  }
}
