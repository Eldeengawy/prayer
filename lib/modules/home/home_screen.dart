import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/core/app_colors.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_cubit.dart';
import 'package:prayer/modules/home/widgets/custom_calendar_widget.dart';
import 'package:prayer/modules/home/widgets/custom_timing_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            TimingsCubit()..fetchTimings(), // Fetch initial timings.
        child: const SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: Column(
                children: [
                  CustomCalendar(),
                  SizedBox(
                    height: 40.0,
                  ),
                  CustomTimingWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}
