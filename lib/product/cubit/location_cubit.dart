import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

enum LocationCubitStatus { initial, loading, success, failure }

class LocationCubitState with EquatableMixin {
  final LocationCubitStatus status;
  final Position? position;

  LocationCubitState({
    this.status = LocationCubitStatus.initial,
    this.position,
  });

  LocationCubitState copyWith({
    LocationCubitStatus? status,
    Position? position,
  }) =>
      LocationCubitState(
        status: status ?? this.status,
        position: position ?? this.position,
      );

  @override
  List<Object?> get props => [status, position];
}

class LocationCubit extends Cubit<LocationCubitState> {
  LocationCubit() : super(LocationCubitState());

  Future<void> getLocation() async {
    emit(state.copyWith(status: LocationCubitStatus.loading));
    try {
      final position = await Geolocator.getCurrentPosition();
      emit(
        state.copyWith(
          status: LocationCubitStatus.success,
          position: position,
        ),
      );
    } on LocationServiceDisabledException catch (_) {
      final position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        emit(
          state.copyWith(
            status: LocationCubitStatus.success,
            position: position,
          ),
        );
        return;
      }
      emit(state.copyWith(status: LocationCubitStatus.failure));
    } catch (_) {
      emit(state.copyWith(status: LocationCubitStatus.failure));
    }
  }
}
