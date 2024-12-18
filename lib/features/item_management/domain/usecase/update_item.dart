import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repos.dart';

class UpdateItem {
  final ItemRepository repository;

  UpdateItem(FirebaseFirestore firestore, {required this.repository});

  Future<Either<Failure, void>> call(Item item) {
    return repository.updateItem(item);
  }
}