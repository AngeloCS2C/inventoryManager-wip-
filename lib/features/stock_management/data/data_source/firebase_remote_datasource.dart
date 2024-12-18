import 'package:cloud_firestore/cloud_firestore.dart';

class StockRemoteDataSource {
  final FirebaseFirestore firestore;

  StockRemoteDataSource(this.firestore);

  Future<void> addStock(String itemId, int quantity) async {
    try {
      final itemRef = firestore.collection('items').doc(itemId);
      final snapshot = await itemRef.get();

      if (snapshot.exists) {
        final currentQuantity = snapshot.data()?['quantity'] ?? 0;
        await itemRef.update({
          'quantity': currentQuantity + quantity,
        });
      } else {
        throw Exception('Item not found for adding stock.');
      }
    } catch (e) {
      throw Exception('Error adding stock: $e');
    }
  }

  Future<void> removeStock(String itemId, int quantity) async {
    try {
      final itemRef = firestore.collection('items').doc(itemId);
      final snapshot = await itemRef.get();

      if (snapshot.exists) {
        final currentQuantity = snapshot.data()?['quantity'] ?? 0;
        if (currentQuantity >= quantity) {
          await itemRef.update({
            'quantity': currentQuantity - quantity,
          });
        } else {
          throw Exception('Insufficient stock for removal.');
        }
      } else {
        throw Exception('Item not found for removing stock.');
      }
    } catch (e) {
      throw Exception('Error removing stock: $e');
    }
  }

  Future<int> getStock(String itemId) async {
    try {
      final itemRef = firestore.collection('items').doc(itemId);
      final snapshot = await itemRef.get();

      if (snapshot.exists) {
        return snapshot.data()?['quantity'] ?? 0;
      } else {
        throw Exception('Item not found for fetching stock.');
      }
    } catch (e) {
      throw Exception('Error fetching stock: $e');
    }
  }
}
