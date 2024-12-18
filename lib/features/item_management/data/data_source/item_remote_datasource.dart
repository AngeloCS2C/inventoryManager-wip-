import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/item.dart';

abstract class ItemRemoteDataSource {
  ItemRemoteDataSource(FirebaseFirestore firestore);

  Future<void> createItem(Item item);
  Future<Item?> getItemById(String id);
  Future<List<Item>> getAllItems({String? searchQuery, String? filterCategory});
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String id);

  fetchAllItems({String? searchQuery, String? filterCategory}) {}

  fetchItemById(String id) {}
}
