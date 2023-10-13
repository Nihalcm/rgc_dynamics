import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgc_dynamics/screens/task/task_details.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return   ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetails(),));
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
                          "Title",
                          style:
                          Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.teal.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5),
                            child: Text(
                              'New',
                              style: GoogleFonts.nunito(
                                  color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
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
                          "orderdate",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium,
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
    );
  }
}
