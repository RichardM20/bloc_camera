part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class IsGrabacionEvent extends CameraEvent {
  //Saber si esta grabando o no
  final bool isGrabando;

  IsGrabacionEvent({this.isGrabando = false});
}

class IsFinalGrabacionEvent extends CameraEvent {
  //Saber si ya finalizo la grabacion
  final bool isfinalGrabacion;

  IsFinalGrabacionEvent({this.isfinalGrabacion = false});
}

class PathVideoEvent extends CameraEvent {
  //Obtener el path del video
  final String pathVideo;

  PathVideoEvent({this.pathVideo = ''});
}

class IsReproducinVideoEvent extends CameraEvent {
  //Saber si ya finalizo la grabacion
  final bool isReproducionVideo;

  IsReproducinVideoEvent({this.isReproducionVideo = false});
}
