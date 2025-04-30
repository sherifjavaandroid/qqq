class FavoriteModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? phone;
  int? rate;
  int? chairs;
  int? categoryId;
  int? subscription;
  String? image;
  int? approve;
  String? country;
  String? city;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? salonId;
  int? userId;

  FavoriteModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.gender,
      this.phone,
      this.rate,
      this.chairs,
      this.categoryId,
      this.subscription,
      this.image,
      this.approve,
      this.country,
      this.city,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.salonId,
      this.userId});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    password = json["password"];
    gender = json["gender"];
    phone = json["phone"];
    rate = json["rate"];
    chairs = json["chairs"];
    categoryId = json["category_id"];
    subscription = json["subscription"];
    image = json["image"];
    approve = json["approve"];
    country = json["country"];
    city = json["city"];
    address = json["address"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    salonId = json["salon_id"];
    userId = json["user_id"];
  }

  static List<FavoriteModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(FavoriteModel.fromJson).toList();
  }
}
