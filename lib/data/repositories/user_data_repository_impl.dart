import 'package:hive_example/core/models/user_data.dart';
import 'package:hive_example/core/repositories/user_data_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';


class UserDataRepositoryImpl implements UserDataRepository {
  final Box<dynamic> _box;

  UserDataRepositoryImpl(this._box);

  @override
  Future<List<UserData>> getAllUsers() async {
    try {
      final users = <UserData>[];
      for (var key in box.keys) {
        final data = box.get(key);
        if (data is Map<String, dynamic>) {
          users.add(UserData.fromMap(data));
        }
      }
      return users;
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  @override
  Future<UserData?> getUserById(String id) async {
    try {
      final data = box.get(id);
      if (data is Map<String, dynamic>) {
        return UserData.fromMap(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by id: $e');
    }
  }

  @override
  Future<void> addUser(UserData user) async {
    try {
      await box.put(user.id, user.toMap());
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<void> updateUser(UserData user) async {
    try {
      await box.put(user.id, user.toMap());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    try {
      await box.clear();
    } catch (e) {
      throw Exception('Failed to delete all users: $e');
    }
  }

  Box get box => _box;
}
