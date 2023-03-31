part of 'camera_bloc.dart';

class CameraState {
  //Saber si esta grabando o no
  final bool isGrabando;

  //Saber si ya finalizo la grabacion
  final bool isfinalGrabacion;

  //Saber si se esta reproducionedo el video
  final bool isReproducirVideo;

  //Obtener el path del video
  final String pathVideo;

  CameraState({required this.isGrabando, required this.isfinalGrabacion, required this.pathVideo, required this.isReproducirVideo});

  CameraState copyWith({bool? isGrabando, bool? isfinalGrabacion, String? pathVideo, bool? isReproducirVideo}) => CameraState(
        isGrabando: isGrabando ?? this.isGrabando,
        isfinalGrabacion: isfinalGrabacion ?? this.isfinalGrabacion,
        pathVideo: pathVideo ?? this.pathVideo,
        isReproducirVideo: isReproducirVideo ?? this.isReproducirVideo,
      );
}
