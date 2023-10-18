import 'package:flutter/material.dart';
class NumberDisplay extends StatefulWidget {
   NumberDisplay({Key? key,required this.totalnumber}) : super(key: key);
final totalnumber;
  @override
  State<NumberDisplay> createState() => _NumberDisplayState();
}

class _NumberDisplayState extends State<NumberDisplay> {
  SizedBox boxModel() {
    return SizedBox(
      height: 22,
      child: Center(
        child: Container(
          width: 60,
          height: 18,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFde5d8c),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 3, left: 5, right: 5),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFefaec5),
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox noCheckBox() {
    return SizedBox(
      width: 25,
      height: 22,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2.5)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox checkBoxModel() {
    return SizedBox(
      width: 25,
      height: 22,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2.5)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5)),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 4,
                left: 5,
                child: Icon(
                  Icons.check_rounded,
                  color: Color(0xFFff4873),
                  opticalSize: 5,
                )),
            Positioned(
                bottom: 2,
                left: 5,
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  opticalSize: 5,
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return    Container(
      height: 110,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFff4873),
            Color(0xFFff4873).withOpacity(0.6)
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Number of Tasks",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.totalnumber,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                  Text(
                    "Tasks",
                    style:
                    TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ]),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checkBoxModel(),
                SizedBox(
                  height: 5,
                ),
                checkBoxModel(),
                SizedBox(
                  height: 5,
                ),
                noCheckBox()
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boxModel(),
                SizedBox(
                  height: 5,
                ),
                boxModel(),
                SizedBox(
                  height: 5,
                ),
                boxModel()
              ],
            )
          ],
        ),
      ),
    );
  }
}
