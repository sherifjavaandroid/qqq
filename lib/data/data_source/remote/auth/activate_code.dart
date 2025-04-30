import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class ActivateCodeData {
  Crud crud;

  ActivateCodeData(this.crud);

  postData(
    String email,
    String verifyCode,
  ) async {
    var response = await crud.postData(AppLink.activateCode, {
      "email": email,
      "verifycode": verifyCode,
    });
    return response.fold((r) => r, (l) => l);
  }
}
