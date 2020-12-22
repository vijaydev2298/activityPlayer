import 'package:flutter/material.dart';
import 'authorization_bloc.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'activity_player_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Activity Player',
    home: App()
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/learnship-logo.png',
        fit: BoxFit.cover,
        height: 24.0,
        width: 140.0,
        ),
        backgroundColor: Colors.grey[500],
        elevation: 0,
      ),
      body: ActivityPlayer(), //createContent(),
    );
  }

  createContent() {
    return StreamBuilder<bool> (
        stream: authBloc.isSessionValid,
        builder: (context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData && snapshot.data) {
            return HomeScreen();
          }
          return LoginScreen();
        });
  }
}

