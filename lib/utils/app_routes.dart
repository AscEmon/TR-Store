import 'package:flutter/material.dart';
import '../modules/dashboard/views/dashboard_screen.dart';


enum AppRoutes {
  dashboard,
}

extension AppRoutesExtention on AppRoutes {
  Widget buildWidget<T extends Object>({T? arguments}) {
    switch (this) {
      case AppRoutes.dashboard:
        return const DashboardScreen();
    }
  }
}


