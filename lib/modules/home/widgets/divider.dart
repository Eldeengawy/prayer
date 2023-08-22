import 'package:flutter/material.dart';
import 'package:prayer/core/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.primaryColor,
      thickness: 1,
    );
  }
}
