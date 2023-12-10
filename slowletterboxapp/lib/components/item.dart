import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  int date;
  String title;
  String contents;

  Item(
      {super.key,
      required this.date,
      required this.title,
      required this.contents});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: true, // 바깥 영역 터치
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Text(contents),
                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('확인'))
                    ]);
              });
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 59, 59, 59),
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: const BorderSide(
              width: 2.0, color: Color.fromARGB(255, 6, 121, 214)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(DateFormat('yyyy-MM-dd hh:mm')
                .format(DateTime.fromMillisecondsSinceEpoch(date * 1000)))
          ],
        ));
  }
}
