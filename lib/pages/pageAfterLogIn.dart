import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:todo/helpers/colorHelper.dart';
import 'package:todo/helpers/iconHelper.dart';
import 'package:todo/helpers/languages.dart';
import 'package:todo/helpers/preferencesHelper.dart';

class PageAfterLogIn extends StatefulWidget {
  const PageAfterLogIn({Key? key}) : super(key: key);

  @override
  State<PageAfterLogIn> createState() => _PageAfterLogInState();
}

class _PageAfterLogInState extends State<PageAfterLogIn> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  void _changePage(){
    Navigator.pushReplacementNamed(context, '/LogIn');
  }


  void _translate(String langCode,String langName){
    _localization.translate(langCode);
    PreferencesHelper.setLanguageCode(langCode);
    PreferencesHelper.setLanguage(langName);
    Navigator.pop(context);
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
          backgroundColor: ColorHelper.appBarPageAfterLogIn,
          bottom:TabBar(
            tabs:  <Widget>[
              Tab(
                icon: Icon(IconHelper.unFinishedTasks),
              ),
              Tab(
                icon: Icon(IconHelper.finished),
              ),
            ],
            indicatorColor: ColorHelper.appBarIndicatorLine,
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
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorHelper.header1,ColorHelper.header2],
                  ),
                ),
                child: Text(
                  'Todo Manager',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                              onPressed: () => _translate('en','English'),
                              child: const Text('English',
                                  style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () => _translate('ja','Japanese'),
                              child: const Text('Japanese',
                                  style: TextStyle(fontSize: 25)),
                            ),
                            TextButton(
                              onPressed: () => _translate('km','Chinese'),
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
              ListTile(
                leading: Icon(IconHelper.changeTheme),
                title: Text(AppLocale.changeTheme.getString(context),),
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
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
