import '../repositories/stock_repos.dart';

class DeleteStock {
  final StockRepository repository;

  DeleteStock(this.repository);

  Future<void> call(String id) async {
    await repository.deleteStock(id);
  }
}
