import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repos.dart';

class GetAllItems {
  final ItemRepository repository;

  GetAllItems({required this.repository});

  Future<Either<Failure, List<Item>>> call(
      {String? searchQuery, String? filterCategory}) {
    return repository.getAllItems(
        searchQuery: searchQuery, filterCategory: filterCategory);
  }
}
