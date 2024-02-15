import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/products/bloc/products_event.dart';
import 'package:tr_store/modules/products/bloc/products_state.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

import '../../../utils/enum.dart';
import '../repository/products_interface.dart';
import '../repository/products_repository.dart';

class ProducsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductsRepository _productsRepository = ProductsRepository();

  ProducsBloc() : super(const ProductsState()) {
    on<LoadProductsEvent>(_fetchProducts);
  }

  void _fetchProducts(
      LoadProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      List<Products> result = await _productsRepository.fetchProducts();

      emit(
        state.copyWith(
          fetchRepoStatus: AppStatus.success,
          products: result,
        ),
      );
    } catch (error) {
      emit(state.copyWith(fetchRepoStatus: AppStatus.error));
    }
  }
}
