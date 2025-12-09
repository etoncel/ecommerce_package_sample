# Ecommerce Package Sample

Paquete de Flutter que interactúa con la api de https://fakestoreapi.com/ para obtener, crear y listar productos.

## Funcionalidades

*   Obtener todos los productos.
*   Obtener un producto por su ID.
*   Agregar un nuevo producto.
*   Manejo de dependencias listo para usar con `get_it`.
*   Arquitectura Limpia (Clean Architecture) con capas de dominio, datos y presentación.

## Inicio

Agrega el paquete a las dependencias de tu archivo `pubspec.yaml`:

```yaml
dependencies:
  ecommerce_package_sample: <latest_version>
```

Luego, instala los paquetes desde la terminal:

```shell
flutter pub get
```

## Usage

Este paquete utiliza el localizador de servicios `get_it` para la inyección de dependencias. Para que el paquete funcione correctamente, primero debes inicializar las dependencias.

### 1. Inicialización de Dependencias

En tu archivo `main.dart`, antes de ejecutar tu aplicación, llama al método `ServiceLocator.setUp()`.

```dart
import 'package:flutter/material.dart';
import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';

void main() {
  // Inicializa el localizador de servicios
  ServiceLocator.setUp(); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ... resto de tu app
}
```

### 2. ¿Cómo funciona la Inyección de Dependencias?

El método `ServiceLocator.setUp()` registra todas las clases necesarias para que el paquete funcione:

*   **Use Cases**: `GetAllProductsUseCase`, `GetProductByIdUseCase`, `AddProductUseCase`.
*   **Repositories**: `ProductRepository`.
*   **Data Sources**: `ProductRemoteDatasource`.
*   **External**: `http.Client`.

No necesitas registrar nada manualmente si solo vas a consumir los `UseCases` que provee el paquete.

### 3. Usando los Casos de Uso

Una vez inicializado, puedes obtener una instancia de cualquier caso de uso directamente desde el localizador de servicios.

Aquí tienes un ejemplo de cómo obtener todos los productos en un `FutureBuilder`:

```dart
import 'package:flutter/material.dart';
import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Obtiene la instancia del caso de uso desde el ServiceLocator
    final getAllProducts = ServiceLocator.instance<GetAllProductsUseCase>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: FutureBuilder<List<ProductEntity>>(
        // 2. Llama al caso de uso, que es una clase invocable (callable)
        future: () async {
          final result = await getAllProducts();
          return result.fold(
            (failure) => print(failure.toString()), // Maneja el error
            (products) => products, // Devuelve la lista de productos
          );
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron productos.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
```

## Additional information

Para más ejemplos, revisa el directorio `/example` de este paquete. Si encuentras algún problema o tienes una sugerencia, por favor abre un issue en el repositorio del proyecto.
