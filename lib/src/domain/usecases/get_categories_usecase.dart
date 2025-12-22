import 'package:dartz/dartz.dart';
import 'package:ecommerce_package_sample/src/core/error/failures.dart';
import 'package:ecommerce_package_sample/src/domain/entities/category_entity.dart';
import 'package:ecommerce_package_sample/src/domain/entities/product_entity.dart';
import 'package:ecommerce_package_sample/src/domain/repositories/product_repository.dart';

/// Caso de uso para obtener una lista de categorías únicas a partir de los productos.
///
/// Este caso de uso interactúa con el [ProductRepository] para obtener todos los productos,
/// luego extrae las categorías únicas y las mapea a [CategoryEntity].
class GetCategoriesUseCase {
  final ProductRepository productRepository;

  /// Constructor que inyecta el [ProductRepository].
  const GetCategoriesUseCase({required this.productRepository});

  /// Ejecuta el caso de uso para obtener las categorías.
  ///
  /// Retorna un `Future` que contiene un `Either` con una [Failure] en caso de error
  /// o una `List<CategoryEntity>` en caso de éxito.
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    final productResult = await productRepository.getAllProducts();

    return productResult.fold(
      (failure) => Left(failure), // Si falla la obtención de productos, retorna la falla.
      (products) {
        // Usa un mapa para agrupar productos por categoría y mantener el primer producto para la imagen.
        final Map<String, ProductEntity> categoriesMap = {};
        for (var product in products) {
          if (!categoriesMap.containsKey(product.category)) {
            categoriesMap[product.category] = product;
          }
        }

        // Convierte el mapa de categorías a una lista de CategoryEntity.
        final List<CategoryEntity> categories = categoriesMap.entries.map((entry) {
          return CategoryEntity(
            name: entry.key,
            image: entry.value.image, // Usa la imagen del primer producto encontrado en esa categoría.
          );
        }).toList();

        return Right(categories);
      },
    );
  }
}
