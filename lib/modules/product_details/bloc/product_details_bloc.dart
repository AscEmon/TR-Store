import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/product_details/bloc/product_details_state.dart';
import 'package:tr_store/modules/product_details/repository/product_details_interface.dart';
import 'package:tr_store/modules/product_details/repository/product_details_repository.dart';

import '../../../utils/enum.dart';
import '../model/product_details_response.dart';
import 'product_details_event.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailstate> {
  final IProductDetailsRepository _productDetailsRepository =
      ProductDetailsRepository();

  ProductDetailsBloc() : super(const ProductDetailstate()) {
    on<LoadProductDetailsEvent>(_fetchProductDetails);
  }

  void _fetchProductDetails(
      LoadProductDetailsEvent event, Emitter<ProductDetailstate> emit) async {
    try {
      ProductsDetailsData result =
          await _productDetailsRepository.fetchProductDetails(id: event.id);

      emit(
        state.copyWith(
          fetchRepoStatus: AppStatus.success,
          productDetails: result,
        ),
      );
    } catch (error) {
      emit(state.copyWith(fetchRepoStatus: AppStatus.error));
    }
  }
}
