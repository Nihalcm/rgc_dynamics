import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  DateTime todaydate=DateTime.now();
  TextEditingController task_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController priority = TextEditingController();
  //---------------------------------------------textfield-----------------------------------------------------------------------------
  Column textfield(title, textEditingController, maxline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title}*',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          maxLines: maxline,
          controller: textEditingController,
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.teal)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: 'Enter here...',
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w100)),
        )
      ],
    );
  }
//--------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------Button----------------------------------------------------------------------------
  InkWell button(ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "Create",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
//--------------------------------------------------------------------------------------------------------------------------
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


  Container date()
  {
    return      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "End Date :",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                    ),
                    onPressed: () {
                      setState(() {
                        WidgetsBinding.instance?.focusManager.primaryFocus
                            ?.unfocus();
                        _selectDate(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
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
            textfield("Task Name", task_name, 1),
            textfield("Priority", priority, 1),
           date(),
            textfield("Description", description, 4),
            SizedBox(
              height: 20,
            ),
            button(() {
            FirebaseFirestore.instance.collection("Task").doc().set({
              "task_name":task_name.text,
              "end_date":"${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
              "description":description.text,
              "priority":priority.text,
              "uploaded_date":"${todaydate.day}-${todaydate.month}-${todaydate.year}",
              "date":DateTime.now(),
              "new":true

            }).then((value) => Navigator.pop(context));
            })
          ]),
        ),
      ),
    );
  }
}
