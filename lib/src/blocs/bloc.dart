import 'dart:async';
import 'validators.dart';

import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();

  //Add data to a stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //Returns a combine stream
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  //Change data - sink puts the value back into the stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;


  submit() {
    
  }

  //Clean up 
  dispose(){
    _email.close();
    _password.close();
  }
}



