import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slowletterboxapp/provider/letter_provider.dart';
import 'package:slowletterboxapp/service/database.dart';

import '../models/letter.dart';

class WriteView extends StatefulWidget {
  const WriteView({super.key});

  @override
  State<WriteView> createState() => _WriteState();
}

class _WriteState extends State<WriteView> {
  String _title = "";
  String _contents = "";
  TabProvider? _tabProvider;
  final DBHelper _dbHelper = DBHelper();
  final titleController = TextEditingController();
  final contentsController = TextEditingController();

  Future _insertLetter(title, contents) async {
    int letterDate =
        DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch;
    await _dbHelper
        .insertDB(Letter(date: letterDate, title: title, contents: contents));
  }

  void _sendHandelr() {
    if (_title.replaceAll(RegExp('\\s'), "").isNotEmpty ||
        _contents.replaceAll(RegExp('\\s'), "").isNotEmpty) {
      _insertLetter(_title, _contents);
      _tabProvider?.setTabIdx(0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('제목과 내용을 채워주세요'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  void _setText() {
    setState(() {
      _title = titleController.text;
      _contents = contentsController.text;
    });
  }

  @override
  void initState() {
    super.initState();

    titleController.addListener(_setText);
    contentsController.addListener(_setText);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(builder: (context, provider, child) {
      _tabProvider = Provider.of<TabProvider>(context);

      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            children: [
              TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '제목을 입력하세요',
                  ),
                  controller: titleController),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextField(
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: '이곳에 편지를 작성하세요',
                  ),
                  controller: contentsController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _sendHandelr();
                  },
                  child: const Text("전송"))
            ],
          ));
    });
  }
}
