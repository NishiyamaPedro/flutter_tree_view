import 'companies_model.dart';
import 'companies_service.dart';

class CompaniesController {
  final CompaniesService _companiesService;

  CompaniesController(this._companiesService);

  Future<List<Company>> getCompanies() async {
    return await _companiesService.getAll();
  }
}
