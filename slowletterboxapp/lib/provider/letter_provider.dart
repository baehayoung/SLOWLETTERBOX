import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/letter.dart';

class LetterProvider with ChangeNotifier {
  final List<Letter> _letterList = List.empty(growable: true);

  List<Letter> getLetterList() {
    _fetchLetter();
    return _letterList;
  }

  void _fetchLetter() async {
    final response = await rootBundle.loadString('assets/data/letterList.json');
    final data = await json
        .decode(response)
        .map<Letter>((json) => Letter.fromJson(json))
        .toList();
    _letterList.clear();
    _letterList.addAll(data);
    notifyListeners();
  }
}
