import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'package:ecommerce_package_sample/src/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_package_sample/src/data/datasources/product_remote_datasource_impl.dart';
import 'package:ecommerce_package_sample/src/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_package_sample/src/domain/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator();

  static ServiceLocator get instance => _instance;

  static final _InnerServiceLocator _locator = _InnerServiceLocator.instance;

  static void setUp() {
    // Client
    _locator.registerFactory<http.Client>(factoryCallback: () => http.Client());

    // Data sources
    _locator.registerFactory<ProductRemoteDatasource>(
      factoryCallback: () =>
          ProductRemoteDatasourceImpl(client: _locator.get()),
    );

    // Repositories
    _locator.registerFactory<ProductRepository>(
      factoryCallback: () =>
          ProductRepositoryImpl(remoteDatasource: _locator.get()),
    );

    // Use cases
    _locator.registerFactory<GetAllProductsUseCase>(
      factoryCallback: () => GetAllProductsUseCase(_locator.get()),
    );

    _locator.registerFactory<AddProductUseCase>(
      factoryCallback: () => AddProductUseCase(_locator.get()),
    );

    _locator.registerFactory<GetProductByIdUseCase>(
      factoryCallback: () => GetProductByIdUseCase(_locator.get()),
    );

    _locator._showFactories();
  }

  T call<T>() {
    return _locator.get<T>();
  }
}

// Idea: Almacenar los métodos factory para crear cada dependencia
// El service locator debe tener un método get genérico que resuelva
// que método factory debe buscar para entregar la dependencia

class _InnerServiceLocator {
  static final _InnerServiceLocator _instance = _InnerServiceLocator();
  static _InnerServiceLocator get instance => _instance;

  /// Almacén de todos los métodos para crear el objeto del tipo asignado
  /// [Type] es el tipo de la clase y se usa como la clave para almacenar
  /// [Function] es el valor almacenado con el método que crea el objeto
  final Map<Type, Function> factories = {};

  /// Método que almacena el factory para el tipo asignado
  void registerFactory<T>({required T Function() factoryCallback}) {
    factories[T] = factoryCallback;
  }

  /// Retorna el factory del tipo de dependencia requerido
  T get<T>() {
    final callback = factories[T];
    try {
      return callback!();
    } catch (_) {
      throw Exception("No se encontró la función para el tipo: $T");
    }
  }

  /// Muestra todas dependencias registradas
  void _showFactories() {
    factories.forEach((type, callback) => debugPrint("Tipo: $type"));
  }
}
