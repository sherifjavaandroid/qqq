class CommentModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? body;

  CommentModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.body,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    body = json['body'];
  }

  get salonId => null;
}
