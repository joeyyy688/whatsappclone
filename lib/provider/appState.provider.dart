import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String? userPhoneNumber;
  late String verficationId;

  void setUserPhoneNumber(String phoneNumber) {
    this.userPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void setVerficationID(String verficationID) {
    this.verficationId = verficationID;
    notifyListeners();
  }
}
