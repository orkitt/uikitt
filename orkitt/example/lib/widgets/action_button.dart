import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orkitt/orkitt.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60.w,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: context.surfaceElevated,
          ),
          child: Icon(icon, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
