import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/item_repos.dart';

class DeleteItem {
  final ItemRepository repository;

  DeleteItem({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteItem(id);
  }
}
