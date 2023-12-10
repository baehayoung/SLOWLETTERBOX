import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  int date;
  String title;

  Item({super.key, required this.date, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 0, 195, 255),
          ),
        ),
        width: double.infinity,
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
