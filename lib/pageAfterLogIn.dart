import 'package:flutter/material.dart';

class PageAfterLogIn extends StatefulWidget {
  const PageAfterLogIn({Key? key}) : super(key: key);

  @override
  State<PageAfterLogIn> createState() => _PageAfterLogInState();
}

class _PageAfterLogInState extends State<PageAfterLogIn> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TODO',
          ),
          backgroundColor: Colors.deepOrangeAccent,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.work),
              ),
              Tab(
                icon: Icon(Icons.done),
              ),
            ],
            indicatorColor: Colors.white,

          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text('Things todo!'),
            ),
            Center(
              child: Text('Things that are done!'),
            ),
          ],
        ),
      ),
    );
  }
}
