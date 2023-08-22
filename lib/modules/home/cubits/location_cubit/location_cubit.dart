import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayer/modules/home/cubits/location_cubit/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  static LocationCubit get(context) => BlocProvider.of(context);

  double latitude = 0;
  double longitude = 0;

  Future<void> fetchUserLocation() async {
    try {
      final LocationPermission permission =
          await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        emit(LocationLoadError("Location permission denied forever."));
        return;
      }

      if (permission == LocationPermission.denied) {
        emit(LocationLoadError("Location permission denied."));
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      print("Latitude: $latitude, Longitude: $longitude");

      emit(LocationLoaded(latitude, longitude));
    } catch (e) {
      emit(LocationLoadError("An error occurred while fetching location."));
    }
  }
}
