import 'dart:developer';
import 'dart:io';

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/camera/after_capture_Statue_info_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../test_data.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;

  File? _imageFile;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 2.0;

  // Current values
  double _currentZoomLevel = 1.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.veryHigh;

  List<CameraDescription> cameras = [];

  Future<void> initCamera() async {
    // Fetch the available cameras before initializing the app.
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }
  }

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      log('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      onNewCameraSelected(cameras[0]);
      refreshAlreadyCapturedImages();
    } else {
      log('Camera Permission: DENIED');
    }
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    for (var file in fileList) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    }

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.mp4')) {
        _imageFile = null;
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
      }

      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    // Hide the status bar in Android
    initCamera();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    getPermissionStatus();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _isCameraPermissionGranted
            ? _isCameraInitialized
                ? Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / controller!.value.aspectRatio,
                        child: Stack(
                          children: [
                            CameraPreview(
                              controller!,
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTapDown: (details) =>
                                      onViewFinderTap(details, constraints),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16.0,
                                8.0,
                                16.0,
                                8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                        ),
                                        child: TextButton(
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context).translate("snap tips"),
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 40,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                ],
                                              ),
                                              content: SizedBox(
                                                height: 300.0,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context).translate("snap tip1"),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context).translate("snap tip2"),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context).translate("snap tip3"),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(AppLocalizations.of(context).translate("got it")),
                                                ),
                                              ],
                                              elevation: 24.0,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.info_outlined,
                                            color: Color(0xffFFB319),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 8.0, top: 16.0),
                                  ),
                                  const Expanded(
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Slider(
                                          value: _currentZoomLevel,
                                          min: _minAvailableZoom,
                                          max: _maxAvailableZoom,
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.white30,
                                          onChanged: (value) async {
                                            setState(() {
                                              _currentZoomLevel = value;
                                            });
                                            await controller!
                                                .setZoomLevel(value);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _currentZoomLevel
                                                      .toStringAsFixed(1) +
                                                  'x',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: _isRecordingInProgress
                                            ? () async {}
                                            : () {
                                                setState(() {
                                                  _isCameraInitialized = false;
                                                });
                                                onNewCameraSelected(cameras[
                                                    _isRearCameraSelected
                                                        ? 1
                                                        : 0]);
                                                setState(() {
                                                  _isRearCameraSelected =
                                                      !_isRearCameraSelected;
                                                });
                                              },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              color: Colors.transparent,
                                              size: 60,
                                            ),
                                            _isRecordingInProgress
                                                ? controller!
                                                        .value.isRecordingPaused
                                                    ? const Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                    : const Icon(
                                                        Icons.pause,
                                                        color: Colors.white,
                                                        size: 30,
                                                      )
                                                : Icon(
                                                    _isRearCameraSelected
                                                        ? Icons.camera_front
                                                        : Icons.camera_rear,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _isVideoCameraSelected
                                            ? () async {}
                                            : () async {
                                                XFile? rawImage =
                                                    await takePicture();
                                                File imageFile =
                                                    File(rawImage!.path);

                                                int currentUnix = DateTime.now()
                                                    .millisecondsSinceEpoch;

                                                final directory =
                                                    await getApplicationDocumentsDirectory();

                                                String fileFormat = imageFile
                                                    .path
                                                    .split('.')
                                                    .last;

                                                print(fileFormat);

                                                await imageFile.copy(
                                                  '${directory.path}/$currentUnix.$fileFormat',
                                                );

                                                refreshAlreadyCapturedImages();
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                      AfterCaptureStatueInfoScreen(
                                                        info: statues[0],
                                                        imageFile: _imageFile!,
                                                        fileList: allFileList,
                                                    ),
                                                  ),
                                                );
                                              },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: _isVideoCameraSelected
                                                  ? Colors.white
                                                  : Colors.white38,
                                              size: 80,
                                            ),
                                            Icon(
                                              Icons.circle,
                                              color: _isVideoCameraSelected
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 65,
                                            ),
                                            _isVideoCameraSelected &&
                                                    _isRecordingInProgress
                                                ? const Icon(
                                                    Icons.stop_rounded,
                                                    color: Colors.white,
                                                    size: 32,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _imageFile != null
                                            ? () {
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //    PreviewScreen(
                                                //       imageFile: _imageFile!,
                                                //       fileList: allFileList,
                                                //     ),
                                                //   ),
                                                // );
                                              }
                                            : null,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            image: _imageFile != null
                                                ? DecorationImage(
                                                    image:
                                                        FileImage(_imageFile!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.off;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.off,
                                        );
                                      },
                                      child: Icon(
                                        Icons.flash_off,
                                        color:
                                            _currentFlashMode == FlashMode.off
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.auto;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.auto,
                                        );
                                      },
                                      child: Icon(
                                        Icons.flash_auto,
                                        color:
                                            _currentFlashMode == FlashMode.auto
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.always;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.always,
                                        );
                                      },
                                      child: Icon(
                                        Icons.flash_on,
                                        color: _currentFlashMode ==
                                                FlashMode.always
                                            ? Colors.amber
                                            : Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.torch;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.torch,
                                        );
                                      },
                                      child: Icon(
                                        Icons.highlight,
                                        color:
                                            _currentFlashMode == FlashMode.torch
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'LOADING',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(),
                  const Text(
                    'Permission denied',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      getPermissionStatus();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Give permission',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
