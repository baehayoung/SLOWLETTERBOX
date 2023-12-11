import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:slowletterboxapp/components/item.dart';
import 'package:slowletterboxapp/provider/letter_provider.dart';

import '../models/letter.dart';

class LetterView extends StatefulWidget {
  const LetterView({super.key});

  @override
  State<LetterView> createState() => _LetterViewState();
}

class _LetterViewState extends State<LetterView> {
  late List<Letter> letterList;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<LetterProvider>(builder: (context, provider, child) {
      letterList = provider.getLetterList();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now());
                  if (selectedDate != null) {
                    setState(() {
                      startDate = selectedDate;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 59, 59, 59),
                  padding: const EdgeInsets.all(15),
                ),
                child: Text(DateFormat('yyyy-MM-dd').format(startDate)),
              ),
              const Text("~"),
              TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now());
                    if (selectedDate != null) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 59, 59, 59),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Text(DateFormat('yyyy-MM-dd').format(endDate))),
              IconButton(
                onPressed: () => {print("clcik")},
                icon: const Icon(Icons.search),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: letterList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(15),
                        child: Item(
                          date: letterList[index].date,
                          title: letterList[index].title,
                          contents: letterList[index].contents,
                        ));
                  }))
        ],
      );
    });
  }
}
