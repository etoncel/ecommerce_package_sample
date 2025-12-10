import 'package:ecommerce_package_sample/ecommerce_package_sample.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            if (product.image.isNotEmpty)
              Center(child: Image.network(product.image, height: 100)),
            const SizedBox(height: 10),
            Text(
              'ID: ${product.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Title: ${product.title}'),
            Text('Price: ${product.price}'),
            Text('Description: ${product.description}'),
          ],
        ),
      ),
    );
  }
}
