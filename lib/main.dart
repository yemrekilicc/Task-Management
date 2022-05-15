import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_management/AddTaskPage.dart';
import 'package:task_management/Repository/Task_repository.dart';
import 'package:task_management/model/Task_model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Task'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final now = DateTime.now();
  final weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  late int selectedindex;
  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );

  @override
  void initState() {
    selectedindex=1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskRepo=ref.watch(taskProvider);
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Color(0xfff0f4fd),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            constraints: BoxConstraints(),
            iconSize: 40,
            padding: EdgeInsets.zero,
            icon: Icon(Icons.chevron_left, color: Color(0xff0b204c)),
            onPressed: () {},
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: Color(0xff0b204c)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Color(0xffffffff),
                backgroundImage: Image.asset('lib/image/man.png').image
              ),
            )
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 22),
              child: Stack(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "${Jiffy(now).format('MMM d yyyy')}",
                        style: TextStyle(
                            color: Color(0xff0b204c),
                            fontSize: 16
                        )
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: RichText(
                      text: TextSpan(
                          text: "Today",
                          style: TextStyle(
                            color: Color(0xff0b204c),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return AddTaskPage();
                            },
                          ));
                        },
                        child: IntrinsicWidth(
                          child: Row(
                            children: [Icon(Icons.add), Text("Add Task")],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0, primary: Color(0xfff26950)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: InfiniteListView.builder(
                reverse: true,

                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 365,

                itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedindex=index;
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: selectedindex==index? Color(0xff5a55ca):Color(0xffabb4c9),
                        width: 2
                      ))
                    ),
                    child: Card(
                      color: Color(0xfff0f4fd),
                      elevation: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${weekdays[(now.weekday - index) % 7]}\n',
                                  style: TextStyle(
                                      color: Color(0xffabb4c9))
                              ),
                              TextSpan(
                                  text:
                                      '${now.subtract(Duration(days: index - 1)).day}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedindex==index? Color(0xff5a55ca):Color(0xff0b204c),
                                  ))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 6,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: taskRepo.findTasks(selectedindex-1).length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  ); },
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TaskCardLine1(taskRepo.findTasks(selectedindex-1),index),
                                TaskCardLine2(taskRepo.findTasks(selectedindex-1),index),
                                TaskCardLine3(taskRepo.findTasks(selectedindex-1),index)
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        ));
  }
}



class TaskCardLine1 extends StatelessWidget {
  final List<Task> findTasks;
  final int index;
  const TaskCardLine1(this.findTasks, this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffabb4c9),
          )
        )
      ),
      child: Align(
        alignment:Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: findTasks[index].Catagory,
              style: TextStyle(
                color: findTasks[index].color,
                fontSize: 16
              )
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCardLine2 extends StatelessWidget {
  final List<Task> findTasks;
  final int index;
  const TaskCardLine2(this.findTasks, this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: findTasks[index].color,
              width: 4,
            )
          )
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(findTasks[index].Task_name,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          )
                          ),
                        ),
                        Align(
                          alignment:Alignment.centerRight ,
                            child: Icon(Icons.more_vert,
                            color: Color(0xffabb4c9),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                        child: Text(findTasks[index].Description,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Color(0xffabb4c9),

                          ),
                        ),
                        alignment: Alignment.centerLeft,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class TaskCardLine3 extends StatelessWidget {
  final List<Task> findTasks;
  final int index;
  const TaskCardLine3(this.findTasks, this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time),
              Text("${findTasks[index].Start_time} - ${findTasks[index].End_Time}")
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_alt_outlined),
              Text("2 Persons")
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share),
              Text("Share")
            ],
          ),
        ),

      ],
    );
  }
}
