

import 'package:flutter/material.dart';
import 'package:phone_ui/utils.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});
  static const _colors = [C.orchid, C.rose, C.sky, C.amber, C.mint];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: C.bg,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Header(
              'Messages',
              trailing: chip(Icons.edit_rounded, C.orchid),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _convos.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 52, color: C.line),
              itemBuilder: (_, i) {
                final c = _convos[i];
                final col = _colors[i % _colors.length];
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: col.withAlpha(40),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            c.name[0],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: col,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                c.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: tMuted,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              c.time,
                              style: const TextStyle(
                                fontSize: 10,
                                color: C.muted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (c.unread > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: C.orchid,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${c.unread}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: C.bg,
                                  ),
                                ),
                              )
                            else
                              const SizedBox(height: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class Convo {
  const Convo(this.name, this.text, this.time, {this.unread = 0});
  final String name, text, time;
  final int unread;
}

const _convos = [
  Convo('Mom', 'Did you eat? Call me when you are free', '18:02', unread: 2),
  Convo('Alex', 'Pi case is printed, picking it up tomorrow', '17:40'),
  Convo(
    'Maker Group',
    'Sam: soldering night moved to Friday',
    '16:15',
    unread: 5,
  ),
  Convo('Sam', 'Can you send the GPIO pinout?', 'Yesterday'),
  Convo('Dev', 'The touchscreen driver finally works', 'Mon'),
  Convo('Parcel', 'Your order was delivered', 'Sun'),
];
