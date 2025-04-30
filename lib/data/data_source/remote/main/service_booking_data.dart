import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class BookingServiceData {
  Crud crud;

  BookingServiceData(this.crud);

  postData(
    String bookingId,
    String serviceId,
  ) async {
    var response = await crud.postData(AppLink.addServiceBooking, {
      "bookingid": bookingId,
      "serviceid": serviceId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
