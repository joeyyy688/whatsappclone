import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappclone/mediaQuery/size_helpers.dart';
import 'package:whatsappclone/pages/displayPictureScreen.dart';
import 'package:whatsappclone/provider/appStateProvider.dart';

class CameraPage extends StatefulWidget {
  CameraPage({
    Key? key,
  }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<File> capturedImages = [];
  int selectedCamera = 0;

  @override
  Widget build(BuildContext context) {
    final appStateValue = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<AppState>(
            builder: (context, appStateValue, child) {
              return FutureBuilder(
                future: appStateValue.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return CameraPreview(
                      appStateValue.cameraController,
                    );
                  } else {
                    // Otherwise, display a loading indicator.
                    return Container(
                      color: Colors.black,
                    );
                  }
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (appStateValue.cameras.length > 1) {
                      selectedCamera =
                          appStateValue.selectedCamera == 0 ? 1 : 0;
                      appStateValue.changeSelectedCameraValue(selectedCamera);
                      appStateValue.initializeCameraController(
                          appStateValue.selectedCamera);
                      appStateValue.initializeCameraControllerFutures();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No secondary camera found'),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  icon: Icon(Icons.switch_camera_rounded, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () async {
                    await appStateValue.initializeControllerFuture;
                    var xFile =
                        await appStateValue.cameraController.takePicture();
                    setState(() {
                      capturedImages.add(File(xFile.path));
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (capturedImages.isEmpty) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                                  imagePath: capturedImages.first.path,
                                )));
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      image: capturedImages.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(capturedImages.last),
                              fit: BoxFit.cover)
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
