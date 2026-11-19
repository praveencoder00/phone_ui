import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phone_ui/main.dart';
import 'package:phone_ui/utils.dart';

class PiStats extends StatefulWidget {
  const PiStats({super.key});
  @override
  State<PiStats> createState() => _PiStatsState();
}

class _PiStatsState extends State<PiStats> {
  double temp = 47, ram = .38;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _read();
    timer = Timer.periodic(const Duration(seconds: 3), (_) => _read());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _read() async {
    try {
      final t =
          double.parse(
            (await File(
              '/sys/class/thermal/thermal_zone0/temp',
            ).readAsString()).trim(),
          ) /
          1000;
      final lines = await File('/proc/meminfo').readAsLines();
      int kb(String k) => int.parse(
        RegExp(
          r'\d+',
        ).firstMatch(lines.firstWhere((l) => l.startsWith(k)))!.group(0)!,
      );
      final r = 1 - kb('MemAvailable') / kb('MemTotal');
      if (mounted) {
        setState(() {
          temp = t;
          ram = r;
        });
      }
    } catch (_) {}
  }

  Widget _cell(String label, String value, double p, Color c) => Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(label, style: tMuted),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: p.clamp(0.0, 1.0).toDouble(),
            minHeight: 3,
            backgroundColor: C.line,
            color: c,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: tileDeco.copyWith(borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          _cell(
            'CPU',
            '${temp.round()}°C',
            temp / 85,
            temp > 70 ? C.rose : C.mint,
          ),
          const SizedBox(width: 18),
          _cell('RAM', '${(ram * 100).round()}%', ram, C.orchid),
        ],
      ),
    );
  }
}