// ignore_for_file: duplicate_import, avoid_returning_null_for_void

import 'package:task/features/item_management/data/repository_implementation/item_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:task/features/item_management/data/repository_implementation/item_repo_impl.dart';
import 'package:task/features/item_management/data/data_source/item_remote_datasource.dart';
import 'package:task/features/item_management/domain/entities/item.dart';

import 'item_repo_impl_test.mocks.dart';

@GenerateMocks([ItemRemoteDataSource])
void main() {
  late MockItemRemoteDataSource mockRemoteDataSource;
  late ItemRepositoryImplementation repository;

  setUp(() {
    mockRemoteDataSource = MockItemRemoteDataSource();
    repository = ItemRepositoryImplementation(mockRemoteDataSource);
  });

  group('ItemRepositoryImplementation', () {
    test('Should create a new item via the remote data source', () async {
      // Arrange
      const testItem = Item(
        id: '1',
        sku: 'SKU123',
        supplier: 'Supplier Inc.',
        costPrice: 100.0,
        sellingPrice: 150.0,
        quantity: 10,
        description: 'Test item description',
        category: '',
        name: '',
      );

      when(mockRemoteDataSource.createItem(testItem))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.createItem(testItem);

      // Assert
      expect(result.isRight(), true);
      verify(mockRemoteDataSource.createItem(testItem)).called(1);
    });

    test('Should delete an item via the remote data source', () async {
      // Arrange
      const itemId = '1';

      when(mockRemoteDataSource.deleteItem(itemId))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.deleteItem(itemId);

      // Assert
      expect(result.isRight(), true);
      verify(mockRemoteDataSource.deleteItem(itemId)).called(1);
    });
  });
}
