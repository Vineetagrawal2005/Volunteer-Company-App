import 'package:hive/hive.dart';
import 'package:volunteer_companion_app/model/badge_model.dart';
import 'package:volunteer_companion_app/model/event_model.dart';
import 'package:volunteer_companion_app/model/user_model.dart';

final badgeBox = Hive.box<BadgeModel>('BadgeBox');
final userBox = Hive.box<UserModel>('UserBox');
final eventBox = Hive.box<EventModel>('EventBox');

Future<void> saveUser(UserModel user) async {
  await userBox.put(user.uid, user);
}

Future<UserModel?> getUserByUid(String uid) async {
  if (userBox.containsKey(uid)) {
    UserModel? user = userBox.get(uid);
    return user;
  }
  return null;
}

Future<void> saveAllEvent(List<EventModel> listEvent) async {
  for (var event in listEvent) {
    await eventBox.put(event.id, event);
  }
}

Future<List<EventModel>?> getAllEvent() async {
  return eventBox.values.toList();
}

Future<void> saveAllBadge(List<BadgeModel> listBadge) async {
  for (var badge in listBadge) {
    await badgeBox.put(badge.id, badge);
  }
}

Future<List<BadgeModel>?> getAllBadge() async {
  return badgeBox.values.toList();
}

Future<bool> checkIfBadge() async {
  return badgeBox.isEmpty;
}

Future<void> updateEventRegFlag(String id, bool isRegisteredByMe) async {
  EventModel? event = eventBox.get(id);
  if (event != null) {
    event.isRegisteredByMe = isRegisteredByMe;
    await eventBox.put(id, event);
  }
}
