import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phone_ui/display.dart';
import 'package:phone_ui/status_bar.dart';
import 'package:phone_ui/utils.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PhoneApp());
}

class PhoneApp extends StatelessWidget {
  const PhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        // Non-shader ripple: lighter on a Pi GPU than the default sparkle.
        splashFactory: InkRipple.splashFactory,
        colorScheme: const ColorScheme.dark(
          primary: C.orchid,
          onPrimary: Colors.white,
          secondary: C.rose,
          surface: C.surface,
          onSurface: C.text,
          outline: C.muted,
        ),
        sliderTheme: SliderThemeData(
          trackHeight: 4,
          overlayShape: SliderComponentShape.noOverlay,
          inactiveTrackColor: C.line,
        ),
      ),
      builder: (context, child) => ColoredBox(
        color: Colors.black,
        child: Center(
          child: FittedBox(
            child: SizedBox(width: 320, height: 480, child: child),
          ),
        ),
      ),
      home: const Shell(),
    );
  }
}


