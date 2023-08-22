abstract class LocationState {}

class LocationInitial extends LocationState {}

// class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final double latitude;
  final double longitude;

  LocationLoaded(this.latitude, this.longitude);
}

class LocationLoadError extends LocationState {
  final String errorMessage;

  LocationLoadError(this.errorMessage);
}
