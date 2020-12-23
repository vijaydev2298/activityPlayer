import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class ActivityPlayer extends StatefulWidget {
  final data;
  ActivityPlayer(this.data);
  @override
  _ActivityPlayerState createState() => _ActivityPlayerState();
}

class _ActivityPlayerState extends State<ActivityPlayer> {
  List<String> question = [];
  String subTitle = "";
  List<String> availableOptions = [];
  List controllers = [];

  Widget getTextFormField(singleOption) {
    List<TextEditingController> textEditControllers = [];
    var textField = <TextField>[];
    var textEditController = new TextEditingController();
    textEditControllers.insert(0, textEditController);
    textField.add(TextField(
      controller: textEditController,
      autofocus: true,
      enabled: false,
      decoration: InputDecoration(border: OutlineInputBorder()),
    ));
    setState(() {
      controllers.insert(0, textEditControllers[0]);
    });
    return Wrap(children: [textField[0], SizedBox(height: 12.0)]);
  }

  void initState() {
    super.initState();
    //setDataReady();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final htmlTagData = widget.data['config'];
    String contents = htmlTagData['content'].toString();
    final document = parse(contents);
    final String parsedData = parse(document.body.text).body.text;
    List<String> excerciseQuestion = parsedData.split(".");
    final items = htmlTagData['items'];
    List<String> availableOptionData = [];
    for (int i = 0; i < items.length; i++) {
      final temp = items[i];
      availableOptionData.insert(i, temp['label']);
    }
    setState(() {
      question = excerciseQuestion;
      subTitle = widget.data['subTitle'];
      availableOptions = availableOptionData;
    });
    return Scaffold(
      appBar: AppBar(title: Text(widget.data['title'])),
      body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Wrap(children: [
            subTitle.length > 0
                ? Text(
                    subTitle.toString().substring(3, 52),
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700),
                  )
                : Text(""),
            SizedBox(height: 100.0),
            Wrap(
                children: excerciseQuestion.map((e) {
              return Wrap(children: [
                Text(e.trim(),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                SizedBox(height: 20.0),
                Container(
                  color: Colors.blueGrey[100],
                  width: 140.0,
                  height: 20.0,
                  child: getTextFormField(e),
                  margin: EdgeInsets.all(2.0),
                )
              ]);
            }).toList()),
            Wrap(
                children: availableOptionData.map((opt) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    SizedBox(height: 18.0),
                    FlatButton(
                        onPressed: () {},
                        child: Text(opt),
                        color: Colors.amber),
                    SizedBox(width: 12.0)
                  ]),
                );
              }).toList()
            ),
            SizedBox(height: 210.0),
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Wrap(children: [
            FlatButton(
              onPressed: () {},
              color: Colors.blue[500],
              textColor: Colors.white,
              child: Text(
                'Check Answers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            SizedBox(width: 6.0),
            FlatButton(
              onPressed: () {},
              color: Colors.red[300],
              textColor: Colors.white,
              child: Text(
                'Clear',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            SizedBox(width: 6.0),
            FlatButton(
              onPressed: () {},
              color: Colors.grey,
              textColor: Colors.white,
              child: Text(
                'Retry',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            )
          ])
        ])),
        Center(
            child: FlatButton(
          onPressed: () {},
          color: Colors.green[300],
          textColor: Colors.white,
          child: Text(
            'Show Correct Answers',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ))
          ])),
    );
  }
}
