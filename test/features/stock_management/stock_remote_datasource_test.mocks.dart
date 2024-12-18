// Mocks generated by Mockito 5.4.4 from annotations
// in task/test/features/stock_management/stock_remote_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:task/features/stock_management/data/data_source/stock_remote_datasource.dart'
    as _i3;
import 'package:task/features/stock_management/domain/entities/stock.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeStock_0 extends _i1.SmartFake implements _i2.Stock {
  _FakeStock_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StockRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockStockRemoteDataSourceImpl extends _i1.Mock
    implements _i3.StockRemoteDataSourceImpl {
  MockStockRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Stock>> fetchAllStocks() => (super.noSuchMethod(
        Invocation.method(
          #fetchAllStocks,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Stock>>.value(<_i2.Stock>[]),
      ) as _i4.Future<List<_i2.Stock>>);

  @override
  _i4.Future<_i2.Stock> fetchStockById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchStockById,
          [id],
        ),
        returnValue: _i4.Future<_i2.Stock>.value(_FakeStock_0(
          this,
          Invocation.method(
            #fetchStockById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Stock>);

  @override
  _i4.Future<void> addStock(_i2.Stock? stock) => (super.noSuchMethod(
        Invocation.method(
          #addStock,
          [stock],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> updateStock(
    String? id,
    _i2.Stock? updatedStock,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateStock,
          [
            id,
            updatedStock,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> deleteStock(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteStock,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
