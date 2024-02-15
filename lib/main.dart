import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tr_store/utils/mixin/bloc_provider_mixin.dart';
import '/constant/app_url.dart';
import '/data_provider/pref_helper.dart';
import '/utils/app_version.dart';
import '/utils/enum.dart';
import '/utils/navigation.dart';
import '/utils/network_connection.dart';
import '/utils/styles/k_colors.dart';
import 'modules/products/views/products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  //Set Potraite Mode only
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

/// Make sure you always init shared pref first. It has token and token is need
/// to make API call
initServices() async {
  const mode = String.fromEnvironment('mode', defaultValue: 'DEV');
  AppUrlExtention.setUrl(
    mode == "DEV" ? UrlLink.isDev : UrlLink.isLive,
  );
  await PrefHelper.init();
  await AppVersion.getVersion();
  await NetworkConnection.instance.internetAvailable();
}

class MyApp extends StatelessWidget with BlocProviderMixin {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return ScreenUtilInit(
      //Change the height and Width based on design
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (ctx, child) {
        return MultiBlocProvider(
          providers: blocProviders(),
          child: MaterialApp(
            title: 'TR Store',
            navigatorKey: Navigation.key,
            debugShowCheckedModeBanner: false,
            //localization
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: (PrefHelper.getLanguage() == 1)
                ? const Locale('en', 'US')
                : const Locale('bn', 'BD'),
            theme: ThemeData(
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: KColor.secondary.color,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryColor: KColor.primary.color,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: KColor.secondary.color,
                  ),
              primarySwatch: KColor.primary.color as MaterialColor,
            ),
            home: child,
          ),
        );
      },
      child: const ProductsScreen(),
    );
  }
}
