import 'dart:ui';
import 'dart:convert';


class Task {
  Task({
    required this.catagory,
    required this.color,
    required this.date,
    required this.description,
    required this.endTime,
    required this.startTime,
    required this.taskName,
    required this.id,
  }){
    colorint=Color(int.parse(this.color));
  }

  late Color colorint;
  String catagory;
  String color;
  String date;
  String description;
  String endTime;
  String startTime;
  String taskName;
  int id;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    catagory: json["Catagory"],
    color: json["Color"],
    date: json["Date"],
    description: json["Description"],
    endTime: json["End_Time"],
    startTime: json["Start_time"],
    taskName: json["Task_name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "Catagory": catagory,
    "Color": color,
    "Date": date,
    "Description": description,
    "End_Time": endTime,
    "Start_time": startTime,
    "Task_name": taskName,
    "id": id,
  };
}