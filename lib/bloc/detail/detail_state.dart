import '../../data/models/product_model.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final Product product;

  DetailLoaded(this.product);
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);
}
