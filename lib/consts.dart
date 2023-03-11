import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const white = Color(0xFFffffff);
const black = Color(0xFF1c1c27);
const grey = Color(0xFF373741);
const orange = Color(0xFFffb43a);
const transparent = Colors.transparent;

final font = GoogleFonts.roboto(letterSpacing: 1.5);
String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String digitHours = duration.inHours.remainder(60).toString();
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return "${digitHours}h ${twoDigitMinutes}m";
}
