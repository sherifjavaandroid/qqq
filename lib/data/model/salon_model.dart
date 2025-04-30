class SalonModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  int? rate;
  String? description;
  int? chairs;
  int? categoryId;
  String? image;
  String? verifycode;
  dynamic? approve;
  String? country;
  String? city;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? classification; // New field for Luxury/Economic classification

  SalonModel(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.rate,
        this.description,
        this.chairs,
        this.categoryId,
        this.image,
        this.verifycode,
        this.approve,
        this.country,
        this.city,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.classification}); // Added classification parameter

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    rate = json['rate'];
    description = json['description'];
    chairs = json['chairs'];
    categoryId = json['category_id'];
    image = json['image'];
    verifycode = json['verifycode'];
    approve = json['approve'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classification = json['classification']; // Parse classification from JSON
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['rate'] = rate;
    data['description'] = description;
    data['chairs'] = chairs;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['verifycode'] = verifycode;
    data['approve'] = approve;
    data['country'] = country;
    data['city'] = city;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['classification'] = classification;
    return data;
  }
}