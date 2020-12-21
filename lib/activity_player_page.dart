import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'ActivityPlayerData.dart';

class ActivityPlayer extends StatefulWidget {
  @override
  _ActivityPlayerState createState() => _ActivityPlayerState();
}

class _ActivityPlayerState extends State<ActivityPlayer> {

  Future<ActivityPlayerData> getActivityPlayerData() async {
    String endPoint = "https://getestoscar.blob.core.windows.net/content/test/lesson/61f7efc9-c3db-4142-8b06-9bc0f5d915f9/default.json";
    Response response = await get(endPoint);
    if(response.statusCode == 200){
      final exec = activityPlayerDataFromJson(response.body);
      final exercises = exec.exercises;
      print(exercises);
    }

  }
  
  void initState(){
    super.initState();
    getActivityPlayerData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('ActivityPlayer Page'),
      ),
    );
  }
}
