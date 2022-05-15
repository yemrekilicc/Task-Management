import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jiffy/jiffy.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State {
  final TaskNameController = TextEditingController();
  final DescriptionController = TextEditingController();
  bool ButtonPressedUrgent = true;
  bool ButtonPressedRunning = false;
  bool ButtonPressedOngoing = false;
  @override
  void dispose() {
    TaskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5a55ca),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          constraints: BoxConstraints(),
          iconSize: 40,
          padding: EdgeInsets.zero,
          icon: Icon(Icons.chevron_left, color: Color(0xfff0f4fd)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
                backgroundColor: Color(0xffffffff),
                backgroundImage: Image.asset('lib/image/man.png').image),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RichText(
                    text: TextSpan(
                        text: "Add Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfff0f4fd),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      TaskNameInput(myController: TaskNameController),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 26),
                        child: RichText(
                            text: TextSpan(
                                text: "RECENT MEET",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      Row(
                        children: [
                          Container(

                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: CircleAvatar(
                                backgroundColor: Color(0xffffffff),
                                backgroundImage:
                                    Image.asset('lib/image/man.png').image),
                          ),
                          CircleAvatar(
                              backgroundColor: Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                          CircleAvatar(
                              backgroundColor: Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                          CircleAvatar(
                              backgroundColor: Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 26),
                        child: RichText(
                            text: TextSpan(
                                text: "DATE",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      DatePicker(),
                      StartEndTime(),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 26),
                        child: RichText(
                            text: TextSpan(
                                text: "DESCRIPTION",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      DescritionTextField(
                          DescriptionController: DescriptionController),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 26),
                        child: RichText(
                            text: TextSpan(
                                text: "CATAGORY",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5,top: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!ButtonPressedRunning &
                                              !ButtonPressedOngoing) {
                                          } else {
                                            ButtonPressedUrgent =
                                                !ButtonPressedUrgent;
                                            if (ButtonPressedUrgent) {
                                              ButtonPressedRunning = false;
                                              ButtonPressedOngoing = false;
                                            }
                                          }
                                        });
                                      },
                                      child: Text(
                                        "URGENT",
                                        style: TextStyle(
                                          color: ButtonPressedUrgent
                                              ? Color(0xfff0e6ec)
                                              : Color(0xfff26950),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          elevation: 0,
                                          primary: ButtonPressedUrgent
                                              ? Color(0xfff26950)
                                              : Color(0xfff0e6ec)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: ButtonPressedUrgent,
                                    child: Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Color(0xfff0e6ec),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xfff0e6ec),
                                              width: 2
                                            ),
                                              shape: BoxShape.circle,
                                              color: Color(0xfff26950)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5,top: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!ButtonPressedUrgent &
                                              !ButtonPressedOngoing) {
                                          } else {
                                            ButtonPressedRunning =
                                                !ButtonPressedRunning;
                                            if (ButtonPressedRunning) {
                                              ButtonPressedUrgent = false;
                                              ButtonPressedOngoing = false;
                                            }
                                          }
                                        });
                                      },
                                      child: Text(
                                        "RUNNING",
                                        style: TextStyle(
                                          color: ButtonPressedRunning
                                              ? Color(0xffd1ebe5)
                                              : Color(0xff2cc09c),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          elevation: 0,
                                          primary: ButtonPressedRunning
                                              ? Color(0xff2cc09c)
                                              : Color(0xffd1ebe5)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: ButtonPressedRunning,
                                    child: Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Color(0xffd1ebe5),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffd1ebe5),
                                                  width: 2
                                              ),
                                              shape: BoxShape.circle,
                                              color: Color(0xff2cc09c)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5,top: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (!ButtonPressedUrgent &
                                              !ButtonPressedRunning) {
                                          } else {
                                            ButtonPressedOngoing =
                                                !ButtonPressedOngoing;
                                            if (ButtonPressedOngoing) {
                                              ButtonPressedUrgent = false;
                                              ButtonPressedRunning = false;
                                            }
                                          }
                                        });
                                      },
                                      child: Text(
                                        "ONGOING",
                                        style: TextStyle(
                                          color: ButtonPressedOngoing
                                              ? Color(0xffe1e4f8)
                                              : Color(0xff625ecd),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          elevation: 0,
                                          primary: ButtonPressedOngoing
                                              ? Color(0xff625ecd)
                                              : Color(0xffe1e4f8)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: ButtonPressedOngoing,
                                    child: Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Color(0xffe1e4f8),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffe1e4f8),
                                                  width: 2
                                              ),
                                              shape: BoxShape.circle,
                                              color: Color(0xff625ecd)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 32),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Create New Task",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 0,
                                    primary: Color(0xff625ecd)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DescritionTextField extends StatelessWidget {
  const DescritionTextField({
    Key? key,
    required this.DescriptionController,
  }) : super(key: key);

  final TextEditingController DescriptionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color(0xffabb4c9),
      ))),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(horizontal: 8),
          //isDense: true,
          border: InputBorder.none,
          //labelText: 'Task Name',
        ),
        controller: DescriptionController,
      ),
    );
  }
}

class StartEndTime extends StatelessWidget {
  const StartEndTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 26),
                child: RichText(
                    text: TextSpan(
                        text: "START TIME",
                        style: TextStyle(color: Color(0xff898aac)))),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Color(0xffabb4c9),
                ))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          initialValue: '10:00',
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style:
                              TextStyle(color: Color(0xff0b204c), fontSize: 20),
                          //dateLabelText: 'Date',

                          onChanged: (val) => print(val),
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                        child:
                            Icon(Icons.expand_more, color: Color(0xff000000)))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 26),
                child: RichText(
                    text: TextSpan(
                        text: "END TIME",
                        style: TextStyle(color: Color(0xff898aac)))),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Color(0xffabb4c9),
                ))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          initialValue: '11:00',
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration.collapsed(hintText: ''),
                          style:
                              TextStyle(color: Color(0xff0b204c), fontSize: 20),
                          onChanged: (val) => print(val),
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                        child:
                            Icon(Icons.expand_more, color: Color(0xff000000)))
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color(0xffabb4c9),
      ))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DateTimePicker(
                initialValue: "${Jiffy(DateTime.now()).format('MMM d yyyy')}",
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                decoration: InputDecoration.collapsed(hintText: ''),
                style: TextStyle(color: Color(0xff0b204c), fontSize: 20),
                //dateLabelText: 'Date',
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
          ),
          IntrinsicWidth(
              child:
                  Icon(Icons.calendar_today_outlined, color: Color(0xff000000)))
        ],
      ),
    );
  }
}

class TaskNameInput extends StatelessWidget {
  const TaskNameInput({
    Key? key,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
          color: Color(0xff5a55ca),
          width: 2,
        ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration.collapsed(
              hintText: 'Task Name',
              //contentPadding: EdgeInsets.symmetric(horizontal: 8),
              //isDense: true,
              border: InputBorder.none,
              //labelText: 'Task Name',
            ),
            controller: myController,
          ),
        ),
      ),
    );
  }
}
