import 'package:task/features/item_management/domain/entities/item.dart';

abstract class ItemRemoteDataSource {
  Future<void> createItem(Item item);
  Future<void> deleteItem(String id);
}
