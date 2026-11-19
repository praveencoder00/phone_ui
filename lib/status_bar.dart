import 'package:flutter/material.dart';
import 'package:phone_ui/main.dart';
import 'package:phone_ui/utils.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            NowBuilder(
              builder: (t) => Text(hm(t),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: C.text),
            const SizedBox(width: 6),
            const Icon(Icons.wifi_rounded, size: 14, color: C.text),
            const SizedBox(width: 6),
            const Icon(Icons.battery_full_rounded, size: 15, color: C.mint),
            const SizedBox(width: 2),
            const Text('87%', style: TextStyle(fontSize: 11, color: C.muted)),
          ],
        ),
      ),
    );
  }
}