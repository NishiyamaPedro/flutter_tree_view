import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/assets/assets_controller.dart';
import 'src/assets/assets_service.dart';
import 'src/companies/companies_controller.dart';
import 'src/companies/companies_service.dart';

void main() async {
  final companiesController = CompaniesController(CompaniesService());
  final assetsController = AssetsController(
    AssetsService(),
    LocationsService(),
  );

  runApp(MyApp(
    companiesController: companiesController,
    assetsController: assetsController,
  ));
}
