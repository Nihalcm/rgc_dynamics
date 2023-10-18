import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rgc_dynamics/screens/dashboard/number_widget.dart';
import 'package:rgc_dynamics/screens/model/widgets.dart';
import 'package:rgc_dynamics/screens/task/task_creation.dart';
import 'package:rgc_dynamics/screens/task/task_details.dart';


class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {


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
                  NumberDisplay(totalnumber: snapshot.data!.docs.length.toString()),
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
                              builder: (context) => TaskDetails(
                                taskId: data.id,
                                data: data,
                              ),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      data['task_name'],
                                      style: TextStyle(color: Colors.black),
                                      softWrap: true,
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
                                        padding: const EdgeInsets.all(2.5),
                                        child: Text(
                                          data['priority'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: data['priority'] == 'High'
                                                ? Colors.red
                                                : data['priority'] == 'Medium'
                                                    ? Colors.orange
                                                    : Colors.yellow,
                                          ),
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
                                      child: Icon(
                                        CupertinoIcons.delete,
                                        size: 17,
                                      ))
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
