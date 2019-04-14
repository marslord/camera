import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:ar_war/cam.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  cameras = await availableCameras();
  runApp(MaterialApp(
    home: Cam(),
  ));
}