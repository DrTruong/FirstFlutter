import 'package:flutter/material.dart';

class TitleProvider extends ChangeNotifier {
  TitleProvider({this.title = 'Test Demo'});

  String title;

  void changeTitle({required String newTitle}) {
    if (newTitle.trim().isNotEmpty) {
      title = newTitle;
    }
    notifyListeners();
  }
}
