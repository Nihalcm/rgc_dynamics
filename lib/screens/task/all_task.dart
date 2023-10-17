import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rgc_dynamics/screens/model/widgets.dart';
import 'package:rgc_dynamics/screens/task/task_creation.dart';
import 'package:rgc_dynamics/screens/task/task_details.dart';
import 'package:iconsax/iconsax.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    SizedBox boxModel() {
      return SizedBox(
        height: 22,
        child: Center(
          child: Container(
            width: 60,
            height: 18,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFde5d8c),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 3, left: 5, right: 5),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFefaec5),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
            ),
          ),
        ),
      );
    }

    SizedBox noCheckBox() {
      return SizedBox(
        width: 25,
        height: 22,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(2.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    SizedBox checkBoxModel() {
      return SizedBox(
        width: 25,
        height: 22,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(2.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 4,
                  left: 5,
                  child: Icon(
                    Icons.check_rounded,
                    color: Color(0xFFff4873),
                    opticalSize: 5,
                  )),
              Positioned(
                  bottom: 2,
                  left: 5,
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    opticalSize: 5,
                  ))
            ],
          ),
        ),
      );
    }

    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Task")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int totalNewTasks =
              snapshot.data!.docs.where((doc) => doc['new'] == true).length;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 110,
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFff4873),
                      Color(0xFFff4873).withOpacity(0.6)
                    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Number of Tasks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "65",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 35),
                            ),
                            Text(
                              "Tasks",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ]),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          checkBoxModel(),
                          SizedBox(
                            height: 5,
                          ),
                          checkBoxModel(),
                          SizedBox(
                            height: 5,
                          ),
                          noCheckBox()
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boxModel(),
                          SizedBox(
                            height: 5,
                          ),
                          boxModel(),
                          SizedBox(
                            height: 5,
                          ),
                          boxModel()
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateTask(),
                      ));
                },
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFF625caa),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Create new Task",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Task List",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('Task')
                            .doc(data.id)
                            .update({"new": false});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetails(taskId: data.id),
                            ));
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.65,
                                    child: Text(
                                      data['task_name'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.5),
                                      color: data['priority'] == 'High'
                                          ? Colors.red.shade50
                                          : data['priority'] == 'Medium'
                                              ? Colors.orange.shade50
                                              : Colors.yellow.shade50,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.5,
                                            right: 2.5,
                                            top: 2.5,
                                            bottom: 2.5),
                                        child: Text(
                                          data['priority'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: data['priority'] == 'High'
                                                  ? Colors.red
                                                  : data['priority'] == 'Medium'
                                                      ? Colors.orange
                                                      : Colors.yellow),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data['uploaded_date'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<ModelWidgets>()
                                            .deleteAlert(context, () {
                                          FirebaseFirestore.instance
                                              .collection("Task")
                                              .doc(data.id)
                                              .delete()
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        });
                                      },
                                      child: Icon(CupertinoIcons.delete,size: 17,))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ]),
          );
        }
        return Center(
            child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
