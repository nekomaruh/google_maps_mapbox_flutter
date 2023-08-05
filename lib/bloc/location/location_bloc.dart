import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/google_maps.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocationEvent>((event, emit) {
      emit(
        state.copyWith(
          lastKnownLocation: event.newLocation,
          locationHistory: [...state.locationHistory, event.newLocation]
        )
      );
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    print("position: $position");
  }

  void startFollowingUser() {
    print("start following user");
    positionStream = Geolocator.getPositionStream().listen((event) {
      print('geo event: $event');
      add(OnNewUserLocationEvent(LatLng(event.latitude, event.longitude)));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    print("stop following user");
  }

  @override
  Future<void> close() {
    positionStream?.cancel();
    return super.close();
  }
}
