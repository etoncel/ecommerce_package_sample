import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Use correct UseCase names
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final AddProductUseCase addProductUseCase;

  ProductBloc({
    required this.getAllProductsUseCase,
    required this.getProductByIdUseCase,
    required this.addProductUseCase,
  }) : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetProductByIdEvent>(_onGetProductById);
    on<AddProductEvent>(_onAddProduct);
  }

  Future<void> _onGetAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final failureOrProducts = await getAllProductsUseCase();
    failureOrProducts.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(AllProductsLoaded(products)),
    );
  }

  Future<void> _onGetProductById(
    GetProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    // event.id is now an int
    final failureOrProduct = await getProductByIdUseCase(event.id);
    failureOrProduct.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (product) => emit(SingleProductLoaded(product)),
    );
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final failureOrNewId = await addProductUseCase(event.product);
    failureOrNewId.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (newId) => emit(ProductAdded(newId)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Simple failure mapping
    return failure.toString();
  }
}
