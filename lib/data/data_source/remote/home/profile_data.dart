import 'dart:io';
import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';

class ProfileData {
  Crud crud;
  ProfileData(this.crud);

  postData(String userid) async {
    var response = await crud.postData(AppLink.userInfo, {"id": userid});
    return response.fold((l) => l, (r) => r);
  }

  updateProfile(
      String userId,
      String name,
      String email,
      String phone,
      String address,
      String? password,
      ) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    };

    // Only add password if it's being updated
    if (password != null) {
      data["password"] = password;
    }

    var response = await crud.postData(
        "https://dashboard.easycuteg.com/api/v1/auth/profile/update",
        data
    );
    return response.fold((l) => l, (r) => r);
  }

  updateProfileWithImage(
      String userId,
      File imageFile,
      ) async {
    Map<String, String> data = {
      "user_id": userId,
    };

    var response = await crud.postDataWithFile(
        AppLink.updateProfileWithImage,
        data,
        imageFile,

    );
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String userid, String image) async {
    var response = await crud.postData(AppLink.userDelete, {
      "id": userid,
      "image": image,
    });
    return response.fold((l) => l, (r) => r);
  }
}