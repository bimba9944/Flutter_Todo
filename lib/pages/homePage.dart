import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'dart:convert';

import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';
import 'package:todo/helpers/taskHelper.dart';
import 'package:todo/helpers/taskService.dart';
import 'package:todo/widgets/dialogWidget.dart';
import 'package:todo/widgets/drawerWidget.dart';
import 'package:todo/widgets/taskTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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


  Future<void> getTasks() async {
    TaskService service = TaskService.create();
    final response = await service.getTasks();
    final parsed = jsonDecode(response.bodyString);
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

  PreferredSizeWidget _buildAppbar(){
    return AppBar(
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
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: _buildAppbar(),
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
        endDrawer: DrawerWidget(),
      ),
    );
  }
}
