part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductEvent {}

class GetProductByIdEvent extends ProductEvent {
  // ID should be an integer
  final int id;
  const GetProductByIdEvent(this.id);
  @override
  List<Object> get props => [id];
}

class AddProductEvent extends ProductEvent {
  // The use case expects an Entity
  final ProductEntity product;
  const AddProductEvent(this.product);
  @override
  List<Object> get props => [product];
}
