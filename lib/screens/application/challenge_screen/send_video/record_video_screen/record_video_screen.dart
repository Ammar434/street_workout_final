import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar.dart';
import '../../../../../widgets/loading_widget.dart';
import 'video_page.dart';

class RecordVideoScreen extends StatefulWidget {
  const RecordVideoScreen({Key? key, required this.challengeId}) : super(key: key);
  static String name = 'RcordVideoScreen';
  final String challengeId;

  @override
  State<RecordVideoScreen> createState() => _RecordVideoScreenState();
}

class _RecordVideoScreenState extends State<RecordVideoScreen> {
  bool isLoading = true;
  bool _isRecording = false;

  late CameraController _cameraController;

  void initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(front, ResolutionPreset.low);
    await _cameraController.initialize();
    setState(() {
      isLoading = false;
    });
  }

  void recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(
          filePath: file.path,
          challengeId: widget.challengeId,
        ),
      );
      if (!mounted) return;
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
      return Scaffold(
        appBar: buildAppBar(context, "Record your training"),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.circle,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => recordVideo(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
