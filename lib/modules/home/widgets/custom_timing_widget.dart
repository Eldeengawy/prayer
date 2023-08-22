import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prayer/core/app_colors.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_cubit.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_state.dart';
import 'package:prayer/modules/home/widgets/divider.dart';
import 'package:prayer/modules/home/widgets/time_row.dart';

class CustomTimingWidget extends StatelessWidget {
  const CustomTimingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimingsCubit, TimingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  ConditionalBuilder(
                    // condition: state is! TimingsLoaded,
                    condition: state is TimingsLoading,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    fallback: (context) {
                      //for all timings
                      // return Column(
                      //   children: [
                      // for (final entry in timings.entries)
                      //   Column(
                      //     children: [
                      //       TimeRow(
                      //         title: entry.key,
                      //         time: entry.value.toString(),
                      //       ),
                      //       const CustomDivider(),
                      //     ],
                      //   )
                      return ConditionalBuilder(
                        condition: state is TimingsLoadError,
                        fallback: (BuildContext context) => Column(
                          children: [
                            TimeRow(
                                title: 'Fajr',
                                time: TimingsCubit.get(context)
                                    .timings['Fajr']
                                    .toString()),
                            const CustomDivider(),
                            TimeRow(
                                title: 'Duhr',
                                time: TimingsCubit.get(context)
                                    .timings['Dhuhr']
                                    .toString()),
                            const CustomDivider(),
                            TimeRow(
                                title: 'Asr',
                                time: TimingsCubit.get(context)
                                    .timings['Asr']
                                    .toString()),
                            const CustomDivider(),
                            TimeRow(
                                title: 'Maghreb',
                                time: TimingsCubit.get(context)
                                    .timings['Maghrib']
                                    .toString()),
                            const CustomDivider(),
                            TimeRow(
                                title: 'Esha',
                                time: TimingsCubit.get(context)
                                    .timings['Isha']
                                    .toString()),
                            const CustomDivider(),
                          ],
                        ),
                        builder: (context) => Column(
                          children: [
                            const Text(
                              "Location permission error!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "It seems you haven't granted location permission. Please grant the permission to access your location.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await Permission.location.isDenied) {
                                    // The user opted to never again see the permission request dialog for this
                                    // app. The only way to change the permission's status now is to let the
                                    // user manually enable it in the system settings.
                                    openAppSettings();
                                  } else if (await Permission
                                      .location.isGranted) {
                                    TimingsCubit.get(context).fetchTimings();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Make it rounded
                                  ),
                                  backgroundColor: AppColors
                                      .primaryColor, // Use the primary color
                                ),
                                child: const Text("Grant Permission"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
