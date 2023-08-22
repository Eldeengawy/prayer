import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/core/bloc_observer.dart';
import 'package:prayer/modules/home/cubits/location_cubit/location_cubit.dart';
import 'package:prayer/modules/home/cubits/location_cubit/location_state.dart';
import 'package:prayer/modules/home/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffdcf8f6),
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return BlocProvider(
      create: (context) => LocationCubit()..fetchUserLocation(),
      child: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Prayer',
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
