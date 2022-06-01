// ignore_for_file: non_constant_identifier_names

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../Provider/addtaskpageProvider.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends ConsumerState {
  final DateController = TextEditingController();
  final StartimeController = TextEditingController();
  final EndtimeController = TextEditingController();
  final TaskNameController = TextEditingController();
  final DescriptionController = TextEditingController();
  @override
  void dispose() {
    TaskNameController.dispose();
    DateController.dispose();
    StartimeController.dispose();
    EndtimeController.dispose();
    DescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    DateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    StartimeController.text = "10:00";
    EndtimeController.text = "11:00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addtaskpro = ref.watch(addtaskpageProvider);
    return Scaffold(
      backgroundColor: const Color(0xff5a55ca),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          constraints: const BoxConstraints(),
          iconSize: 40,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.chevron_left, color: Color(0xfff0f4fd)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
                backgroundColor: const Color(0xffffffff),
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
                    text: const TextSpan(
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
                decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.only(top: 26),
                        child: RichText(
                            text: const TextSpan(
                                text: "RECENT MEET",
                                style: TextStyle(
                                    color: Color(0xff898aac)))),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: CircleAvatar(
                                backgroundColor: const Color(0xffffffff),
                                backgroundImage:
                                    Image.asset('lib/image/man.png').image),
                          ),
                          CircleAvatar(
                              backgroundColor: const Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                          CircleAvatar(
                              backgroundColor: const Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                          CircleAvatar(
                              backgroundColor: const Color(0xffffffff),
                              backgroundImage:
                                  Image.asset('lib/image/man.png').image),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 26),
                        child: RichText(
                            text: const TextSpan(
                                text: "DATE",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      DatePicker(DateController),
                      StartEndTime(StartimeController, EndtimeController),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 26),
                        child: RichText(
                            text: const TextSpan(
                                text: "DESCRIPTION",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      DescritionTextField(
                          DescriptionController: DescriptionController),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 26),
                        child: RichText(
                            text: const TextSpan(
                                text: "CATEGORY",
                                style: TextStyle(color: Color(0xff898aac)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CatagoryButton(
                                  "URGENT",
                                  const Color(0xfff26950),
                                  const Color(0xfff0e6ec),
                                  addtaskpro.ButtonPressedUrgent),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CatagoryButton(
                                  "RUNNING",
                                  const Color(0xff2cc09c),
                                  const Color(0xffd1ebe5),
                                  addtaskpro.ButtonPressedRunning),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CatagoryButton(
                                  "ONGOING",
                                  const Color(0xff625ecd),
                                  const Color(0xffe1e4f8),
                                  addtaskpro.ButtonPressedOngoing),
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
                              child: Mutation(
                                  options: MutationOptions(
                                    document: gql(addtaskpro.taskMutation),
                                  ),
                                  builder: (
                                    RunMutation runMutation,
                                    QueryResult? result,
                                  ) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (addtaskpro.ButtonPressedUrgent) {
                                          addtaskpro.catagoryString = "URGENT";
                                          addtaskpro.color = "0xfff26950";
                                        }
                                        if (addtaskpro.ButtonPressedRunning) {
                                          addtaskpro.catagoryString = "RUNNING";
                                          addtaskpro.color = "0xff2cc09c";
                                        }
                                        if (addtaskpro.ButtonPressedOngoing) {
                                          addtaskpro.catagoryString = "ONGOING";
                                          addtaskpro.color = "0xff625ecd";
                                        }
                                        runMutation(
                                          {
                                            "Color": addtaskpro.color,
                                            "Catagory":
                                                addtaskpro.catagoryString,
                                            "Date": DateController.text,
                                            "Description":
                                                DescriptionController.text,
                                            "End_Time": EndtimeController.text,
                                            "Start_time":
                                                StartimeController.text,
                                            "Task_name": TaskNameController.text
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "Create New Task",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          elevation: 0,
                                          primary: const Color(0xff625ecd)),
                                    );
                                  }),
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

class CatagoryButton extends ConsumerWidget {
  final String catagory;
  final Color Enabled;
  final Color Disabled;
  final bool pressed;
  const CatagoryButton(this.catagory, this.Enabled, this.Disabled, this.pressed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addtaskpro = ref.watch(addtaskpageProvider);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5, top: 5),
          child: ElevatedButton(
            onPressed: () {
              addtaskpro.catagorybuttonclick(catagory);
            },
            child: Text(
              catagory,
              style: TextStyle(
                color: pressed ? Disabled : Enabled,
              ),
            ),
            style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                primary: pressed ? Enabled : Disabled),
          ),
        ),
        Visibility(
          visible: pressed,
          child: Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: Disabled,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Disabled, width: 2),
                    shape: BoxShape.circle,
                    color: Enabled),
              ),
            ),
          ),
        )
      ],
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
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color(0xffabb4c9),
      ))),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        controller: DescriptionController,
      ),
    );
  }
}

class StartEndTime extends StatelessWidget {
  final TextEditingController startimeController;
  final TextEditingController endtimeController;
  const StartEndTime(
    this.startimeController,
    this.endtimeController, {
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
                padding: const EdgeInsets.only(top: 26),
                child: RichText(
                    text: const TextSpan(
                        text: "START TIME",
                        style: TextStyle(color: Color(0xff898aac)))),
              ),
              Container(
                decoration: const BoxDecoration(
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
                          controller: startimeController,
                          type: DateTimePickerType.time,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          style: const TextStyle(
                              color: Color(0xff0b204c), fontSize: 20),
                        ),
                      ),
                    ),
                    const IntrinsicWidth(
                        child: Icon(Icons.expand_more,
                            color: Color(0xff000000)))
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 26),
                child: RichText(
                    text: const TextSpan(
                        text: "END TIME",
                        style: TextStyle(color: Color(0xff898aac)))),
              ),
              Container(
                decoration: const BoxDecoration(
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
                          controller: endtimeController,
                          type: DateTimePickerType.time,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
                          style: const TextStyle(
                              color: Color(0xff0b204c), fontSize: 20),
                        ),
                      ),
                    ),
                    const IntrinsicWidth(
                        child: Icon(Icons.expand_more,
                            color: Color(0xff000000)))
                  ],
                ),
              ),
              const SizedBox(
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
  final TextEditingController dateController;
  const DatePicker(
    this.dateController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
                controller: dateController,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                decoration: const InputDecoration.collapsed(hintText: ''),
                style: const TextStyle(
                    color: Color(0xff0b204c), fontSize: 20),
              ),
            ),
          ),
          const IntrinsicWidth(
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
        decoration: const BoxDecoration(
            border: Border(
                left: BorderSide(
          color: Color(0xff5a55ca),
          width: 2,
        ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            style: const TextStyle(fontSize: 22),
            decoration: const InputDecoration.collapsed(
              hintText: 'Task Name',
              border: InputBorder.none,
            ),
            controller: myController,
          ),
        ),
      ),
    );
  }
}
