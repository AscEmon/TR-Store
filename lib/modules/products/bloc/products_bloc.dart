import '../repository/products_interface.dart';
import '../repository/products_repository.dart';

class ProductsBloc {
  final IProductsRepository _dashboardRepository = ProductsRepository();
}
