import 'package:flutter/material.dart';
import 'ActivityPlayerData.dart';
import 'package:http/http.dart';
import 'activity_player_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List exerciseList = [];
  Future getJson() async {
    String endPoint =
        "https://getestoscar.blob.core.windows.net/content/test/lesson/61f7efc9-c3db-4142-8b06-9bc0f5d915f9/default.json";
    Response response = await get(endPoint);
    if (response.statusCode == 200) {
      final listOfExercises = activityPlayerDataFromJson(response.body);
      List objData = [];
      listOfExercises.exercises.forEach((element) {
        objData.insert(0, {
          "title": element.title,
          "subTitle": element.subtitle,
          "type": element.type,
          "image": element.image,
          "config": element.config
        });
      });
      setState(() {
        exerciseList = objData;
      });
      return objData;
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Activities',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.black
        ),
      ), centerTitle: true,backgroundColor: Colors.white,),
      body: Container(
        child: FutureBuilder(
          future: getJson(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.grey,
                        decorationThickness: 0.0,
                        fontSize: 24.0),
                  )));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final temp = snapshot.data[index];
                  return ListTile(
                      enabled:
                          temp['type'] == "fillinthegapsclick" ? true : false,
                      title: Text(temp['title']),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ActivityPlayer(temp)));
                      });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
