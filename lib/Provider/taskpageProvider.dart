import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Task_model.dart';

class taskpageviewmdodel extends ChangeNotifier{

  List<Task> selectedTasks = [];
  int selectedindex = 1;

  String getTasks(String date){
    String query="""query MyQuery {
    Tasks(where: {Date: {_eq: "$date"}}) {
    Catagory
    Color
    Date
    Description
    End_Time
    Start_time
    Task_name
    id
  }
}
      """;
    return query;
  }
  void changeselectedday(int index){
    selectedindex=index;
    notifyListeners();
  }
  int returnselectedday(){
    return selectedindex;
  }
  int returnselectedtasklen(){
    return selectedTasks.length;
  }

}

final taskpageProvider =ChangeNotifierProvider((ref){
  return taskpageviewmdodel();
});
