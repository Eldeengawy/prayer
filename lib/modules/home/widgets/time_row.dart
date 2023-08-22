import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:prayer/core/app_colors.dart';

class TimeRow extends StatelessWidget {
  final String title;
  final String time;

  const TimeRow({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    // Parse the time string into a DateTime object
    final timeDate = DateFormat('HH:mm').parse(time);

    // Format the timeDate to 12-hour format with AM/PM indicator
    final formattedTime = DateFormat('h:mm a').format(timeDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          Text(
            formattedTime, // Use the formatted time
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.timeColor,
            ),
          ),
        ],
      ),
    );
  }
}
