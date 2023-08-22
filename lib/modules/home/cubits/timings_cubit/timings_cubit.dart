import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prayer/modules/home/cubits/location_cubit/location_cubit.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_state.dart';

class TimingsCubit extends Cubit<TimingsState> {
  TimingsCubit() : super(TimingsInitial());

  static TimingsCubit get(context) => BlocProvider.of(context);

  DateTime selectedDay = DateTime.now();
  Map<String, String> timings = {};

  Future<void> fetchTimings() async {
    try {
      print("Fetching timings...");
      emit(TimingsLoading()); // Emit loading state
      final locationCubit = LocationCubit();
      await locationCubit.fetchUserLocation();
      double lat = locationCubit.latitude; // Fetch location before timings
      double long = locationCubit.longitude; // Fetch location before timings
      final formattedSelectedDate = DateFormat('dd-MM-y').format(selectedDay);
      print(formattedSelectedDate);
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timings/$formattedSelectedDate?latitude=$lat&longitude=$long&method=2'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        timings = (data['data']['timings'] as Map<String, dynamic>)
            .cast<String, String>();

        print("Timings fetched successfully: $timings");
        emit(TimingsLoaded(timings)); // Emit loaded state
      } else {
        print("Error fetching timings from API: ${response.statusCode}");
        emit(TimingsLoadError(
            "Error fetching timings from API")); // Emit error state
      }
    } catch (e, stackTrace) {
      print("An error occurred while fetching timings: $e");
      print(stackTrace);
      emit(TimingsLoadError(
          "An error occurred while fetching timings.")); // Emit error state
    }
  }

  void changeSelectedDay(DateTime newDate) async {
    print("Selected day changed: $newDate");
    selectedDay = newDate;
    await fetchTimings();
    emit(SelectedDayChanged(newDate)); // Emit selected day changed state
  }
}
