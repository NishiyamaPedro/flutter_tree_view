import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'assets_model.dart';

class AssetsService {
  Future<List<Asset>> getAll(companyId) async {
    final response = await http.get(Uri.https(
      'fake-api.tractian.com',
      '/companies/$companyId/assets',
    ));

    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body) as List)
          .map((item) => Asset.fromJson(item))
          .toList();
    }

    return [];
  }
}

class LocationsService {
  Future<List<Asset>> getAll(companyId) async {
    final response = await http.get(Uri.https(
      'fake-api.tractian.com',
      '/companies/$companyId/locations',
    ));

    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body) as List)
          .map((item) => Asset.fromJson(item))
          .toList();
    }

    return [];
  }
}
