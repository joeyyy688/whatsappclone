import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String? userPhoneNumber;
  late String verficationId;
  late List<CameraDescription> cameras = [];
  int selectedCamera = 0;
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  void setUserPhoneNumber(String phoneNumber) {
    this.userPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void setVerficationID(String verficationID) {
    this.verficationId = verficationID;
    notifyListeners();
  }

  void initializeAvailableCameras({
    required List<CameraDescription> cameras,
  }) {
    this.cameras = cameras;
    notifyListeners();
  }

  initializeCameraController(int cameraValue) {
    this.cameraController = CameraController(
      this.cameras[cameraValue],
      ResolutionPreset.ultraHigh,
    );
    notifyListeners();
  }

  void initializeCameraControllerFutures() =>
      this.initializeControllerFuture = this.cameraController.initialize();
  notifyListeners();

  void changeSelectedCameraValue(int value) {
    this.selectedCamera = value;
    notifyListeners();
  }
}
