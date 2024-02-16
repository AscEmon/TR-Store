import '../modules/cart/views/cart_screen.dart';
import 'package:flutter/material.dart';
import '../modules/product_details/views/product_details_screen.dart';
import '../modules/products/views/products_screen.dart';

enum AppRoutes {
  dashboard,
  cart,
  productDetails,
}

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.cart:
        return const CartScreen();
      case AppRoutes.dashboard:
        return const ProductsScreen();

      case AppRoutes.productDetails:
        return ProductDetailsScreen(
          id: arguments as int,
        );
    }
  }
}
