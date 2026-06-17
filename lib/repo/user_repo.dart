import 'package:volunteer_companion_app/model/user_model.dart';
import 'package:volunteer_companion_app/service/auth_service.dart';
import 'package:volunteer_companion_app/service/hive_service.dart';

Future<UserModel?> signup(
  String name,
  String email,
  String phone,
  String password,
) async {
  Id? result = await signUp(email, password);

  if (result == null) {
    return null;
  }

  UserModel newUser = UserModel(
    uid: result.uid!,
    name: name,
    email: result.email!,
    phone: phone,
    eventsRegistered: [],
  );

  await saveUser(newUser);

  return newUser;
}

Future<UserModel?> login(String email, String password) async {
  Id? result = await signIn(email, password);

  if (result == null) {
    return null;
  }

  UserModel? existingUser = await getUserByUid(result.uid!);

  if (existingUser != null) {
    return existingUser;
  }

  UserModel fallbackUser = UserModel(
    uid: result.uid!,
    name: '',
    email: result.email!,
    phone: '',
    eventsRegistered: [],
  );

  await saveUser(fallbackUser);

  return fallbackUser;
}

Future<void> logout() async {
  await signOut();
}
