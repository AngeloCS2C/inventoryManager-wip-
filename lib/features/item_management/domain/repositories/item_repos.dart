import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/item.dart';

abstract class ItemRepository {
  Future<Either<Failure, void>> createItem(Item item);
  Future<Either<Failure, Item?>> getItemById(String id);
  Future<Either<Failure, List<Item>>> getAllItems(
      {String? searchQuery, String? filterCategory});
  Future<Either<Failure, void>> updateItem(Item item);
  Future<Either<Failure, void>> deleteItem(String id);
}
