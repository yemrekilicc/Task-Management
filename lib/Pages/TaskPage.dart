import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'AddTaskPage.dart';
import '../model/Task_model.dart';
import '../Provider/taskpageProvider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final now = DateTime.now();
  final weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );
  List<Task> selectedTasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskpro = ref.watch(taskpageProvider);
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: const Color(0xfff0f4fd),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            constraints: const BoxConstraints(),
            iconSize: 40,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left, color: Color(0xff0b204c)),
            onPressed: () {},
          ),
          title: Text(
            widget.title,
            style: const TextStyle(color: Color(0xff0b204c)),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 22),
              child: Stack(
                children: [
                  RichText(
                    text: TextSpan(
                        text: Jiffy(now).format('MMM d yyyy'),
                        style: const TextStyle(
                            color: Color(0xff0b204c), fontSize: 16)),
                  ),
                  Positioned(
                    top: 15,
                    child: RichText(
                      text: const TextSpan(
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
                              return const AddTaskPage();
                            },
                          ));
                        },
                        child: IntrinsicWidth(
                          child: Row(
                            children: const [
                              Icon(Icons.add),
                              Text("Add Task")
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            primary: const Color(0xfff26950)),
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
                scrollDirection: Axis.horizontal,
                itemCount: 365,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    setState(() {
                      taskpro.changeselectedday(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: taskpro.returnselectedday() == index
                                    ? const Color(0xff5a55ca)
                                    : const Color(0xffabb4c9),
                                width: 2))),
                    child: Card(
                      color: const Color(0xfff0f4fd),
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
                                  style: const TextStyle(
                                      color: Color(0xffabb4c9))),
                              TextSpan(
                                  text:
                                      '${now.subtract(Duration(days: index - 1)).day}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: taskpro.returnselectedday() == index
                                        ? const Color(0xff5a55ca)
                                        : const Color(0xff0b204c),
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
            const SizedBox(
              height: 12,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 6,
              child:Query(
                  options: QueryOptions(
                      fetchPolicy: FetchPolicy.noCache,
                      document: gql(taskpro.getTasks(DateFormat('yyyy-MM-dd')
                          .format(DateTime.now()
                          .subtract(Duration(days: taskpro.returnselectedday() - 1)))))),
                  builder: (QueryResult<Object?> result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    taskpro.selectedTasks.clear();
                    if (result.data!["Tasks"] != null &&
                        result.data?["Tasks"].length != 0) {
                      taskpro.selectedTasks = result.data!["Tasks"]
                          .map<Task>((e) => Task.fromJson(e))
                          .toList();
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: taskpro.selectedTasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      TaskCardLine1(taskpro.selectedTasks, index),
                                      TaskCardLine2(taskpro.selectedTasks, index),
                                      TaskCardLine3(taskpro.selectedTasks, index)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
              ),
          ]),
        ));
  }
}

class TaskCardLine1 extends StatelessWidget {
  final List<Task> findTasks;
  final int index;
  const TaskCardLine1(
    this.findTasks,
    this.index, {
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
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
                text: findTasks[index].catagory,
                style:
                    TextStyle(color: findTasks[index].colorint, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

class TaskCardLine2 extends ConsumerWidget {
  final List<Task> findTasks;
  final int index;
  const TaskCardLine2(
    this.findTasks,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
          color: findTasks[index].colorint,
          width: 4,
        ))),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(findTasks[index].taskName,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.centerRight,
                          child: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_vert,
                                color: Color(0xffabb4c9)),
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem<int>(
                                  child: Text("Edit Task"),
                                  value: 0,
                                ),
                                const PopupMenuItem<int>(
                                  child: Text("Delete Task"),
                                  value: 1,
                                ),
                              ];
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      child: Text(
                        findTasks[index].description,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
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
  const TaskCardLine3(
    this.findTasks,
    this.index, {
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
              const Icon(Icons.access_time),
              Text(
                  "${findTasks[index].startTime} - ${findTasks[index].endTime}")
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.people_alt_outlined),
              Text("2 Persons")
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.share), Text("Share")],
          ),
        ),
      ],
    );
  }
}
