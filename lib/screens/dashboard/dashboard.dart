import 'package:flutter/material.dart';

import 'package:rgc_dynamics/screens/task/all_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f3f3),
      appBar: AppBar(
       leading: Icon(Icons.menu,color: Colors.black,),
        title: Text(
          'To-do List',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0), child: AllTask()),
      ),
    );
  }
}
