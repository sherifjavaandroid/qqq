import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalonSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    // Override showResults to prevent any action when "search" on the keyboard is pressed
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text(
        'Use the suggestions list to select a salon.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<HomeControllerImp>(builder: (controller) {
      // Filter salons by name or location
      final suggestedSalons = controller.newSalons.where((salon) {
        return salon.name?.toLowerCase().contains(query.toLowerCase()) ??
            false || salon.address!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // Check if there are no suggestions available
      if (suggestedSalons.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text('No salons available.'.tr),
          ),
        );
      }

      return ListView.builder(
        itemCount: suggestedSalons.length,
        itemBuilder: (context, index) {
          final salon = suggestedSalons[index];

          // Verify that salon and salon.id are non-null before proceeding
          if (salon.id == null) {
            return const ListTile(
              leading: Icon(Icons.error),
              title: Text('Salon data is incomplete.'),
            );
          }

          return ListTile(
            leading: const Icon(Icons.store),
            title: RichText(
              text: TextSpan(
                text: salon.name!,
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: ' - ${salon.address ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Get.toNamed(
                AppRoute.salonDetails,
                arguments: {
                  "salonid": salon.id,
                },
              );
            },
          );
        },
      );
    });
  }
}
