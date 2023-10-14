import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("All Task (${snapshot.data!.docs.length})",
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "New (${totalNewTasks})",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTask(),
                          ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Add",
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('Task')
                          .doc(data.id)
                          .update({"new": false});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetails(taskId: data.id),
                          ));
                    },
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.blueGrey, blurRadius: 5)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data['task_name'],
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  child: data['new'] == true
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.teal.shade100,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              'New',
                                              style: GoogleFonts.nunito(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
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
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('End Date : ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(
                                  data['end_date'],
                                  style: GoogleFonts.nunito(
                                      color: Colors.red, fontSize: 15),
                                ),
                                Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Uploaded Date : ',
                                    style: GoogleFonts.nunito(
                                        color: Colors.grey, fontSize: 15)),
                                Text(
                                  data['uploaded_date'],
                                  style: GoogleFonts.nunito(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  'View More >>',
                                  style: GoogleFonts.nunito(
                                      color: Colors.teal, fontSize: 12),
                                )
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
          ]);
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
