import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:rgc_dynamics/screens/model/widgets.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  DateTime todaydate = DateTime.now();
  String startdate = "";
  String enddate = "";
  TextEditingController task_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController priority = TextEditingController();
  List option = ["Low", "Medium", "High"];
  bool isoppressed = false;
  String? selectOption;
  //-------------------------------------------date-------------------------------------------------------------------------------
  DateTime selectedstartDate = DateTime.now();
  DateTime selectedendDate = DateTime.now();
  String selectedstartTime = "";
  String selectedendTime = "";
  DateTime now = DateTime.now();
  Future<void> _selectstartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final formattedHour = pickedTime.hour.toString().padLeft(2, '0');
      final formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
      final period = pickedTime.hour < 12 ? 'AM' : 'PM';

      final formattedTime = '$formattedHour:$formattedMinute $period';

      setState(() {
        selectedstartTime = formattedTime;
        print(selectedstartTime);
      });
    }
  }

  Future<void> _selectendTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final formattedHour = pickedTime.hour.toString().padLeft(2, '0');
      final formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
      final period = pickedTime.hour < 12 ? 'AM' : 'PM';

      final formattedTime = '$formattedHour:$formattedMinute $period';

      setState(() {
        selectedendTime = formattedTime;
        print(selectedendTime);
      });
    }
  }

  _selectstartDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedstartDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedstartDate)
      setState(() {
        selectedstartDate = selected;
        startdate = DateFormat("d MMM yyyy").format(selectedstartDate);
      });
    Navigator.pop(context);
  }

  _selectendDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedendDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedendDate)
      setState(() {

        enddate = DateFormat("d MMM yyyy").format(selectedendDate);
        print(
            "${selectedendDate.day}-${selectedendDate.month}-${selectedendDate.year}");
      });
    Navigator.pop(context);
  }

//--------------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf3f3f3),
      appBar: AppBar(actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(radius: 15,backgroundColor: Colors.grey,),
      )],
        title: Text(
          "Create new task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            context.read<ModelWidgets>().textfields(
                context, "Task Name", "Enter task name", task_name, 1),
            SizedBox(
              height: 10,
            ),
            context.read<ModelWidgets>().textfields(
                context, "Description", "Enter description...", description, 4),
            SizedBox(
              height: 10,
            ),
            //-------------------------------------------------------------------
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Priority",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: option.length,
                      itemBuilder: (context, index) {
                        final containerWidth =
                            (MediaQuery.of(context).size.width /
                                    option.length) -
                                18;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectOption = option[index];
                              isoppressed = false;
                            });
                          },
                          child: Container(
                            width: containerWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: selectOption == option[index]
                                      ? Color(0xFF625caa)
                                      : Colors.black12,
                                  width: selectOption == option[index] ? 2 : 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                option[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10);
                      },
                    ),
                  )
                ],
              ),
            ),
            //-------------------------------------------------------------------

            SizedBox(
              height: 10,
            ),
            Text(
              "Date",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    startdate == "" ? "From" : startdate.toString(),
                    style: startdate == ""
                        ? TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                  ),
                  Text(" - To - ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  Text(
                    enddate == "" ? "dates" : enddate.toString(),
                    style: enddate == ""
                        ? TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month_sharp,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      context.read<ModelWidgets>().fromtoalert(
                        context,
                        () {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();
                          _selectstartDate(context);
                        },
                        () {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();
                          _selectendDate(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            //=================================================================

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildTimeSelectionContainer(size, selectedstartTime, () {
                  _selectstartTime(context);
                }),
                Spacer(),
                _buildTimeSelectionContainer(size, selectedendTime, () {
                  _selectendTime(context);
                }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "create all mandatory fields above",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            )
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: context.read<ModelWidgets>().button(context, () {
          if (task_name.text.isEmpty ||
              description.text.isEmpty ||
              selectOption == null ||
              selectedstartTime == "" ||
              selectedendTime == "" ||
              selectedendDate == "" ||
              selectedstartDate == "") {
            Fluttertoast.showToast(msg: "Fill all Fields");
          } else {
            FirebaseFirestore.instance.collection("Task").doc().set({
              "task_name": task_name.text,
              "end_date": enddate.toString(),
              "description": description.text,
              "priority": selectOption.toString(),
              "uploaded_date":
                  DateFormat("d MMM yyyy").format(todaydate).toString(),
              "start_time": selectedstartTime,
              "end_time": selectedendTime,
              "date": DateTime.now(),
              "new": true,
              "start_date": startdate.toString()
            }).then((value) => Navigator.pop(context));
          }
        }),
      ),
    );
  }

  Widget _buildTimeSelectionContainer(size, String selectedTime, ontap) {
    final TextStyle textStyle = selectedTime.isEmpty
        ? TextStyle(
            color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w700)
        : TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700);

    return Container(
      height: 45,
      width: size.width / 2 - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Text(selectedTime.isEmpty ? "00:00" : selectedTime, style: textStyle),
          Spacer(),
          IconButton(
            icon: Icon(Icons.alarm, color: Colors.grey),
            onPressed: ontap,
          ),
        ],
      ),
    );
  }
}
