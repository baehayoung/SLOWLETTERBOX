import 'package:flutter/material.dart';

class WriteView extends StatefulWidget {
  @override
  State<WriteView> createState() => _WriteState();
}

class _WriteState extends State<WriteView> {
  String _title = "";
  String _contents = "";
  final titleController = TextEditingController();
  final contentsController = TextEditingController();

  void _sendHandelr() {
    setState(() {
      _title = titleController.text;
      _contents = contentsController.text;
    });
    print("_title: ${_title}, content: ${_contents}");
  }

  @override
  void initState() {
    super.initState();

    titleController.addListener(_sendHandelr);
    contentsController.addListener(_sendHandelr);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                // onChanged: (text) {
                //   print("contents is ${text}");
                // },
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
  }
}
