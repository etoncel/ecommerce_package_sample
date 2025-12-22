import 'package:equatable/equatable.dart';

/// La entidad `CategoryEntity` representa el modelo de una categoría en el dominio.
///
/// Contiene las propiedades esenciales de una categoría, como su nombre y una
/// imagen representativa. Extiende de `Equatable` para permitir comparaciones
/// de igualdad basadas en valores.
class CategoryEntity extends Equatable {
  /// El nombre de la categoría.
  final String name;

  /// La URL de la imagen representativa de la categoría.
  final String image;

  /// Constructor para crear una instancia de `CategoryEntity`.
  ///
  /// Requiere un [name] y una [image] para la categoría.
  const CategoryEntity({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];
}
