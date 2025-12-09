part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class AllProductsLoaded extends ProductState {
  final List<ProductEntity> products;
  const AllProductsLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class SingleProductLoaded extends ProductState {
  final ProductEntity product;
  const SingleProductLoaded(this.product);
  @override
  List<Object> get props => [product];
}

class ProductAdded extends ProductState {
  // The use case returns the ID of the new product
  final int newId;
  const ProductAdded(this.newId);
  @override
  List<Object> get props => [newId];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object> get props => [message];
}
