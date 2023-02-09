import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:susu/source/repository/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MyRepository? myRepository;
  HomeCubit({required this.myRepository}) : super(HomeInitial());

  void invetoryIssue(nama_karyawan, departement, bagian, qty) async {
    var body = {
      'nama_karyawan': '$nama_karyawan',
      'departemen': '$departement',
      'bagian': '$bagian',
      'qty': '$qty',
    };
    // emit(InvLoading());
    myRepository!.invetoryIssue(body).then((value) {
      var json = jsonDecode(value.body);
      print('Result Inv issues :$json');
      // emit(InvLoaded(statusCode: value.statusCode, json: json));
      if (json['status'] == 500) {
        Fluttertoast.showToast(
            msg: '${json['message']}\n${json['data']}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void tukarSusu(barcode) async {
    emit(TukarSusuLoading());
    myRepository!.tukarSusu(barcode).then((value) async {
      var jsonTukarsusu = jsonDecode(value.body);
      print('Tukar SUSU: $jsonTukarsusu');
      if (value.statusCode == 200) {
        if (jsonTukarsusu.length == 0) {
          emit(TukarSusuMessage(message: 'Data tidak ditemukan'));
        } else {
          if (jsonTukarsusu[0]['crID'] == 1) {
            invetoryIssue(
              jsonTukarsusu[0]['FullName'],
              jsonTukarsusu[0]['department'],
              jsonTukarsusu[0]['bagian'],
              jsonTukarsusu[0]['jml_susu_diterima'].toString(),
            );
            emit(TukarSusuLoaded(json: jsonTukarsusu, statusCode: value.statusCode, crID: jsonTukarsusu[0]['crID']));
          } else {
            emit(TukarSusuLoaded(json: jsonTukarsusu, statusCode: value.statusCode, crID: jsonTukarsusu[0]['crID']));
          }
        }
      } else {
        emit(TukarSusuMessage(message: json.toString()));
      }
      await Future.delayed(Duration(seconds: 2));
      emit(TukarSusuLoaded(json: [], statusCode: value.statusCode));
    });
  }
}
