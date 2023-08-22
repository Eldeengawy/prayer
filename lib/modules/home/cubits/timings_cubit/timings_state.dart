abstract class TimingsState {}

class TimingsInitial extends TimingsState {}

class TimingsLoading extends TimingsState {}

class TimingsLoaded extends TimingsState {
  final Map<String, String> timings;

  TimingsLoaded(this.timings);
}

class TimingsLoadError extends TimingsState {
  final String errorMessage;

  TimingsLoadError(this.errorMessage);
}

class SelectedDayChanged extends TimingsState {
  final DateTime newSelectedDay;

  SelectedDayChanged(this.newSelectedDay);
}
