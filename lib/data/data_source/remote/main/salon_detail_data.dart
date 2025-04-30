import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class SalonDetailData {
  Crud crud;

  SalonDetailData(this.crud);

  getData(String id, String userid) async {
    var response = await crud.postData(AppLink.salonDetail, {
      "id": id,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  postData(String salonId, String userId) async {
    var response = await crud.postData(AppLink.addFavorite, {
      "salonid": salonId,
      "userid": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String salonId, String userId) async {
    var response = await crud.postData(AppLink.deleteFavorite, {
      "salonid": salonId,
      "userid": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postSalonRating(
      int salonId, double rating, int? userId) async {
    if (userId == null) {
      return {"status": "error", "message": "User not logged in"};
    }

    const String url = "https://dashboard.easycuteg.com/api/ratings";
    var response = await crud.postData(url, {
      "salon_id": salonId.toString(), // ✅ Convert int to String
      "rating": rating.toString(), // ✅ Convert double to String
      "user_id": userId.toString(), // ✅ Convert int to String
    });

    return response.fold((l) => l, (r) => r);
  }
}
