import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgc_dynamics/screens/task/all_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("All Task (10)",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Spacer(),
                  Text(
                    "New (1)",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
           AllTask()
          ]),
        ),
      ),
    );
  }
}
