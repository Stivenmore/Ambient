// ignore_for_file: file_names

import 'dart:async';
import 'package:ambient/screens/utils/validation.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

//   // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => Rx.combineLatest2(
      emailStream, passwordStream, (dynamic e, dynamic p) => true);

//   // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

//   // Obtener el último valor ingresado a los streams
// con validacion de si es nulo o no
  String? get email => _emailController.value;
  String? get password => _passwordController.value;

//Liberacion de flujos
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

class LetraValidate with Validators {
  final _descripcionController = BehaviorSubject<String>();
  final _namecurseController = BehaviorSubject<String>();
  final _nivelController = BehaviorSubject<String>();
  final _tutorController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _urlController = BehaviorSubject<String>();

  Stream<String> get descripcionStream =>
      _descripcionController.stream.transform(validarletras);
  Stream<String> get namecurseStream =>
      _namecurseController.stream.transform(validarletras);
  Stream<String> get nivelStream =>
      _nivelController.stream.transform(validarletras);
  Stream<String> get tutorStream =>
      _tutorController.stream.transform(validarletras);
  Stream<String> get nombreStream =>
      _nombreController.stream.transform(validarletras);
  Stream<String> get urlStream => _urlController.stream.transform(validarURL);

  Stream<bool> get formValidStream => Rx.combineLatest5(
      descripcionStream,
      namecurseStream,
      nivelStream,
      nombreStream,
      urlStream,
      (dynamic a, dynamic b, dynamic c, dynamic d, dynamic e,) =>
          true);

  String? get descripcion => _descripcionController.value;
  String? get namecurse => _namecurseController.value;
  String? get nivel => _nivelController.value;
  String? get tutor => _tutorController.value;
  String? get url => _urlController.value;
  String? get nombre => _nombreController.value;

  Function(String) get changedescripcionr => _descripcionController.sink.add;
  Function(String) get changenamecurse => _namecurseController.sink.add;
  Function(String) get changenivel => _nivelController.sink.add;
  Function(String) get changetutor => _tutorController.sink.add;
  Function(String) get changenombre => _nombreController.sink.add;
  Function(String) get changeurl => _urlController.sink.add;

  dispose() {
    _descripcionController.close();
    _namecurseController.close();
    _nivelController.close();
    _nombreController.close();
    _tutorController.close();
    _urlController.close();
  }
}

class AddCapValidate with Validators{
  final _nombreController = BehaviorSubject<String>();
  final _urlController = BehaviorSubject<String>();

  Stream<String> get nombreStream =>
      _nombreController.stream.transform(validarletras);
  Stream<String> get urlStream => _urlController.stream.transform(validarURL);

  Stream<bool> get formValidStream => Rx.combineLatest2(
      nombreStream,
      urlStream,
      (dynamic a, dynamic b) =>
          true);
  String? get url => _urlController.value;
  String? get nombre => _nombreController.value;

  Function(String) get changenombre => _nombreController.sink.add;
  Function(String) get changeurl => _urlController.sink.add;

  dispose() {
    _nombreController.close();
    _urlController.close();
  }
}