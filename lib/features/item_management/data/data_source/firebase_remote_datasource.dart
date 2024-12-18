import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/item.dart';

class ItemRemoteDataSource {
  final FirebaseFirestore firestore;

  ItemRemoteDataSource(this.firestore);

  Future<void> createItem(Item item) async {
    try {
      await firestore.collection('items').doc(item.id).set({
        'name': item.name,
        'sku': item.sku,
        'category': item.category,
        'supplier': item.supplier,
        'costPrice': item.costPrice,
        'sellingPrice': item.sellingPrice,
        'quantity': item.quantity,
        'description': item.description,
      });
    } catch (e) {
      throw Exception('Error creating item: $e');
    }
  }

  Future<List<Item>> getAllItems() async {
    try {
      final querySnapshot = await firestore.collection('items').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Item(
          id: doc.id,
          name: data['name'] as String,
          sku: data['sku'] as String,
          category: data['category'] as String,
          supplier: data['supplier'] as String,
          costPrice: (data['costPrice'] as num).toDouble(),
          sellingPrice: (data['sellingPrice'] as num).toDouble(),
          quantity: data['quantity'] as int,
          description: data['description'] as String,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }

  Future<void> updateItem(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('items').doc(id).update(updates);
    } catch (e) {
      throw Exception('Error updating item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await firestore.collection('items').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting item: $e');
    }
  }
}
