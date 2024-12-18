// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task/features/stock_management/data/data_source/stock_remote_datasource.dart';
import 'package:task/features/stock_management/domain/entities/stock.dart';

import 'stock_remote_datasource_test.mocks.dart';

@GenerateMocks([StockRemoteDataSourceImpl])
void main() {
  late MockStockRemoteDataSourceImpl mockDataSource;

  setUp(() {
    mockDataSource = MockStockRemoteDataSourceImpl();
  });

  group('StockRemoteDataSource', () {
    const testStock = Stock(
      id: '1',
      itemName: 'Test Stock Item',
      sku: 'SKU123',
      costPrice: 100.0,
      sellingPrice: 150.0,
      quantity: 10,
      minimumStockLevel: 5,
      description: 'Test stock description',
    );

    test('Should fetch all stocks', () async {
      // Arrange
      when(mockDataSource.fetchAllStocks())
          .thenAnswer((_) async => [testStock]);

      // Act
      final result = await mockDataSource.fetchAllStocks();

      // Assert
      expect(result, isA<List<Stock>>());
      expect(result.length, 1);
      expect(result.first, testStock);
      verify(mockDataSource.fetchAllStocks()).called(1);
    });

    test('Should fetch stock by ID', () async {
      // Arrange
      const stockId = '1';
      when(mockDataSource.fetchStockById(stockId))
          .thenAnswer((_) async => testStock);

      // Act
      final result = await mockDataSource.fetchStockById(stockId);

      // Assert
      expect(result, isA<Stock>());
      expect(result.id, stockId);
      verify(mockDataSource.fetchStockById(stockId)).called(1);
    });

    test('Should create a stock item', () async {
      // Arrange
      when(mockDataSource.addStock(testStock)).thenAnswer((_) async => null);

      // Act
      await mockDataSource.addStock(testStock);

      // Assert
      verify(mockDataSource.addStock(testStock)).called(1);
    });

    test('Should delete a stock item by ID', () async {
      // Arrange
      const stockId = '1';
      when(mockDataSource.deleteStock(stockId)).thenAnswer((_) async => null);

      // Act
      await mockDataSource.deleteStock(stockId);

      // Assert
      verify(mockDataSource.deleteStock(stockId)).called(1);
    });
  });
}
