
import 'package:flutter/material.dart';
import 'package:phone_ui/main.dart';
import 'package:phone_ui/main_page.dart';
import 'package:phone_ui/status_bar.dart';
import 'package:phone_ui/utils.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  final nav = GlobalKey<NavigatorState>();

  Route<void> _route(Widget w) => PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (_, __, ___) => w,
    transitionsBuilder: (_, a, __, child) => FadeTransition(
      opacity: a,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: .96,
          end: 1,
        ).animate(CurvedAnimation(parent: a, curve: Curves.easeOut)),
        child: child,
      ),
    ),
  );

  void open(Widget w) => nav.currentState?.push(_route(w));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StatusBar(),
          Expanded(
            child: Navigator(
              key: nav,
              onGenerateRoute: (_) => _route(Home(open: open)),
            ),
          ),
          NavBar(
            onBack: () {
              if (nav.currentState?.canPop() ?? false) nav.currentState!.pop();
            },
            onHome: () => nav.currentState?.popUntil((r) => r.isFirst),
          ),
        ],
      ),
    );
  }
}
