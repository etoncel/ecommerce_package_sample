import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'package:ecommerce_package_sample/src/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_package_sample/src/data/datasources/product_remote_datasource_impl.dart';
import 'package:ecommerce_package_sample/src/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_package_sample/src/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  static final GetIt _instance = GetIt.instance;

  static GetIt get instance => _instance;

  static setUp() {
    _setUpProductFeature();
    _setUpExternal();
  }

  static void _setUpProductFeature() {
    //! Features - Product

    // Use cases
    if (!_instance.isRegistered<GetAllProductsUseCase>()) {
      _instance.registerFactory(() => GetAllProductsUseCase(_instance()));
    }
    if (!_instance.isRegistered<GetProductByIdUseCase>()) {
      _instance.registerFactory(() => GetProductByIdUseCase(_instance()));
    }
    if (!_instance.isRegistered<AddProductUseCase>()) {
      _instance.registerFactory(() => AddProductUseCase(_instance()));
    }
    if (!_instance.isRegistered<GetCategoriesUseCase>()) {
      _instance.registerFactory(
        () => GetCategoriesUseCase(productRepository: _instance()),
      );
    }

    // Repository
    if (!_instance.isRegistered<ProductRepository>()) {
      _instance.registerFactory<ProductRepository>(
        () => ProductRepositoryImpl(remoteDatasource: _instance()),
      );
    }

    // Data sources
    if (!_instance.isRegistered<ProductRemoteDatasource>()) {
      _instance.registerFactory<ProductRemoteDatasource>(
        () => ProductRemoteDatasourceImpl(client: _instance()),
      );
    }
  }

  static void _setUpExternal() {
    //! External
    if (!_instance.isRegistered<http.Client>()) {
      _instance.registerFactory(() => http.Client());
    }
  }
}
