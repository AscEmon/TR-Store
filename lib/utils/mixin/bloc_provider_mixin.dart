import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/products/bloc/products_bloc.dart';

mixin BlocProviderMixin {
  blocProviders() {
    return [
      BlocProvider(create: (context) => ProducsBloc()),
    ];
  }
}
