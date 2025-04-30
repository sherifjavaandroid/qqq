import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class HomeData {
  final Crud crud;

  HomeData(this.crud);

  Future<dynamic> viewSalons({
    double latitude = 0.0,
    double longitude = 0.0,
    bool useLocation = false
  }) async {
    String url = AppLink.home;

    // If location is enabled, add location parameters
    if (useLocation && latitude != 0.0 && longitude != 0.0) {
      url = "${AppLink.home}?lat=$latitude&lng=$longitude";
    }

    var response = await crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> feedbackSalonRating(
      int salonId, String rating, int? userId) async {
    if (userId == null) {
      return {"status": "error", "message": "User not logged in"};
    }

    const String url = AppLink.feedbackSalonRates;
    var response = await crud.postData(url, {
      "salon_id": salonId.toString(),
      "rating": rating,
      "user_id": userId.toString(),
    });

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getsalonRating(int salonId) async {
    var response = await crud.getData(
      "${AppLink.viewSalonRates}/$salonId",
    );
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> searchSalon(
      String search,
      int userid, {
        double latitude = 0.0,
        double longitude = 0.0,
        bool useLocation = false
      }) async {
    String url = "${AppLink.searchSalon}?user_id=$userid&query=$search";

    // If location is enabled, add location parameters
    if (useLocation && latitude != 0.0 && longitude != 0.0) {
      url = "$url&lat=$latitude&lng=$longitude";
    }

    var response = await crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }
}