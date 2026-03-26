import '../models/user_data.dart';

abstract class UserDataRepository {
  Future<List<UserData>> getAllUsers();
  Future<UserData?> getUserById(String id);
  Future<void> addUser(UserData user);
  Future<void> updateUser(UserData user);
  Future<void> deleteUser(String id);
  Future<void> deleteAllUsers();
}
