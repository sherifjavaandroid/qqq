class StateModel {
  String? name;
  List<String>? cities;

  StateModel({this.name, this.cities});

  StateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cities'] = this.cities;
    return data;
  }
}