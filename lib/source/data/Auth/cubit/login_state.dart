part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final int? statusCode;
  final String? message;
  dynamic json;

  LoginLoaded({this.statusCode, this.message,this.json});
}
