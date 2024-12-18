import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repos.dart';

class GetItemById {
  final ItemRepository repository;

  GetItemById({required this.repository});

  Future<Either<Failure, Item?>> call(String id) {
    return repository.getItemById(id);
  }
}
