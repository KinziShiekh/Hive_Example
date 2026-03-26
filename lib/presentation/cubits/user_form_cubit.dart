import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_example/core/models/user_data.dart';
import 'package:hive_example/core/repositories/user_data_repository.dart';


class UserFormCubit extends Cubit<UserFormState> {
  final UserDataRepository _repository;

  UserFormCubit(this._repository) : super(UserFormInitial());

  void loadUsers() async {
    emit(UserFormLoading());
    try {
      final users = await _repository.getAllUsers();
      emit(UserFormLoaded(users: users));
    } catch (e) {
      emit(UserFormError(message: e.toString()));
    }
  }

  void addUser(String name, String email, String phone) async {
    emit(UserFormLoading());
    try {
      final user = UserData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
      await _repository.addUser(user);
      loadUsers();
    } catch (e) {
      emit(UserFormError(message: e.toString()));
    }
  }

  void deleteUser(String id) async {
    emit(UserFormLoading());
    try {
      await _repository.deleteUser(id);
      loadUsers();
    } catch (e) {
      emit(UserFormError(message: e.toString()));
    }
  }

  void deleteAllUsers() async {
    emit(UserFormLoading());
    try {
      await _repository.deleteAllUsers();
      loadUsers();
    } catch (e) {
      emit(UserFormError(message: e.toString()));
    }
  }
}

abstract class UserFormState {}

class UserFormInitial extends UserFormState {}

class UserFormLoading extends UserFormState {}

class UserFormLoaded extends UserFormState {
  final List<UserData> users;

  UserFormLoaded({required this.users});
}

class UserFormError extends UserFormState {
  final String message;

  UserFormError({required this.message});
}
