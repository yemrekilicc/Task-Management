import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../model/Task_model.dart';

class taskRepository extends ChangeNotifier{
  final List<Task> allTasks=[
    Task("Flutter öğrenecek adam aranıyor", "2022-05-16", "10:00", "11:00", "öğren artık şunu", "ONGOING",Color(0xff625ecd)),
    Task("Flutter öğrenecek adam aranıyor", "2022-05-16", "10:00", "11:00", "öğren artık şunu", "URGENT",Color(0xfff26950)),
    Task("Flutter öğrenecek adam aranıyor", "2022-05-16", "10:00", "11:00", "öğren artık şunu", "RUNNING",Color(0xff2cc09c)),
    Task("Flutter öğrenecek adam aranıyor", "2022-05-16", "10:00", "11:00", "öğren artık şunu", "RUNNING",Color(0xff2cc09c)),
    Task("Flutter öğrenecek adam aranıyor", "2022-05-17", "10:00", "11:00", "öğren artık şunu", "RUNNING",Color(0xff2cc09c)),
    Task("Flutter öğrenecek adam aranıyor", "2022-05-15", "10:00", "11:00", "öğren artık şunu", "ONGOING",Color(0xff625ecd))
  ];
  List<Task> findTasks(int index){
    //var test2 =DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: index)));
    //var test= Jiffy(DateTime.now().subtract(Duration(days: index))).format('MMM d yyyy');
    return allTasks.where((element) => element.Date==DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: index)))).toList();
  }

}
final taskProvider =ChangeNotifierProvider((ref){
  return taskRepository();
});