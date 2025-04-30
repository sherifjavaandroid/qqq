class ProfileModel {
  int? id;
  String? name;
  String? email;
  int? verifycode;
  String? phone;
  String? image;
  String? gender;
  int? approve;
  String? country;
  String? city;
  String? address;
  String? createdAt;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.verifycode,
    this.phone,
    this.image,
    this.gender,
    this.approve,
    this.country,
    this.city,
    this.address,
    this.createdAt,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    image = json['image'];
    verifycode = json['verifycode'];
    approve = json['approve'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    createdAt = json['created_at'];
  }
}
