// ignore_for_file: duplicate_import, avoid_returning_null_for_void

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task/features/stock_management/data/repository_implementation/stock_repo_impl.dart';
import 'package:task/features/stock_management/data/data_source/stock_remote_datasource.dart';
import 'package:task/features/stock_management/domain/entities/stock.dart';

import 'stock_repo_impl_test.mocks.dart';

@GenerateMocks([StockRemoteDataSource])
void main() {
  late MockStockRemoteDataSource mockRemoteDataSource;
  late StockRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockStockRemoteDataSource();
    repository = StockRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('StockRepositoryImpl', () {
    test('Should create a new stock item via the remote data source', () async {
      // Arrange
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

      when(mockRemoteDataSource.addStock(testStock))
          .thenAnswer((_) async => null);

      // Act
      await repository.createStock(testStock);

      // Assert
      verify(mockRemoteDataSource.addStock(testStock)).called(1);
    });

    test('Should delete a stock item via the remote data source', () async {
      // Arrange
      const stockId = '1';

      when(mockRemoteDataSource.deleteStock(stockId))
          .thenAnswer((_) async => null);

      // Act
      await repository.deleteStock(stockId);

      // Assert
      verify(mockRemoteDataSource.deleteStock(stockId)).called(1);
    });
  });
}
