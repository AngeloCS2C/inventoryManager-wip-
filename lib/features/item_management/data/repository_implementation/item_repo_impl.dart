import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failure.dart';
import 'package:task/features/item_management/data/data_source/item_remote_datasource.dart';
import 'package:task/features/item_management/domain/entities/item.dart';
import 'package:task/features/item_management/domain/repositories/item_repos.dart';

class ItemRepositoryImplementation implements ItemRepository {
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createItem(Item item) async {
    try {
      await remoteDataSource.createItem(item);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(message: 'Failed to create item', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(String id) async {
    try {
      await remoteDataSource.deleteItem(id);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(message: 'Failed to delete item', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getAllItems({
    String? searchQuery,
    String? filterCategory,
  }) async {
    try {
      final items = await remoteDataSource.fetchAllItems(
        searchQuery: searchQuery,
        filterCategory: filterCategory,
      );
      return Right(items);
    } catch (e) {
      return const Left(
          Failure(message: 'Failed to fetch items', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Item?>> getItemById(String id) async {
    try {
      final item = await remoteDataSource.fetchItemById(id);
      return Right(item);
    } catch (e) {
      return const Left(
          Failure(message: 'Failed to fetch item', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> updateItem(Item item) async {
    try {
      await remoteDataSource.updateItem(item);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(message: 'Failed to update item', statusCode: 500));
    }
  }
}
