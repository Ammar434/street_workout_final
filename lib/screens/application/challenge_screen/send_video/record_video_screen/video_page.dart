import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/services/record_video/record_video_methods.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final String challengeId;

  const VideoPage({Key? key, required this.filePath, required this.challengeId}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  late RecordVideoMethods recordVideoMethods;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    recordVideoMethods = RecordVideoMethods();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  void onTap() async {
    bool isUserHaveVideo = await recordVideoMethods.isUserHavePendingVideo();
    if (isUserHaveVideo == false) {
      setState(() {
        isUploading = true;
      });
      String res = await recordVideoMethods.uploadUserVideo(
        File(widget.filePath),
        widget.challengeId,
      );
      setState(() {
        isUploading = false;
      });

      if (res == "Success") {
        customShowSnackBar(
          globalKey: _scaffoldKey,
          title: "Succes",
          content: "We receive your video we will evaluate your challenge as soon as possible",
          contentType: ContentType.warning,
        );
        // Navigator.of(context).pop();
        // Navigator.of(context).pop();
      }
    } else {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Warning",
        content: "You already submited one video be patient we will evaluate your challenge soon",
        contentType: ContentType.warning,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(
        context,
        "Preview",
        trailling: [
          isUploading
              ? const LoadingWidget()
              : IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: onTap,
                ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            return Center(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: VideoPlayer(
                  _videoPlayerController,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
