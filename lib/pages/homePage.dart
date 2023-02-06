import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/helpers/taskHelper.dart';
import 'package:todo/widgets/dialogWidget.dart';
import 'package:todo/widgets/taskTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final FlutterLocalization _localization = FlutterLocalization.instance;
  String? username = PreferencesHelper.getUsername();
  late Color color1;
  late Color color2;
  List<Task> tasks = [];
  List<Task> finishedTasks = [];

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  void _changePage() {
    PreferencesHelper.removeTokenAndUsername();
    Navigator.pushReplacementNamed(context, '/LogIn');
  }

  Future<void> getTasks() async {
    String? token = PreferencesHelper.getAccessToken();
    final response = await http.get(
      Uri.parse("https://jumborama-tasks.herokuapp.com/tasks"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    final parsed = jsonDecode(response.body);

    tasks = [];
    finishedTasks = [];
    Task task;
    for (var singleTask in parsed) {
      task = Task(
        id: singleTask['id'],
        title: singleTask['title'],
        description: singleTask['description'],
        status: singleTask['status'],
      );

      if (task.status == 'OPEN') {
        color1 = Colors.green;
        tasks.add(task);
      } else {
        color2 = Colors.red;
        finishedTasks.add(task);
      }
    }

    setState(() {});
  }

  void _translate(String langCode, String langName) {
    _localization.translate(langCode);
    PreferencesHelper.setLanguageCode(langCode);
    PreferencesHelper.setLanguage(langName);
    Navigator.pop(context);
  }

  Widget _buildSingleListTile(Task task) {
    return TaskTile(
      title: task.title,
      subtitle: task.description,
      status: task.status,
      colorOfText: task.status == 'OPEN' ? color1 : color2,
      colorOfBorder: task.status == 'OPEN' ? color1 : color2,
      id: task.id,
    );
  }

  Widget _buildTasks(List<Task> taskList) {
    Widget result;
    if (taskList.isNotEmpty) {
      result = ListView.builder(
          itemCount: taskList.length, itemBuilder: (ctx, index) => _buildSingleListTile(taskList[index]));
    } else {
      result = const Center(child: CircularProgressIndicator());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocale.title.getString(context),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
              ),
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: AppLocale.tabBarOpen.getString(context),
              ),
              Tab(text: AppLocale.tabBarDone.getString(context)),
            ],
            indicatorColor: ColorHelper.appBarIndicatorLine,
          ),
        ),
        body: TabBarView(
          children: [
            _buildTasks(tasks),
            _buildTasks(finishedTasks),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              showDialog<String>(context: context, builder: (BuildContext context) => DialogWidget(getTasks)),
          backgroundColor: Colors.deepOrangeAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorHelper.header1, ColorHelper.header2],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Todo Manager',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      'Username: $username',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(IconHelper.changeLanguage),
                title: Text(AppLocale.changeLanguage.getString(context)),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: size.height * 0.4,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () => _translate('en', 'English'),
                              child: const Text('English', style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () => _translate('ja', 'Japanese'),
                              child: const Text('Japanese', style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () => _translate('km', 'Chinese'),
                              child: const Text('Chinese', style: TextStyle(fontSize: 25)),
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
              ListTile(
                leading: Icon(IconHelper.changeTheme),
                title: Text(
                  AppLocale.changeTheme.getString(context),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(IconHelper.logOut),
                onTap: _changePage,
                title: Text(AppLocale.logOut.getString(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
