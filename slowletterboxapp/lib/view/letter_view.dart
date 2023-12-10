import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LetterProvider>(builder: (context, provider, child) {
      letterList = provider.getLetterList();

      return ListView.builder(
          itemCount: letterList.length,
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(15),
                child: Item(
                  date: letterList[index].date,
                  title: letterList[index].title,
                  contents: letterList[index].contents,
                ));
          });
    });
  }
}
