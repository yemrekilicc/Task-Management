import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class addtaskpage extends ChangeNotifier{

  final String taskMutation="""mutation MyMutation(\$Color: String!, \$Catagory: String!, \$Date: String!, \$Description: String!, \$End_Time: String!, \$Start_time: String!, \$Task_name: String!) {
  insert_Tasks(objects: {Catagory: \$Catagory, Color: \$Color, Date: \$Date, Description: \$Description, End_Time: \$End_Time, Start_time: \$Start_time, Task_name: \$Task_name})
{
affected_rows}
}
  """;
   bool ButtonPressedUrgent= true;
   bool ButtonPressedRunning= false;
   bool ButtonPressedOngoing= false;
   String color="";
   String catagoryString ="";
  void catagorybuttonclick(String pressed){
    if(pressed=="URGENT"){
      ButtonPressedUrgent=true;
      ButtonPressedRunning = false;
      ButtonPressedOngoing = false;
    }
    if(pressed=="RUNNING"){
      ButtonPressedRunning=true;
      ButtonPressedUrgent = false;
      ButtonPressedOngoing = false;
    }
    if(pressed=="ONGOING"){
      ButtonPressedOngoing=true;
      ButtonPressedUrgent = false;
      ButtonPressedRunning = false;
    }
    notifyListeners();
  }
}
final addtaskpageProvider =ChangeNotifierProvider((ref){
  return addtaskpage();
});