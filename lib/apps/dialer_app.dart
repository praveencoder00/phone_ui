import 'package:flutter/material.dart';
import 'package:phone_ui/utils.dart';

class Dialer extends StatefulWidget {
  const Dialer({super.key});
  @override
  State<Dialer> createState() => _DialerState();
}

class _DialerState extends State<Dialer> {
  String n = '';
  static const keys = [
    ['1', ''],
    ['2', 'abc'],
    ['3', 'def'],
    ['4', 'ghi'],
    ['5', 'jkl'],
    ['6', 'mno'],
    ['7', 'pqrs'],
    ['8', 'tuv'],
    ['9', 'wxyz'],
    ['*', ''],
    ['0', '+'],
    ['#', ''],
  ];

  void add(String d) {
    if (n.length < 15) setState(() => n += d);
  }

  Widget _key(List<String> k) => SizedBox(
    width: 88,
    height: 46,
    child: Material(
      color: C.raised,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: C.line),
      ),
      child: InkWell(
        onTap: () => add(k[0]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              k[0],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
            if (k[1].isNotEmpty)
              Text(
                k[1],
                style: const TextStyle(fontSize: 9, color: C.muted, height: 1),
              ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final empty = n.isEmpty;
    return Material(
      color: C.bg,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Column(
          children: [
            SizedBox(
              height: 64,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      empty ? 'Enter a number' : n,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: empty ? 16 : 28,
                        fontWeight: FontWeight.w300,
                        letterSpacing: empty ? 0 : 1,
                        color: empty ? C.muted : C.text,
                      ),
                    ),
                  ),
                  if (!empty)
                    IconButton(
                      onPressed: () =>
                          setState(() => n = n.substring(0, n.length - 1)),
                      icon: const Icon(
                        Icons.backspace_outlined,
                        size: 20,
                        color: C.muted,
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            for (var r = 0; r < 4; r++)
              Padding(
                padding: EdgeInsets.only(bottom: r < 3 ? 8 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [for (var c = 0; c < 3; c++) _key(keys[r * 3 + c])],
                ),
              ),
            const SizedBox(height: 14),
            Material(
              color: C.mint,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {}, // TODO: send `n` to your GSM modem (e.g. ATD<n>;)
                child: const SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Icon(Icons.call_rounded, color: C.bg),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}