
// class SalonModel {
//   String? status;
//   dynamic popsalons;
//   dynamic nearsalons;
//   List<Newsalons>? newsalons;

//   SalonModel({this.status, this.popsalons, this.nearsalons, this.newsalons});

//   SalonModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     popsalons = json["popsalons"];
//     nearsalons = json["nearsalons"];
//     newsalons = json["newsalons"] == null ? null : (json["newsalons"] as List).map((e) => Newsalons.fromJson(e)).toList();
//   }

//   static List<SalonModel> fromList(List<Map<String, dynamic>> list) {
//     return list.map(SalonModel.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["status"] = status;
//     _data["popsalons"] = popsalons;
//     _data["nearsalons"] = nearsalons;
//     if(newsalons != null) {
//       _data["newsalons"] = newsalons?.map((e) => e.toJson()).toList();
//     }
//     return _data;
//   }
// }

// class Newsalons {
//   int? id;
//   String? name;
//   String? email;
//   String? password;
//   String? gender;
//   String? phone;
//   int? rate;
//   int? chairs;
//   int? categoryId;
//   int? subscription;
//   String? image;
//   int? approve;
//   String? country;
//   String? city;
//   String? address;
//   String? createdAt;
//   String? updatedAt;

//   Newsalons({this.id, this.name, this.email, this.password, this.gender, this.phone, this.rate, this.chairs, this.categoryId, this.subscription, this.image, this.approve, this.country, this.city, this.address, this.createdAt, this.updatedAt});

//   Newsalons.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     name = json["name"];
//     email = json["email"];
//     password = json["password"];
//     gender = json["gender"];
//     phone = json["phone"];
//     rate = json["rate"];
//     chairs = json["chairs"];
//     categoryId = json["category_id"];
//     subscription = json["subscription"];
//     image = json["image"];
//     approve = json["approve"];
//     country = json["country"];
//     city = json["city"];
//     address = json["address"];
//     createdAt = json["created_at"];
//     updatedAt = json["updated_at"];
//   }

//   static List<Newsalons> fromList(List<Map<String, dynamic>> list) {
//     return list.map(Newsalons.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["name"] = name;
//     _data["email"] = email;
//     _data["password"] = password;
//     _data["gender"] = gender;
//     _data["phone"] = phone;
//     _data["rate"] = rate;
//     _data["chairs"] = chairs;
//     _data["category_id"] = categoryId;
//     _data["subscription"] = subscription;
//     _data["image"] = image;
//     _data["approve"] = approve;
//     _data["country"] = country;
//     _data["city"] = city;
//     _data["address"] = address;
//     _data["created_at"] = createdAt;
//     _data["updated_at"] = updatedAt;
//     return _data;
//   }
// }