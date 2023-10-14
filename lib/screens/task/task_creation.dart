import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rgc_dynamics/screens/dashboard/widgets.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  DateTime todaydate = DateTime.now();
  TextEditingController task_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController priority = TextEditingController();
  List option = ["High", "Medium", "Low"];
  bool isoppressed = false;
  String? selectOption;
  //-------------------------------------------date-------------------------------------------------------------------------------
  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        print("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
      });
    setState(() {
      selectedDate = selectedDate;
    });
  }

//--------------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Create New Task",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColor,
              size: 15,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            context
                .read<ModelWidgets>()
                .textfields(context, "Task Name", task_name, 1),
            //-------------------------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Priority*',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isoppressed = !isoppressed;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                child: selectOption != null
                                    ? Text(selectOption.toString(),
                                        style: TextStyle(
                                            color: selectOption == "High"
                                                ? Colors.red
                                                : selectOption == "Medium"
                                                    ? Colors.orange
                                                    : Colors.green))
                                    : Text(
                                        'Select an Option',
                                        style:
                                            TextStyle(color: Color(0xFF0087B8)),
                                      )),
                            Spacer(),
                            Container(
                                child: isoppressed == true
                                    ? Icon(Icons.arrow_drop_up_sharp)
                                    : Icon(Icons.arrow_drop_down))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: isoppressed == true
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: option.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectOption = option[index];
                                          isoppressed = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          option[index],
                                          style: TextStyle(
                                              color: option[index] == "High"
                                                  ? Colors.red
                                                  : option[index] == "Medium"
                                                      ? Colors.orange
                                                      : Colors.green),
                                        ),
                                      ));
                                },
                              ))
                          : Container())
                ],
              ),
            ),
            //-------------------------------------------------------------------
            context.read<ModelWidgets>().date(context, selectedDate, () {
              setState(() {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                _selectDate(context);
              });
            }),
            context
                .read<ModelWidgets>()
                .textfields(context, "Description", description, 4),
            SizedBox(
              height: 20,
            ),

            context.read<ModelWidgets>().button(context, () {
              if (task_name.text.isEmpty ||
                  description.text.isEmpty ||
                  selectOption == null) {
                Fluttertoast.showToast(msg: "Fill all Fields");
              } else {
                FirebaseFirestore.instance.collection("Task").doc().set({
                  "task_name": task_name.text,
                  "end_date":
                      "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                  "description": description.text,
                  "priority": selectOption.toString(),
                  "uploaded_date":
                      "${todaydate.day}-${todaydate.month}-${todaydate.year}",
                  "date": DateTime.now(),
                  "new": true
                }).then((value) => Navigator.pop(context));
              }
            })
          ]),
        ),
      ),
    );
  }
}
