class Doctor {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;

  final String specialization; 
  final String city;  

  final int price;
  final String startTime;
  final String endTime;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.price,
    required this.startTime,
    required this.endTime,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      photo: json["photo"] ?? "",
      gender: json["gender"] ?? "",
      address: json["address"] ?? "",
      description: json["description"] ?? "",
      degree: json["degree"] ?? "",

      specialization: json["specialization"]?["name"] ?? "",
      city: json["city"]?["name"] ?? "",

      price: json["appoint_price"] ?? 0,
      startTime: json["start_time"] ?? "",
      endTime: json["end_time"] ?? "",
    );
  }
}
