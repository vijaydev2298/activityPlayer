import 'package:flutter/services.dart';
import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'ActivityPlayerData.dart';

class ActivityPlayer extends StatefulWidget {
  @override
  _ActivityPlayerState createState() => _ActivityPlayerState();
}

class _ActivityPlayerState extends State<ActivityPlayer> {
  List exerciseData;
  FocusNode myFocusNode;
  TextEditingController controller = TextEditingController();
  List optionsAndAns = [];
  String isRight = "null";

  Future<ActivityPlayerData> getActivityPlayerData() async {
    String endPoint =
        "https://getestoscar.blob.core.windows.net/content/test/lesson/61f7efc9-c3db-4142-8b06-9bc0f5d915f9/default.json";
    Response response = await get(endPoint);
    if (response.statusCode == 200) {
      final exec = activityPlayerDataFromJson(response.body);
      final fillInTheGapsClick = [];
      int index = 0;
      for (int i = 0; i < exec.exercises.length; i++) {
        if (exec.exercises[i].type == "fillinthegapsclick") {
          fillInTheGapsClick.insert(index, exec.exercises[i]);
          index += 1;
        }
      }
      setState(() {
        exerciseData = fillInTheGapsClick;
      });
    }
  }

  void initState() {
    super.initState();
    getActivityPlayerData();
    myFocusNode = FocusNode();
  }

  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  Widget getTextWidgets(List exercises) {
    return Column(children: <Widget>[
      Wrap(
          children: exercises.map((e) {
        String htmlTagData = e.config['content'].toString();
        //htmlTagData = htmlTagData.replaceAll("<c-blank></c-blank>", "<input type=text/>");
        final document = parse(htmlTagData);
        final String parsedData = parse(document.body.text).body.text;
        List<String> excerciseQuestion = parsedData.split(".");
        final options = e.config['items'];
        List userDisplayOptions = [];
        for (int i = 0; i < options.length; i++) {
          if (options[i] != null) {
            final obj = options[i];
            userDisplayOptions.insert(i, obj['label']);
          }
        }
        setState(() {
          optionsAndAns = userDisplayOptions;
        });
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.assignment_turned_in_outlined,
                    color: Colors.amber, size: 40.0),
                SizedBox(width: 12.0),
                Text(
                  e.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(e.subtitle.toString().substring(3, 52),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
            SizedBox(height: 12.0),
            Wrap(
              children: excerciseQuestion.map((ques) {
                return Wrap(children: [
                  Text(
                    ques.trim(),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 12.0),
                  Container(
                      color: isRight != "null"
                          ? isRight == "true"
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      width: 140.0,
                      height: 20.0,
                      child: TextFormField(
                        controller: controller,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        showCursor: true,
                        focusNode: myFocusNode,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      )),
                ]);
              }).toList(),
            ),
            SizedBox(height: 12.0),
            Wrap(
                children: userDisplayOptions.map((opt) {
              return Row(children: [
                FlatButton(
                    onPressed: () {
                      controller.text = opt;
                      print(controller);
                    },
                    child: Text(opt),
                    color: Colors.amber),
                SizedBox(width: 12.0)
              ]);
            }).toList())
          ],
        );
      }).toList()),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
                FlatButton(
        onPressed: () {
          String textBoxAnswer = controller.text;
          String isCorrect =
              optionsAndAns[0] == textBoxAnswer ? "true" : "false";
          setState(() {
            isRight = isCorrect;
          });
        },
        color: Colors.blue[500],
        textColor: Colors.white,
        child: Text(
          'Check Answers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
      SizedBox(width: 6.0),
      FlatButton(
        onPressed: () {
          setState(() {
            controller.text = "";
          });
        },
        color: Colors.red[300],
        textColor: Colors.white,
        child: Text(
          'Clear',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
            ]
          )
        ]
      )),
      Center(
        child: Row(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {
              setState(() {
                controller.text = "";
              });
            },
            color: Colors.green[300],
            textColor: Colors.white,
            child: Text(
              'Show Correct Answers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          SizedBox(width: 6.0),
          FlatButton(
            onPressed: () {
              setState(() {
                controller.text = "";
              });
            },
            color: Colors.green[300],
            textColor: Colors.white,
            child: Text(
              'Retry',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
        ],
      )
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.all(12.0),
          child: exerciseData != null
              ? getTextWidgets(exerciseData)
              : Center(
                  child: Text(
                  "Loading...",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ))),
    );
  }
}
