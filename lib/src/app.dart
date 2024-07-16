import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'assets/assets_controller.dart';
import 'assets/assets_view.dart';
import 'companies/companies_controller.dart';
import 'companies/companies_model.dart';
import 'companies/companies_view.dart';
import 'constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.companiesController,
    required this.assetsController,
  });

  final CompaniesController companiesController;
  final AssetsController assetsController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: CustomTheme.theme,
      themeMode: ThemeMode.light,
      onGenerateRoute: (RouteSettings routeSettings) {
        final arguments = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case CompaniesView.routeName:
                return CompaniesView(controller: companiesController);
              case AssetsView.routeName when (arguments != null):
                return AssetsView(
                  controller: assetsController,
                  company: Company.fromJson(arguments),
                );
              default:
                return CompaniesView(controller: companiesController);
            }
          },
        );
      },
    );
  }
}
