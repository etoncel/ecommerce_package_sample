import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'package:example/presentation/bloc/product_bloc.dart';
import 'package:example/presentation/widgets/product_list.dart';
import 'package:example/presentation/widgets/product_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ecommerce Usecase Tester')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.list),
                  label: const Text('Get All Products'),
                  onPressed: () =>
                      context.read<ProductBloc>().add(GetAllProductsEvent()),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text("Get Product by ID 1"),
                  onPressed: () => context.read<ProductBloc>().add(
                    // Use an integer
                    const GetProductByIdEvent(1),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add a Product'),
                  onPressed: () {
                    // Create an entity, not a model
                    final newProduct = ProductEntity(
                      id: 0, // ID is usually ignored by the API
                      title: 'New Test Product',
                      price: 199.99,
                      description: 'A great product.',
                      category: 'electronics',
                      image: 'https://via.placeholder.com/150',
                      rating: RatingEntity(rate: 4.9, count: 1),
                    );
                    context.read<ProductBloc>().add(
                      AddProductEvent(newProduct),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Get Categories'),
                  onPressed: () {
                    context.read<ProductBloc>().add(GetCategoriesEvent());
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CategoriesError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is CategoriesLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Column(
                        children: [Text(category.name), Text(category.image)],
                      );
                    },

                    itemCount: state.categories.length,
                  );
                }
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is ProductInitial) {
                  return const Center(
                    child: Text('Press a button to test a use case.'),
                  );
                }
                if (state is AllProductsLoaded) {
                  return ProductList(products: state.products);
                }
                if (state is SingleProductLoaded) {
                  return ProductListItem(product: state.product);
                }
                if (state is ProductAdded) {
                  return Center(
                    child: Text(
                      'Product Successfully Added!\nNew Product ID: ${state.newId}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
