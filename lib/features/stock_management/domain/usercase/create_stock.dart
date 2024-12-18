import '../entities/stock.dart';
import '../repositories/stock_repos.dart';

class CreateStock {
  final StockRepository repository;

  CreateStock(this.repository);

  Future<void> call(Stock stock) async {
    await repository.createStock(stock);
  }
}
