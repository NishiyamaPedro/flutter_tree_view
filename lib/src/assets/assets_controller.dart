import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

import '../tree_view/node.dart';
import 'assets_model.dart';
import 'assets_service.dart';

class AssetsController with ChangeNotifier {
  final AssetsService _assetsService;
  final LocationsService _locationsService;

  late Node<Asset> root;

  Set<dynamic> filters = {};

  String _searchText = '';

  AssetsController(this._assetsService, this._locationsService);

  Future<Node<Asset>> getAssets(companyId) async {
    // We fetch the locations and assets and merge the two lists.
    // Both are basically the same thing.
    final result = await Future.wait<List>([
      _locationsService.getAll(companyId),
      _assetsService.getAll(companyId)
    ]);

    final assets = result.reduce((value, element) => value + element);

    // Convert the list into a tree view
    return Node<Asset>.fromList(assets);
  }

  void toggleFilter(filter) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }

    _filter();

    notifyListeners();
  }

  void search(String text) {
    _searchText = text;

    _filter();
    notifyListeners();
  }

  void _filter() {
    _filterTree(root);
  }

  void _filterTree(Node<Asset> node) {
    // Reset current node visibility
    node.isVisible = null;

    // Only filter if we have filters in the set or in the search text
    if (filters.isNotEmpty || _searchText.isNotEmpty) {
      bool isVisible = true;
      Set toFilter = {node.data?.sensorType, node.data?.status};

      // Check that the filters are present
      for (var filter in filters) {
        isVisible &= toFilter.contains(filter);
      }

      // If the node is visible and the parent node has not been matched,
      // we try to match the current node.
      node.isTextSimilar = node.parent?.isTextSimilar == true ||
          isVisible &&
              node.data?.name != null &&
              (node.data?.name
                          .toLowerCase()
                          .similarityTo(_searchText.toLowerCase()) ??
                      1) >=
                  0.4;

      // don't filter by text if it's empty
      if (_searchText.isNotEmpty) isVisible &= node.isTextSimilar ?? true;

      node.isVisible = isVisible;
    }

    //
    if (node.children == null) return;

    for (var child in node.children!) {
      _filterTree(child);
    }
  }
}
