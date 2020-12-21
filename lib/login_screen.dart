import 'package:flutter/material.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("Login Page",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
            SizedBox(height: 8.0,),
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(bloc),
            loadingIndicator(bloc)
          ],
        ),
      ),
    );
  }
}
Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.loading,
  builder: (context, snap) {
    return Container(
      child: (snap.hasData && snap.data)
          ? CircularProgressIndicator()
          : null,
    );
  },
);
Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
  stream: bloc.email,
  builder: (context, snap) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      onChanged: bloc.changeEmail,
      decoration: InputDecoration(
          labelText: "Email address",
          errorText: snap.error
      ),
    );
  },
);

Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
    stream: bloc.password,
    builder:(context, snap) {
      return TextField(
        obscureText: true,
        onChanged: bloc.changePassword,
        decoration: InputDecoration(
            labelText: "Password",
            errorText: snap.error
        ),
      );
    }
);

Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
  stream: bloc.submitValid,
  builder: (context, snap) {
    return RaisedButton(
      onPressed: (!snap.hasData) ? null : bloc.submit,
      child: Text("Login", style: TextStyle(color: Colors.white),),
    color: Colors.blue,
    );
  },
);