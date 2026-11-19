import 'dart:async';
import 'package:flutter/material.dart';

class C {
  C._();
  static const bg = Color(0xFF0E0C16);
  static const surface = Color(0xFF181523);
  static const raised = Color(0xFF221E31);
  static const line = Color(0xFF2E2942);
  static const text = Color(0xFFECE9F6);
  static const muted = Color(0xFF8C86A3);
  static const orchid = Color(0xFF9B7BFF);
  static const rose = Color(0xFFFF7BB0);
  static const mint = Color(0xFF5EEAC0);
  static const amber = Color(0xFFFFC27A);
  static const sky = Color(0xFF6FD3FF);
}


class NowBuilder extends StatefulWidget {
  const NowBuilder({super.key, required this.builder});

  final Widget Function(DateTime now) builder;

  @override
  State<NowBuilder> createState() => _NowBuilderState();
}

class _NowBuilderState extends State<NowBuilder> {
  DateTime now = DateTime.now();

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 10), (_) {
      setState(() => now = DateTime.now());
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(now);
}



class AppIcon extends StatelessWidget {
  const AppIcon(this.app, {super.key, required this.onTap, this.labels = true});
  final AppDef app;
  final VoidCallback onTap;
  final bool labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: C.raised,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: C.line),
            ),
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(app.icon, color: app.color, size: 24),
              ),
            ),
          ),
          if (labels) ...[
            const SizedBox(height: 4),
            Text(
              app.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: C.muted),
            ),
          ],
        ],
      ),
    );
  }
}




const tMuted = TextStyle(fontSize: 12, color: C.muted);
const tileDeco = BoxDecoration(
  color: C.surface,
  borderRadius: BorderRadius.all(Radius.circular(14)),
  border: Border.fromBorderSide(BorderSide(color: C.line)),
);

String hm(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

String dateStr(DateTime t) {
  const d = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const m = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${d[t.weekday - 1]}, ${t.day} ${m[t.month - 1]}';
}

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onBack, required this.onHome});
  final VoidCallback onBack, onHome;

  Widget _btn(IconData i, VoidCallback f, double size) => Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: f,
      child: Center(
        child: Icon(i, size: size, color: C.muted),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: const BoxDecoration(
        color: C.bg,
        border: Border(top: BorderSide(color: C.line)),
      ),
      child: Row(
        children: [
          _btn(Icons.arrow_back_ios_new_rounded, onBack, 15),
          _btn(Icons.circle_outlined, onHome, 18),
          _btn(Icons.crop_square_rounded, () {}, 17), // recents: not built yet
        ],
      ),
    );
  }
}



class AppDef {
  AppDef(this.label, this.icon, this.color, this.page);
  final String label;
  final IconData icon;
  final Color color;
  final Widget Function() page;
}



class Header extends StatelessWidget {
  const Header(this.title, {super.key, this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: -.3,
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

Widget chip(IconData i, Color c) => Container(
  width: 32,
  height: 32,
  decoration: BoxDecoration(
    color: c.withAlpha(36),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Icon(i, size: 18, color: c),
);

class Stub extends StatelessWidget {  
  const Stub(this.title, this.icon, {super.key});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: C.bg,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: C.muted),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text("This app isn't built yet.", style: tMuted),
          ],
        ),
      ),
    );
  }
}

