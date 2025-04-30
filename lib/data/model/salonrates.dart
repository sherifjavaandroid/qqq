class SalonratesModel {
  String? status;
  Data? data;

  SalonratesModel({this.status, this.data});

  SalonratesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  static List<SalonratesModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(SalonratesModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
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
  dynamic? averageRating;
  int? totalRatings;

  Data(
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
      this.averageRating,
      this.totalRatings});

  Data.fromJson(Map<String, dynamic> json) {
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
    averageRating = json["average_rating"];
    totalRatings = json["total_ratings"];
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["password"] = password;
    _data["gender"] = gender;
    _data["phone"] = phone;
    _data["rate"] = rate;
    _data["chairs"] = chairs;
    _data["category_id"] = categoryId;
    _data["subscription"] = subscription;
    _data["image"] = image;
    _data["approve"] = approve;
    _data["country"] = country;
    _data["city"] = city;
    _data["address"] = address;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["average_rating"] = averageRating;
    _data["total_ratings"] = totalRatings;
    return _data;
  }
}
