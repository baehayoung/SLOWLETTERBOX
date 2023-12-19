import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:slowletterboxapp/components/item.dart';
import 'package:slowletterboxapp/service/database.dart';
import 'package:slowletterboxapp/provider/letter_provider.dart';

import '../models/letter.dart';

class LetterView extends StatefulWidget {
  const LetterView({super.key});

  @override
  State<LetterView> createState() => _LetterViewState();
}

class _LetterViewState extends State<LetterView> {
  final DBHelper _dbHelper = DBHelper();

  List<Letter> letterList = [];
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  Future _getLetter() async {
    List<Letter> _letters = await _dbHelper.getDB(
        startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);
    setState(() {
      letterList = _letters;
    });
    // await _dbHelper.executeSQL();
  }

  void _deleteLetter(id) async {
    await _dbHelper.deleteDB(id);
    List<Letter> _letters = await _dbHelper.getDB(
        startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);
    setState(() {
      letterList = _letters;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLetter();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(builder: (context, provider, child) {
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
                onPressed: () => {_getLetter()},
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
                          id: letterList[index].id,
                          date: letterList[index].date,
                          title: letterList[index].title,
                          contents: letterList[index].contents,
                          deleteFunc: () =>
                              {_deleteLetter(letterList[index].id)},
                        ));
                  }))
        ],
      );
    });
  }
}
