part of 'database_bloc.dart';

sealed class DatabaseEvent {}

final class AddDataEvent extends DatabaseEvent {
  final FormData data;

  AddDataEvent({required this.data});
}

final class GetDataEvent extends DatabaseEvent {}
