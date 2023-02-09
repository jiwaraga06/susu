part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class TukarSusuLoading extends HomeState {}

class TukarSusuMessage extends HomeState {
  final String? message;

  TukarSusuMessage({this.message});
}

class TukarSusuLoaded extends HomeState {
  final int? statusCode;
  final int? crID;
  dynamic json;

  TukarSusuLoaded({this.crID, this.statusCode, this.json});
}

class InvLoading extends HomeState {}

class InvLoaded extends HomeState {
  final int? statusCode;
  dynamic json;

  InvLoaded({this.statusCode, this.json});
}
