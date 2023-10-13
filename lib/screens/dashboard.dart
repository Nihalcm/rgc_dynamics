import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgc_dynamics/screens/task/all_task.dart';
import 'package:rgc_dynamics/screens/task/task_creation.dart';

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
      actions: [Text('add')],),
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
                 SizedBox(width: 10,),
                  Text(
                    "New (1)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),Spacer(),InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTask(),));
                  },
                    child: Container(decoration: BoxDecoration(color: Theme.of(context).focusColor,borderRadius: BorderRadius.circular(20)),child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                      child: Row(
                        children: [Icon(Icons.add,color: Colors.white,size: 15,),SizedBox(width: 2,),
                          Text("Add",style: GoogleFonts.nunito(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                        ],
                      ),
                    )),
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
