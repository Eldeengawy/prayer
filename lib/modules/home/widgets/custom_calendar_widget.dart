import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prayer/core/app_colors.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_cubit.dart';
import 'package:prayer/modules/home/cubits/timings_cubit/timings_state.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimingsCubit, TimingsState>(
      listener: (BuildContext context, TimingsState state) {},
      builder: (BuildContext context, TimingsState state) => TableCalendar(
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.now().weekday) {
              return const Center(
                child: Text(
                  'Today',
                  style: TextStyle(fontSize: 12.0),
                ),
              );
            } else {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 12.0),
                ),
              );
            }
          },
        ),
        headerStyle: const HeaderStyle(
          headerPadding: EdgeInsets.only(
              // left: 20.0,
              bottom: 10.0),
          // leftChevronVisible: false,
          titleCentered: false,
          formatButtonVisible: false,
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          // leftChevronIcon: Icon(Icons.arrow_back),
          rightChevronIcon:
              Icon(Icons.arrow_forward_ios_rounded), // Right arrow
          leftChevronIcon: Icon(Icons.arrow_back_ios_rounded), // Left arrow
        ),
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        startingDayOfWeek: StartingDayOfWeek.thursday,
        calendarFormat: CalendarFormat.week,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: TimingsCubit.get(context).selectedDay,
        selectedDayPredicate: (day) =>
            isSameDay(day, TimingsCubit.get(context).selectedDay),
        daysOfWeekHeight: 20,
        onDaySelected: (selectedDay, focusedDay) {
          TimingsCubit.get(context).changeSelectedDay(selectedDay);
        },
      ),
    );
  }
}
