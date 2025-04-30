import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchSalon extends StatelessWidget {
  const SearchSalon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return GetBuilder<HomeControllerImp>(builder: (controller) {
      final suggestedSalons = controller.newSalons.where((salon) {
        return salon.name
                ?.toLowerCase()
                .contains(searchController.text.toLowerCase()) ??
            false ||
                salon.address!
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase());
      }).toList();

      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async {
          // Prevent stack duplication by pushing only one instance of the home screen.
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.home,
            (Route<dynamic> route) => false,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: searchController,
              onChanged: (value) => controller.searchSalon(value),
              decoration: InputDecoration(
                hintText: 'Search for a Salon or nearest city...'.tr,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            backgroundColor: AppColor.selectedColor,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: controller.statusRequest == StatusRequest.loading
                ? const Center(child: CircularProgressIndicator())
                : controller.searchResults.isEmpty
                    ?

                    // Center(
                    //     child: Text(
                    //       'Search for a Salon or nearest city...'.tr,
                    //       style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                    //     ),
                    //   )

                    ListView.builder(
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

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${AppLink.imageSalons}${salon.image}'),
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                              ),
                              title: Text(
                                salon.name ?? 'Unknown Salon',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 16, color: Colors.red),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          salon.address ??
                                              'No address available',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.isLoggedIn
                                      ? Row(
                                          children: [
                                            const Icon(Icons.phone,
                                                size: 16, color: Colors.green),
                                            const SizedBox(width: 5),
                                            Text(
                                              salon.phone ?? 'No phone number',
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 18, color: Colors.blueAccent),
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.salonDetails,
                                  arguments: {
                                    "salonid": salon.id,
                                  },
                                );
                              },
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final salon = controller.searchResults[index];
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${AppLink.imageSalons}${salon.image}'),
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                              ),
                              title: Text(
                                salon.name!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 16, color: Colors.red),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          salon.address!,
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.isLoggedIn
                                      ? Row(
                                          children: [
                                            const Icon(Icons.phone,
                                                size: 16, color: Colors.green),
                                            const SizedBox(width: 5),
                                            Text(
                                              salon.phone!,
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 18, color: Colors.blueAccent),
                              onTap: () {
                                // Navigate to salon details screen
                                Get.toNamed(
                                  AppRoute.salonDetails,
                                  arguments: {"salonid": salon.id},
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ),
      );
    });
  }
}
