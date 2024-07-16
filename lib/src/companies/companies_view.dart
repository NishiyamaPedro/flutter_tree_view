import 'package:flutter/material.dart';

import '../assets/assets_view.dart';
import 'companies_controller.dart';
import 'companies_model.dart';

class CompaniesView extends StatelessWidget {
  static const routeName = '/';

  final CompaniesController controller;

  const CompaniesView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Company>>(
          future: controller.getCompanies(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Company>> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Unable to retrieve companies.'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final companies = snapshot.data!;
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.workspaces_outline),
                    title: Text('${companies[index].name} Unit'),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      Navigator.restorablePushNamed(
                        context,
                        AssetsView.routeName,
                        arguments: companies[index].toJson(),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
