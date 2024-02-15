import 'package:flutter/material.dart';
import '../modules/products/views/products_screen.dart';


enum AppRoutes {
  dashboard,
}

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.dashboard:
        return const ProductsScreen();
    }
  }
}


