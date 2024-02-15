import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/products/bloc/products_event.dart';
import 'package:tr_store/modules/products/bloc/products_state.dart';

import '../repository/products_interface.dart';
import '../repository/products_repository.dart';

class ProducsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductsRepository _dashboardRepository = ProductsRepository();

  ProducsBloc() : super(const ProductsState()) {}
}
