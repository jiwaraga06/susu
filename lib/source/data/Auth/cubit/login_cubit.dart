import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susu/source/repository/repository.dart';
import 'package:susu/source/router/string.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final MyRepository? myRepository;
  LoginCubit({this.myRepository}) : super(LoginInitial());

  void session(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    if (username == null) {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
    }
  }

  void login(context, username, password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(LoginLoading());
    myRepository!.login(username, password).then((value) async {
      var json = jsonDecode(value.body);
      print('Result Login: $json');
      if (value.statusCode == 200) {
        if (json.isEmpty) {
          emit(LoginLoaded(statusCode: value.statusCode, json: json, message: 'Data tidak ditemukan'));
        } else {
          if (json[0]['Result'] == 4) {
            pref.setString('username', username);
            pref.setString('result', json[0]['Result'].toString());
            emit(LoginLoaded(statusCode: value.statusCode, json: json, message: 'Berhasil Login'));
            await Future.delayed(Duration(seconds: 3));
            Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
          } else {
            emit(LoginLoaded(statusCode: value.statusCode, json: json, message: 'Akun Bukan HRD'));
          }
        }
      } else {
        emit(LoginLoaded(statusCode: value.statusCode, json: json, message: ''));
      }
    });
  }

  void keluar(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
  }
}
