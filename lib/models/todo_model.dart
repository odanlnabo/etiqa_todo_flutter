import 'package:etiqa_todo_flutter/models/do_model.dart';
import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  List<DoModel> doList = [];

  addDoList({title, startDate, endDate}) {
    int _id = doList.length + 1;

    DoModel doModel = DoModel(
      id: _id,
      title: title,
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
    );

    doList.add(doModel);

    notifyListeners();
  }

  updateDo({id, title, startDate, endDate}) {
    DoModel doModel = doList.where((doItem) => doItem.id == id).first;

    doModel.setTitle = title;
    doModel.setStartDate = DateTime.parse(startDate);
    doModel.setEndDate = DateTime.parse(endDate);

    notifyListeners();
  }

  completeDo({id}) {
    DoModel doModel = doList.where((doItem) => doItem.id == id).first;

    doModel.setCompleted = !doModel.getCompleted;

    notifyListeners();
  }
}
