import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/stock.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final FirebaseFirestore firestore;

  StockCubit(this.firestore) : super(StockInitial());

  Future<void> fetchStocks() async {
    emit(StockLoading());
    try {
      final snapshot = await firestore.collection('stocks').get();
      final stocks = snapshot.docs.map((doc) {
        final data = doc.data();
        return Stock(
          id: doc.id,
          itemName: data['itemName'],
          sku: data['sku'],
          costPrice: data['costPrice'].toDouble(),
          sellingPrice: data['sellingPrice'].toDouble(),
          quantity: data['quantity'],
          minimumStockLevel: data['minimumStockLevel'],
          description: data['description'],
        );
      }).toList();
      emit(StockLoaded(stocks));
    } catch (e) {
      emit(StockError('Failed to fetch stocks: ${e.toString()}'));
    }
  }

  Future<void> addStock(Stock stock) async {
    emit(StockLoading());
    try {
      final stockData = stock.toMap();
      await firestore.collection('stocks').add(stockData);
      emit(StockAdded());
      await fetchStocks();
    } catch (e) {
      emit(StockError('Failed to add stock: ${e.toString()}'));
    }
  }

  Future<void> updateStock(String id, Stock updatedStock) async {
    emit(StockLoading());
    try {
      final stockData = updatedStock.toMap();
      await firestore.collection('stocks').doc(id).update(stockData);
      emit(StockUpdated());
      await fetchStocks();
    } catch (e) {
      emit(StockError('Failed to update stock: ${e.toString()}'));
    }
  }

  Future<void> deleteStock(String id) async {
    emit(StockLoading());
    try {
      await firestore.collection('stocks').doc(id).delete();
      emit(StockDeleted());
      await fetchStocks();
    } catch (e) {
      emit(StockError('Failed to delete stock: ${e.toString()}'));
    }
  }
}

extension on Stock {
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'sku': sku,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'quantity': quantity,
      'minimumStockLevel': minimumStockLevel,
      'description': description,
    };
  }
}
