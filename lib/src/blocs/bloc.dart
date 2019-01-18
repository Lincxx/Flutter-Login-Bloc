import 'dart:async';
import 'validators.dart';

import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  // final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();

  //replacing this streamController with BehaviorSubect so we can get older data, whereas a StreamController there is not a way to do that 
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Add data to a stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //Returns a combine stream
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  //Change data - sink puts the value back into the stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;


  submit() {
    final validEmial = _email.value;
    final validPassword = _password.value;
    print('Email is $validEmial');
    print('Password is $validPassword');
  }

  //Clean up 
  dispose(){
    _email.close();
    _password.close();
  }
}



