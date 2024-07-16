import 'package:flutter/material.dart';

import '../companies/companies_model.dart';
import '../tree_view/node.dart';
import '../tree_view/tree_node.dart';
import '../tree_view/tree_view.dart';
import 'assets_controller.dart';
import 'assets_model.dart';

class AssetsView extends StatelessWidget {
  static const routeName = '/assets';

  final Company company;
  final AssetsController controller;

  const AssetsView({
    super.key,
    required this.controller,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    controller.filters.clear();

    return Scaffold(
      appBar: AppBar(
        title: Text('${company.name} Unit'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search assets or locations...',
              ),
              onSubmitted: (text) => controller.search(text),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
            child: ListenableBuilder(
              listenable: controller,
              builder: (BuildContext context, Widget? child) {
                return Row(
                  children: [
                    FilterChip(
                      avatar: const Icon(Icons.bolt),
                      label: const Text('Energy Sensor'),
                      selected:
                          controller.filters.contains(AssetSensorType.energy),
                      onSelected: (_) {
                        controller.toggleFilter(AssetSensorType.energy);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      avatar: const Icon(Icons.warning_amber_rounded),
                      label: const Text('Alert'),
                      selected: controller.filters.contains(AssetStatus.alert),
                      onSelected: (_) {
                        controller.toggleFilter(AssetStatus.alert);
                      },
                    )
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Expanded(
            child: FutureBuilder<Node<Asset>>(
              future: controller.getAssets(company.id),
              builder:
                  (BuildContext context, AsyncSnapshot<Node<Asset>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Unable to retrieve assets.'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                controller.root = snapshot.data!;
                return ListenableBuilder(
                  listenable: controller,
                  builder: (BuildContext context, Widget? child) {
                    return TreeView(
                      root: controller.root,
                      itemBuilder: (Node<Asset> node) {
                        final data = node.data;
                        return TreeNodeItem(
                          title: Row(
                            children: [
                              if (node.parent?.id == null &&
                                  data?.sensorType == null)
                                const Image(
                                  width: 16,
                                  height: 16,
                                  image:
                                      AssetImage('assets/images/location.png'),
                                ),
                              if (data?.sensorType != null)
                                const Image(
                                  width: 16,
                                  height: 16,
                                  image:
                                      AssetImage('assets/images/component.png'),
                                ),
                              if (node.parent?.id != null &&
                                  data?.sensorType == null)
                                const Image(
                                  width: 16,
                                  height: 16,
                                  image: AssetImage('assets/images/asset.png'),
                                ),
                              const SizedBox(width: 8.0),
                              Flexible(
                                child: Text(
                                  data?.name ?? 'No name',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (data?.status != null)
                                const SizedBox(width: 8.0),
                              if (data?.status != null)
                                Badge(
                                  backgroundColor:
                                      data?.status == AssetStatus.operating
                                          ? Colors.green
                                          : Colors.red,
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
