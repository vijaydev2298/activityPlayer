import 'package:rxdart/rxdart.dart';
import 'authorization_bloc.dart';
import 'dart:async';
import 'repository.dart';

class LoginBloc {
  Repository repository = Repository();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (email, password) => true);
  Stream<bool> get loading => _loadingData.stream;
  void submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }
  login(String email, String password) async {
    String token = await repository.login(email, password);
   _loadingData.sink.add(false);
    authBloc.openSession(token);
  }
  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    if (email != null && email.length > 4 && regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Invalid email!');
    }
  });

  final validatePassword =
  StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    String p =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

    RegExp regExp = new RegExp(p);
    if (password != null && password.length >= 8 && regExp.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError('Invalid Password!');
    }
  });


  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}