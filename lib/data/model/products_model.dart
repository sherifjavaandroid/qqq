class ProductModel {
  int? id;
  String? salonid;
  String? name;
  int? price;
  int? number;
  String? image;

  ProductModel({
    this.id,
    this.salonid,
    this.name,
    this.price,
    this.number,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonid = json['salonid'];
    name = json['name'];
    price = json['price'];
    number = json['number'];
    image = json['image'];
  }
}
