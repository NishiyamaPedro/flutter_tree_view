import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'companies_model.dart';

class CompaniesService {
  Future<List<Company>> getAll() async {
    final response = await http.get(Uri.https(
      'fake-api.tractian.com',
      '/companies',
    ));

    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body) as List)
          .map((item) => Company.fromJson(item))
          .toList();
    }

    return [];
  }
}
