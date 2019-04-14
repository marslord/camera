import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

List<CameraDescription> cameras;

class Cam extends StatefulWidget {
  @override
  _Cam createState() => _Cam();
}

class _Cam extends State<Cam> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: NativeDeviceOrientationReader(builder: (context) {
        NativeDeviceOrientation orientation =
            NativeDeviceOrientationReader.orientation(context);

        int turns;
        switch (orientation) {
          case NativeDeviceOrientation.landscapeLeft:
            turns = -1;
            break;
          case NativeDeviceOrientation.landscapeRight:
            turns = 1;
            break;
          case NativeDeviceOrientation.portraitDown:
            turns = 2;
            break;
          default:
            turns = 0;
            break;
        }

        return RotatedBox(
          quarterTurns: turns,
          child: Transform.scale(
            scale: 1 / controller.value.aspectRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          ),
        );
      }),
    );
  }
}
