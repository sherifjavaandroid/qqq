class AvailableTimesModel {
  bool? available;
  List<AvailableSlots>? availableSlots;

  AvailableTimesModel({this.available, this.availableSlots});

  AvailableTimesModel.fromJson(Map<String, dynamic> json) {
    available = json["available"];
    availableSlots = json["available_slots"] == null
        ? null
        : (json["available_slots"] as List)
            .map((e) => AvailableSlots.fromJson(e))
            .toList();
  }

  static List<AvailableTimesModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AvailableTimesModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["available"] = available;
    if (availableSlots != null) {
      _data["available_slots"] =
          availableSlots?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AvailableSlots {
  String? startTime;
  String? endTime;
  int? availableChairs;

  AvailableSlots({this.startTime, this.endTime, this.availableChairs});

  AvailableSlots.fromJson(Map<String, dynamic> json) {
    startTime = json["start_time"];
    endTime = json["end_time"];
    availableChairs = json["available_chairs"];
  }

  static List<AvailableSlots> fromList(List<Map<String, dynamic>> list) {
    return list.map(AvailableSlots.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    _data["available_chairs"] = availableChairs;
    return _data;
  }
}
