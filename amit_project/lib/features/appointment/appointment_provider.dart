import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  int? doctorId;
  String? date;
  String? time;
  String appointmentType = "in_person";
  String paymentMethod = "card";

  void setDoctor(int id) {
    doctorId = id;
    notifyListeners();
  }

  void setDate(String d) {
    date = d;
    notifyListeners();
  }

  void setTime(String t) {
    time = t;
    notifyListeners();
  }

  void setAppointmentType(String type) {
    appointmentType = type;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }

  bool get isReady =>
      doctorId != null && date != null && time != null;
}
