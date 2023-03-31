import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraState(isfinalGrabacion: false, isGrabando: false, pathVideo: '', isReproducirVideo: false)) {
    on<IsGrabacionEvent>((event, emit) {
      emit(state.copyWith(isGrabando: event.isGrabando));
    });
    on<PathVideoEvent>((event, emit) {
      emit(state.copyWith(pathVideo: event.pathVideo));
    });
    on<IsFinalGrabacionEvent>((event, emit) {
      emit(state.copyWith(isfinalGrabacion: event.isfinalGrabacion));
    });
    on<IsReproducinVideoEvent>((event, emit) {
      emit(state.copyWith(isReproducirVideo: event.isReproducionVideo));
    });
  }

  isRecording({required bool isReconding}) {
    add(IsGrabacionEvent(isGrabando: isReconding));
  }

  getPathVideo({required String videoPath}) {
    add(PathVideoEvent(pathVideo: videoPath));
  }

  isFinaliGrabacion({required bool isRecondingfinal}) {
    add(IsFinalGrabacionEvent(isfinalGrabacion: isRecondingfinal));
  }

  isReproducionVideo({required bool isReproducionVideo}) {
    add(IsReproducinVideoEvent(isReproducionVideo: isReproducionVideo));
  }
}
