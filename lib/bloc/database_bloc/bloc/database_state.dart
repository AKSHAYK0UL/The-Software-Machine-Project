part of 'database_bloc.dart';

sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}

final class DatabaseLoadingState extends DatabaseState {
  final DatabaseEnum loadingSource;

  DatabaseLoadingState({required this.loadingSource});
}

final class DatabaseErrorState extends DatabaseState {
  final String errorMessage;
  final DatabaseEnum errorSource;

  DatabaseErrorState({required this.errorSource, required this.errorMessage});
}

final class DatabaseSuccessState extends DatabaseState {
  final DatabaseEnum successSource;

  DatabaseSuccessState({required this.successSource});
}

final class ProfileDataState extends DatabaseState {
  final FormData data;
  final DatabaseEnum dataSource;

  ProfileDataState({required this.data, required this.dataSource});
}
