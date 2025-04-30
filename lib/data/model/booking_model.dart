class BookingModel {
  dynamic id;
  String? email;
  String? phone;
  String? chair;
  String? day;
  String? total;
  dynamic approve;
  String? image; // Add the image field
  String? time;
  String? salonname;
  String? username;
  String? status; // Add status property
  String? salonid; // Add salon ID for rescheduling

  BookingModel({
    this.id,
    this.email,
    this.phone,
    this.chair,
    this.day,
    this.total,
    this.approve,
    this.image,
    this.time,
    this.salonname,
    this.username,
    this.status,
    this.salonid,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    chair = json['chair']?.toString();
    day = json['day']?.toString();
    total = json['total']?.toString();
    approve = json['approve']?.toString();
    image = json['image']?.toString();
    time = json['start_time']?.toString();
    salonname = json['name']?.toString();
    username = json['username']?.toString();
    status = json['status']?.toString();
    salonid = json['salonid']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['chair'] = this.chair;
    data['day'] = this.day;
    data['total'] = this.total;
    data['approve'] = this.approve;
    data['image'] = this.image;
    data['start_time'] = this.time;
    data['name'] = this.salonname;
    data['username'] = this.username;
    data['status'] = this.status;
    data['salonid'] = this.salonid;
    return data;
  }
}