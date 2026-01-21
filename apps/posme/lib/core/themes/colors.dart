import 'package:flutter/material.dart';
import 'package:orkitt/orkitt.dart';

/// ==============================
/// ☀️ Orkitt Light Theme
/// ==============================
class AppLightColors extends BrandKolors {
  const AppLightColors();

  @override
  Brightness get brightness => Brightness.light;

  // Vibrant Lime Green from the logo center
  @override
  Color get primary => const Color(0xFF7AC943); 
  
  // Deep Forest Green from the "Seed" text
  @override
  Color get secondary => const Color(0xFF136B38); 
  
  // The Logo Blue as the accent/action color
  @override
  Color get accent => const Color(0xFF1B75BC);

  // Retro Greenish-White (Warm Mint)
  @override
  Color get background => const Color(0xFFEDF1F9); 
  @override
  Color get surface => const Color(0xFFF9FBF9);
  @override
  Color get surfaceVariant => const Color(0xFFE8EDE7);

  @override
  Color get textPrimary => const Color(0xFF0D1F0D); // Dark green-tinted black
  @override
  Color get textSecondary => const Color(0xFF4A554A);
  @override
  Color get textTertiary => const Color(0xFF8B968B);
}

/// ==============================
/// 🌙 Orkitt Dark Theme
/// ==============================
class AppDarkColors extends BrandKolors {
  const AppDarkColors();

  @override
  Brightness get brightness => Brightness.dark;

  // Keeping the lime green vibrant for dark mode
  @override
  Color get primary => const Color(0xFF8DE052); 
  
  // Lighter forest green for readability
  @override
  Color get secondary => const Color(0xFF45B06F); 
  
  @override
  Color get accent => const Color(0xFF4FA9E5);

  // Deep Forest Night (Very dark greenish-black)
  @override
  Color get background => const Color(0xFF0B120B);
  @override
  Color get surface => const Color(0xFF161F16);
  @override
  Color get surfaceVariant => const Color(0xFF243024);

  @override
  Color get textPrimary => const Color(0xFFECF2EC);
  @override
  Color get textSecondary => const Color(0xFFAAB3AA);
  @override
  Color get textTertiary => const Color(0xFF6E786E);
}