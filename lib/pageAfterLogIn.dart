import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/languages.dart';

class PageAfterLogIn extends StatefulWidget {
  const PageAfterLogIn({Key? key}) : super(key: key);

  @override
  State<PageAfterLogIn> createState() => _PageAfterLogInState();
}

class _PageAfterLogInState extends State<PageAfterLogIn> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocale.title.getString(context),
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
          children: [
            Center(
              child: Text(
                AppLocale.text.getString(context),
              ),
            ),
            Center(
              child: Text('Things that are done!'),
            ),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
                  ),
                ),
                child: Text(
                  'Todo Manager',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Change Language'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                _localization.translate('en');
                                Navigator.pop(context);
                              },
                              child: const Text('English',
                                  style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () {
                                _localization.translate('ja');
                                Navigator.pop(context);
                              },
                              child: const Text('Japanese',
                                  style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () {
                                _localization.translate('km');
                                Navigator.pop(context);
                              },
                              child: const Text('Chinese',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(
                thickness: 1,
              ),
              const ListTile(
                leading: Icon(Icons.brush),
                title: Text('Change Theme'),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.pushNamed(context, '/LogIn');
                },
                title: Text('Logout'),
              ),
            ],
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
