import 'package:flutter/material.dart';
import 'package:phone_ui/apps/dialer_app.dart';
import 'package:phone_ui/apps/message_app.dart';
import 'package:phone_ui/apps/settings_app.dart';
import 'package:phone_ui/main.dart';
import 'package:phone_ui/pi_stats.dart';
import 'package:phone_ui/utils.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.open});
  final void Function(Widget) open;

  @override
  Widget build(BuildContext context) {
    Widget stub(String t, IconData i) => Stub(t, i);
    final grid = [
      AppDef(
        'Music',
        Icons.music_note_rounded,
        C.rose,
        () => stub('Music', Icons.music_note_rounded),
      ),
      AppDef(
        'Files',
        Icons.folder_rounded,
        C.amber,
        () => stub('Files', Icons.folder_rounded),
      ),
      AppDef(
        'Terminal',
        Icons.terminal_rounded,
        C.mint,
        () => stub('Terminal', Icons.terminal_rounded),
      ),
      AppDef(
        'Maps',
        Icons.map_rounded,
        C.sky,
        () => stub('Maps', Icons.map_rounded),
      ),
      AppDef(
        'Calc',
        Icons.calculate_rounded,
        C.orchid,
        () => stub('Calc', Icons.calculate_rounded),
      ),
      AppDef(
        'Clock',
        Icons.alarm_rounded,
        C.amber,
        () => stub('Clock', Icons.alarm_rounded),
      ),
      AppDef(
        'Notes',
        Icons.sticky_note_2_rounded,
        C.rose,
        () => stub('Notes', Icons.sticky_note_2_rounded),
      ),
      AppDef(
        'Gallery',
        Icons.photo_library_rounded,
        C.sky,
        () => stub('Gallery', Icons.photo_library_rounded),
      ),
    ];
    final dock = [
      AppDef('Phone', Icons.call_rounded, C.mint, () => const Dialer()),
      AppDef(
        'Messages',
        Icons.chat_bubble_rounded,
        C.orchid,
        () => const Messages(),
      ),
      AppDef(
        'Browser',
        Icons.language_rounded,
        C.sky,
        () => stub('Browser', Icons.language_rounded),
      ),
      AppDef(
        'Settings',
        Icons.settings_rounded,
        C.muted,
        () => const SettingsScreen(),
      ),
    ];

    Widget row(List<AppDef> l, {bool labels = true}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final a in l)
          AppIcon(a, labels: labels, onTap: () => open(a.page())),
      ],
    );

    return Material(
      color: C.bg,
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.9, -1.0),
            radius: 1.3,
            colors: [Color(0xFF241A4A), C.bg],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NowBuilder(
              builder: (t) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (r) => const LinearGradient(
                      colors: [C.orchid, C.rose],
                    ).createShader(r),
                    child: Text(
                      hm(t),
                      style: const TextStyle(
                        fontSize: 60,
                        height: 1.05,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    dateStr(t),
                    style: const TextStyle(fontSize: 14, color: C.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const PiStats(),
            const SizedBox(height: 14),
            row(grid.sublist(0, 4)),
            const SizedBox(height: 12),
            row(grid.sublist(4)),
            const Spacer(),
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: C.line),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final a in dock)
                    AppIcon(a, labels: false, onTap: () => open(a.page())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
