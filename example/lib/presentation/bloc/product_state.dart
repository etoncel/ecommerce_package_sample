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

/// Estado que indica que las categorías están cargándose.
class CategoriesLoading extends ProductState {}

/// Estado que indica que las categorías han sido cargadas exitosamente.
class CategoriesLoaded extends ProductState {
  final List<CategoryEntity> categories;
  const CategoriesLoaded(this.categories);
  @override
  List<Object> get props => [categories];
}

/// Estado que indica que hubo un error al cargar las categorías.
class CategoriesError extends ProductState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object> get props => [message];
}
