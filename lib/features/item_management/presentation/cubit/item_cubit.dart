import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/item.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final FirebaseFirestore firestore;

  ItemCubit(this.firestore) : super(ItemInitial());

  Future<void> fetchItems() async {
    emit(ItemLoading());
    try {
      final snapshot = await firestore.collection('items').get();
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        return Item(
          id: doc.id,
          name: data['name'],
          sku: data['sku'],
          category: data['category'],
          supplier: data['supplier'],
          costPrice: data['costPrice'].toDouble(),
          sellingPrice: data['sellingPrice'].toDouble(),
          quantity: data['quantity'],
          description: data['description'],
        );
      }).toList();
      emit(ItemLoaded(items));
    } catch (e) {
      emit(ItemError('Failed to fetch items: ${e.toString()}'));
    }
  }

  Future<void> addItem(Item item) async {
    emit(ItemLoading());
    try {
      final itemData = item.toMap();
      await firestore.collection('items').add(itemData);
      emit(ItemAdded());
      await fetchItems();
    } catch (e) {
      emit(ItemError('Failed to add item: ${e.toString()}'));
    }
  }

  Future<void> updateItem(String id, Item updatedItem) async {
    emit(ItemLoading());
    try {
      final itemData = updatedItem.toMap();
      await firestore.collection('items').doc(id).update(itemData);
      emit(ItemUpdated());
      await fetchItems();
    } catch (e) {
      emit(ItemError('Failed to update item: ${e.toString()}'));
    }
  }

  Future<void> deleteItem(String id) async {
    emit(ItemLoading());
    try {
      await firestore.collection('items').doc(id).delete();
      emit(ItemDeleted());
      await fetchItems();
    } catch (e) {
      emit(ItemError('Failed to delete item: ${e.toString()}'));
    }
  }
}

extension on Item {}
