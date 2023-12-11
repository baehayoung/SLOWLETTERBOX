import 'package:flutter/material.dart';
import 'package:slowletterboxapp/view/write_view.dart';
import 'package:slowletterboxapp/view/letter_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Container tabContainer(BuildContext context, String tabText) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(tabText),
      ));
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIdx = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {
          _selectedIdx = _tabController.index;
        }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SLOW LETTER BOX"),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  icon: Icon(_selectedIdx == 0
                      ? Icons.mail_rounded
                      : Icons.mail_outline),
                ),
                Tab(
                  icon: Icon(_selectedIdx == 1
                      ? Icons.edit_rounded
                      : Icons.edit_outlined),
                )
              ]),
        ),
        body: _selectedIdx == 0 ? LetterView() : WriteView());
  }
}
