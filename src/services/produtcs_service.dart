import '../data/fake_data.dart';
import '../dto/produtc_dto.dart';
import '../models/product_model.dart';

class ProductsService {
  Future<List<ProductModel>> findAll() async {
    await Future.delayed(const Duration(milliseconds: 50));
    final List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    return allProducts;
  }

  Future<ProductModel> findById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final List<ProductModel> allProducts =
        products.map((productMap) => ProductModel.fromMap(productMap)).toList();
    final ProductModel selectedProduct =
        allProducts.firstWhere((product) => product.id == id);
    return selectedProduct;
  }

  Future<ProductModel> create(ProductDTO productDTO) async {
    await Future.delayed(const Duration(milliseconds: 50));
    productDTO = productDTO.copyWith(id: 8372);
    final Map<String, dynamic> newProductMap = productDTO.toMap();
    products.add(newProductMap);
    return ProductModel.fromMap(newProductMap);
  }
}
