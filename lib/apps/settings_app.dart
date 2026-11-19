
import 'package:flutter/material.dart';
import 'package:phone_ui/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool wifi = true, bt = false, air = false;
  double bright = .7;

  Widget _toggle(IconData i, String t, Color c, bool v, ValueChanged<bool> f) =>
      Container(
        height: 52,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: tileDeco,
        child: Row(
          children: [
            chip(i, c),
            const SizedBox(width: 12),
            Expanded(child: Text(t, style: const TextStyle(fontSize: 15))),
            Transform.scale(
              scale: .8,
              child: Switch(value: v, onChanged: f),
            ),
          ],
        ),
      );

  Widget _info(String k, String v) => Container(
    height: 44,
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: tileDeco,
    child: Row(
      children: [
        Text(k, style: const TextStyle(fontSize: 14)),
        const Spacer(),
        Text(v, style: tMuted),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: C.bg,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Header('Settings'),
          _toggle(
            Icons.wifi_rounded,
            'Wi-Fi',
            C.sky,
            wifi,
            (v) => setState(() => wifi = v),
          ),
          _toggle(
            Icons.bluetooth_rounded,
            'Bluetooth',
            C.orchid,
            bt,
            (v) => setState(() => bt = v),
          ),
          _toggle(
            Icons.flight_rounded,
            'Airplane mode',
            C.rose,
            air,
            (v) => setState(() => air = v),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.only(left: 12, right: 8),
            decoration: tileDeco,
            child: Row(
              children: [
                chip(Icons.brightness_6_rounded, C.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: bright,
                    onChanged: (v) => setState(() => bright = v),
                  ),
                ),
              ],
            ),
          ),
          _info('Display', '320 × 480'),
          _info('Device', 'Raspberry Pi'),
        ],
      ),
    );
  }
}
