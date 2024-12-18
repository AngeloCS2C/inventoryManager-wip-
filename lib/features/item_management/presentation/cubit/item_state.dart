part of 'item_cubit.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  const ItemLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class ItemAdded extends ItemState {}

class ItemUpdated extends ItemState {}

class ItemDeleted extends ItemState {}

class ItemError extends ItemState {
  final String message;

  const ItemError(this.message);

  @override
  List<Object> get props => [message];
}
