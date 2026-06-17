import 'package:volunteer_companion_app/model/event_model.dart';
import 'package:volunteer_companion_app/model/user_model.dart';
import 'package:volunteer_companion_app/service/firestore_service.dart';
import 'package:volunteer_companion_app/service/hive_service.dart';

Future<UserModel?> regForEvent(String eventId, String uid) async {
  await updateEventRegFlag(eventId, true);
  UserModel? user = await getUserByUid(uid);
  if (user != null && !user.eventsRegistered.contains(eventId)) {
    user.eventsRegistered.add(eventId);
    await saveUser(user);
  }
  try {
    await updateEventRegistration(eventId, uid, true);
  } catch (_) {}
  return user;
}

Future<UserModel?> unregForEvent(String eventId, String uid) async {
  await updateEventRegFlag(eventId, false);
  UserModel? user = await getUserByUid(uid);
  if (user != null && user.eventsRegistered.contains(eventId)) {
    user.eventsRegistered.remove(eventId);
    await saveUser(user);
  }
  try {
    await updateEventRegistration(eventId, uid, false);
  } catch (_) {}
  return user;
}

Future<List<EventModel>> getEvents(String uid) async {
  List<EventModel> localEvents = await getAllEvent() ?? [];

  try {
    List<EventModel> freshEvents = await fetchAllEvents(uid);

    await saveAllEvent(freshEvents);

    return freshEvents;
  } catch (e) {
    return localEvents;
  }
}
