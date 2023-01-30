import 'package:flutter/material.dart';

class IconHelper{
  static _Container container = _Container();
  static _Input input = _Input();
  static _Dropdown dropdown = _Dropdown();
  static _TabBar tabBar = _TabBar();
  static _Drawer drawer = _Drawer();
}

class _Container{
  IconData signUpContainerIcon = Icons.ac_unit;
  IconData logInContainerIcon = Icons.ac_unit;
}

class _Input{
  IconData inputIconEmail = Icons.mail;
  IconData inputIconPassword = Icons.key;
  IconData inputIconUser = Icons.perm_identity;
}

class _Dropdown{
  IconData dropdownIcon = Icons.language;
}

class _TabBar{
  IconData unFinishedTasks = Icons.work;
  IconData finished = Icons.done;
}

class _Drawer{
  IconData changeLanguage = Icons.language;
  IconData changeTheme = Icons.brush;
  IconData logOut = Icons.logout;
}