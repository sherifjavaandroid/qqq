
class Feeddbackrates {
  String? message;
  Rating? rating;

  Feeddbackrates({this.message, this.rating});

  Feeddbackrates.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    rating = json["rating"] == null ? null : Rating.fromJson(json["rating"]);
  }

  static List<Feeddbackrates> fromList(List<Map<String, dynamic>> list) {
    return list.map(Feeddbackrates.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if(rating != null) {
      _data["rating"] = rating?.toJson();
    }
    return _data;
  }
}

class Rating {
  int? id;
  int? userId;
  int? salonId;
  String? rating;
  String? createdAt;
  String? updatedAt;

  Rating({this.id, this.userId, this.salonId, this.rating, this.createdAt, this.updatedAt});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    salonId = json["salon_id"];
    rating = json["rating"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  static List<Rating> fromList(List<Map<String, dynamic>> list) {
    return list.map(Rating.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["salon_id"] = salonId;
    _data["rating"] = rating;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}