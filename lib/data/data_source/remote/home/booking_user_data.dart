import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class BookingUserData {
  Crud crud;

  BookingUserData(this.crud);

  getData(String userId) async {
    var response = await crud.postData(AppLink.viewBookings, {
      "userid": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
