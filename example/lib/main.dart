import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'presentation/bloc/product_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  ServiceLocator.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => ProductBloc(
          getAllProductsUseCase:
              ServiceLocator.instance<GetAllProductsUseCase>(),
          getProductByIdUseCase:
              ServiceLocator.instance<GetProductByIdUseCase>(),
          addProductUseCase: ServiceLocator.instance<AddProductUseCase>(),
        ),
        child: const HomePage(),
      ),
    );
  }
}
