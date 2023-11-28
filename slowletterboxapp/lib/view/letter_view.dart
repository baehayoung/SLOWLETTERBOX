import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Slow Letter Box'),
        ),
        body: Consumer<LetterProvider>(builder: (context, provider, child) {
          letterList = provider.getLetterList();
          return ListView.builder(
              itemCount: letterList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                      "title: ${letterList[index].title}, contents: ${letterList[index].contents}"),
                );
              });
        }));
  }
}
