import 'dart:io';

import 'package:bloc_camera_axample/bloc/camera_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class HomeCameraPage extends StatefulWidget {
  const HomeCameraPage({super.key});

  @override
  State<HomeCameraPage> createState() => _HomeCameraPageState();
}

class _HomeCameraPageState extends State<HomeCameraPage> {
  CameraController? _cameraController;
  VideoPlayerController? _videoPlayerController;
  @override
  void initState() {
    super.initState();

    // initCamera();
  }

  initCamera() async {
    _cameraController = CameraController(
      await availableCameras().then((cameras) => cameras.first),
      ResolutionPreset.high,
    );
    await _cameraController!.initialize();
    setState(() {});
  }

  initRecordeing() async {
    print('ESTA ENTRANDO A INIT');

    final cameraBloc = BlocProvider.of<CameraBloc>(context, listen: false); //MAndamos a llamar al bloc
    await initCamera();
    cameraBloc.isRecording(isReconding: true); //Cambiamos la variable para que el estado sepa que estamos grabando
    await _cameraController!.startVideoRecording();
    await Future.delayed(const Duration(seconds: 30));
    await stopRecording();
  }

  Future stopRecording() async {
    print('ESTA ENTRANDO A DISPOSE');
    final cameraBloc = BlocProvider.of<CameraBloc>(context, listen: false); //MAndamos a llamar al bloc

    final pathVideo = await _cameraController!.stopVideoRecording();
    cameraBloc.isRecording(isReconding: false); //Cambiamos la variable para que el estado sepa que no estamos grabando

    if (pathVideo.path.isNotEmpty) {
      print('Path del video: ${pathVideo.path}');
      cameraBloc.getPathVideo(videoPath: pathVideo.path);
      _videoPlayerController = VideoPlayerController.file(File(pathVideo.path));
      _videoPlayerController!.initialize();
      cameraBloc.isFinaliGrabacion(isRecondingfinal: true);
      // await _cameraController!.dispose();
    }
  }

  initReproduccionVideo() {
    final cameraBloc = BlocProvider.of<CameraBloc>(context, listen: false); //MAndamos a llamar al bloc

    print(_videoPlayerController!.value.isPlaying);
    if (!_videoPlayerController!.value.isPlaying) {
      _videoPlayerController!.play();
      // isReproduccionVideo = true;
    } else {
      _videoPlayerController!.pause();
      // isReproduccionVideo = false;
    }
    _videoPlayerController!.addListener(() {
      // _videoPlayerController!.value.isPlaying;
      cameraBloc.isReproducionVideo(isReproducionVideo: _videoPlayerController!.value.isPlaying);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _cameraController!.dispose();
    _videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: BlocBuilder<CameraBloc, CameraState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.pathVideo.isEmpty) ...[
                  SizedBox(
                    height: 400,
                    width: 300,
                    child: _cameraController != null && _cameraController!.value.isInitialized
                        ? CameraPreview(_cameraController!)
                        : const SizedBox(child: Center(child: Text('Hunde en grabar para empezar'))),
                  ),
                ] else ...[
                  const Text('Video Grabado: '),
                  SizedBox(
                    height: 400,
                    width: 300,
                    child: _videoPlayerController != null && state.isfinalGrabacion
                        ? VideoPlayer(_videoPlayerController!)
                        : const CircularProgressIndicator(),
                  ),
                ],
                if (state.isGrabando) const Text('Grabando...'),
                if (state.pathVideo.isEmpty) ...[
                  ElevatedButton(
                    onPressed: () {
                      print('Stap1');
                      if (!state.isGrabando) {
                        print('Stap2');

                        initRecordeing();
                      } else {
                        print('Stap3');

                        stopRecording();
                      }
                    },
                    child: Text(state.isGrabando ? 'Detener' : 'Grabar'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      initReproduccionVideo();
                    },
                    child: Text(state.isReproducirVideo ? 'Stop Video' : 'Reproducir video'),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
