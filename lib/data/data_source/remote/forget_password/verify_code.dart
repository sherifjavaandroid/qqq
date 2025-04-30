import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class VerifyCodeData {
  Crud crud;

  VerifyCodeData(this.crud);

  postData(
    String email,
    String verifyCode,
  ) async {
    var response = await crud.postData(AppLink.verifyCode, {
      "email": email,
      "verifycode": verifyCode,
    });
    return response.fold((l) => l, (r) => r);
  }
}
