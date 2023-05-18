import '../dto/produtc_dto.dart';
import '../models/product.dart';
import '../repositories/products_repository.dart';

class ProductsService {
  ProductsRepository repository = ProductsRepository();

  Future<List<Product>> findAll() async {
    await Future.delayed(const Duration(milliseconds: 50));

    final List<Product> allProducts =
        products.map((productMap) => Product.fromMap(productMap)).toList();
    return allProducts;
  }

  Future<Product> findById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final List<Product> allProducts =
        products.map((productMap) => Product.fromMap(productMap)).toList();
    final Product selectedProduct =
        allProducts.firstWhere((product) => product.id == id);
    return selectedProduct;
  }

  Future<Product> create(ProductDTO productDTO) async {
    await Future.delayed(const Duration(milliseconds: 50));
    productDTO = productDTO.copyWith(id: 8372);
    final Map<String, dynamic> newProductMap = productDTO.toMap();
    products.add(newProductMap);
    return Product.fromMap(newProductMap);
  }
}
