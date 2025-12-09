import 'package:ecommerce_package_sample/src/data/models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<ProductModel> addProduct(ProductModel product);
}
