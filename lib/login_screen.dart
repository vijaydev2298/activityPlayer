import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'main.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'activity_player_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userService = UserService(userPool);
  User _user = User();
  bool _isAuthenticated = false;

  Future<UserService> _getValues() async {
    await _userService.init();
    _isAuthenticated = await _userService.checkAuthenticated();
    return _userService;
  }

  void submit(BuildContext context) async {
    _formKey.currentState.save();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActivityPlayer()
    ));
    String message;
    try {
      _user = await _userService.login(_user.email, _user.password);
      message = 'User sucessfully logged in!';
      if (!_user.confirmed) {
        message = 'Please confirm user account';
      }
    } on CognitoClientException catch (e) {
      print(e);
      if (e.code == 'InvalidParameterException' ||
          e.code == 'NotAuthorizedException' ||
          e.code == 'UserNotFoundException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message;
      } else {
        message = 'An unknown client error occured';
      }
    } catch (e) {
      message = 'An unknown error occurred';
    }
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () async {
          if (_user.hasAccess) {
            Navigator.pop(context);
          }
        },
      ),
      duration: Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              body: Builder(
                builder: (BuildContext context) {
                  return Container(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            // leading: const Icon(Icons.email),
                            title: TextFormField(
                              // initialValue: widget.email,
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  labelText: 'Username'),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String email) {
                                _user.email = email;
                              },
                            ),
                          ),
                          ListTile(
                            // leading: const Icon(Icons.lock),
                            title: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onSaved: (String password) {
                                _user.password = password;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            // width: screenSize.width,
                            child: RaisedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                submit(context);
                              },
                              color: Colors.blue,
                            ),
                            margin: EdgeInsets.only(
                              top: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    //   body: Container(
    //     child: Container(
    //       height: 500,
    //       padding: EdgeInsets.all(20.0),
    //       margin: EdgeInsets.all(20.0),
    //       child: Column(
    //         children: <Widget>[
    //           Text("Log in",
    //           style: TextStyle(
    //             fontSize: 24.0,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.grey[850]
    //           ),),
    //           SizedBox(height: 8.0,),
    //           ListTile(
    //                 title: TextFormField(
    //                   decoration: InputDecoration(
    //                       hintText: 'Username', labelText: 'Username'),
    //                   keyboardType: TextInputType.emailAddress,
    //                   onSaved: (String email) {
    //                     _user.email = email;
    //                   },
    //                 ),
    //               ),
    //               ListTile(
    //                 title: TextFormField(
    //                   decoration: InputDecoration(
    //                     hintText: 'Password!',
    //                   ),
    //                   obscureText: true,
    //                   onSaved: (String password) {
    //                     _user.password = password;
    //                   },
    //                 ),
    //               ),
    //           // passwordField(bloc),
    //           Container(margin: EdgeInsets.only(top: 25.0)),
    //           // submitButton(bloc),
    //           Container(
    //             padding: EdgeInsets.all(20.0),
    //             child: RaisedButton(
    //               child: Text(
    //                 'Login',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onPressed: () {
    //                 submit(context);
    //               },
    //               color: Colors.blue,
    //             ),
    //             margin: EdgeInsets.only(
    //               top: 10.0,
    //           )),
    //           loadingIndicator(bloc)
    //         ],
    //       ),
    //   ),
    // )
    );
  }
}
// Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
//   stream: bloc.email,
//   builder: (context, snap) {
//     return TextField(
//       keyboardType: TextInputType.emailAddress,
//       onChanged: bloc.changeEmail,
//       decoration: InputDecoration(
//           labelText: "Username",
//           errorText: snap.error
//       ),
//     );
//   },
// );

// Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
//     stream: bloc.password,
//     builder:(context, snap) {
//       return TextField(
//         obscureText: true,
//         onChanged: bloc.changePassword,
//         decoration: InputDecoration(
//             labelText: "Password",
//             errorText: snap.error
//         ),
//       );
//     }
// );

// Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
//   stream: bloc.submitValid,
//   builder: (context, snap) {
//     return RaisedButton(
//       onPressed: submit(context),
//       child: Text("Continue", style: TextStyle(color: Colors.white),),
//     color: Colors.teal[600],
//     );
//   },
// );
