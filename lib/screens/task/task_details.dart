import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dashboard/widgets.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({Key? key, required this.taskId}) : super(key: key);
  final taskId;
  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Task Details",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColor,
              size: 18,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Task')
                .doc(widget.taskId)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!['task_name'],
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Priority : ${data['priority']}",
                      style: GoogleFonts.nunito(
                          color: data['priority'] == "High"
                              ? Colors.red
                              : data['priority'] == "Medium"
                                  ? Colors.orange
                                  : Colors.green,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Uploaded Date : ${data['uploaded_date']}",
                        style: GoogleFonts.nunito(
                            color: Theme.of(context).focusColor, fontSize: 15)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "End Date : ${data['end_date']}",
                      style:
                          GoogleFonts.nunito(color: Colors.red, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description :",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(data['description'],
                        style: GoogleFonts.nunito(
                            color: Theme.of(context).focusColor, fontSize: 15)),
                  ],
                );
              }
              return Center(
                  child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ModelWidgets>().deleteAlert(context, () {
              FirebaseFirestore.instance
                  .collection("Task")
                  .doc(widget.taskId)
                  .delete()
                  .then((value) => Navigator.pop(context))
                  .then((value) => Navigator.pop(context));
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
}
