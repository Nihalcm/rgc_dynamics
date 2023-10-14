import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelWidgets with ChangeNotifier {
  void deleteAlert(BuildContext context, onTap) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        actions: [
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Are you sure you\n want to Delete the Task?',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700, color: Colors.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: onTap,
                              child: Text(
                                'Confirm',
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

//  ----------------------------------------------------------------------------
  Column textfields(
      BuildContext context, title, textEditingController, maxline) {
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
        TextField(textCapitalization: TextCapitalization.sentences,
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

//----------------------------------------------------------------------------------
  InkWell button(BuildContext context, ontap) {
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

//  ----------------------------------------------------------------------------
  Container date(BuildContext context, selectedDate, onTap) {
    return Container(
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
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
