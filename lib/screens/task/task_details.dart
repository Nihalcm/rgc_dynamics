import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Priority : ",
                style: GoogleFonts.nunito(
                    color: Theme.of(context).primaryColor, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Uploaded Date : ",
                  style: GoogleFonts.nunito(
                      color: Theme.of(context).focusColor, fontSize: 15)),
              SizedBox(
                height: 5,
              ),
              Text(
                "End Date : ",
                style: GoogleFonts.nunito(color: Colors.red, fontSize: 15),
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
              Text(
                  "Critical tasks are urgent and high in value. High-priority tasks aren't urgent,yet they bring high value to the business. Medium-priority tasks are urgent but low in value. Lastly, low-priority tasks are non-urgent and low-value.",
                  style: GoogleFonts.nunito(
                      color: Theme.of(context).focusColor, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
