import 'package:flutter/foundation.dart';
import 'package:volunteer_companion_app/model/event_model.dart';
import 'package:volunteer_companion_app/model/user_model.dart';
import 'package:volunteer_companion_app/repo/event_repo.dart';
import 'package:volunteer_companion_app/repo/user_repo.dart';

class AppStateProvider extends ChangeNotifier {
  UserModel? _currentUser;
  List<EventModel>? _events;
  UserModel? get currentUser => _currentUser;
  List<EventModel>? get events => _events;
  Future<void> signUpUser(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    UserModel? user = await signup(name, email, phone, password);
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logInUser(String email, String password) async {
    UserModel? user = await login(email, password);
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logOutUser() async {
    await logout();
    _currentUser = null;
    _events = [];
    notifyListeners();
  }

  Future<void> loadEvent() async {
    String uid = _currentUser!.uid;

    _events = await getEvents(uid);

    notifyListeners();
  }

  Future<void> regisForEvent(String eventId) async {
    _currentUser = await regForEvent(eventId, currentUser!.uid);
    _events = _events?.map((event) {
      if (event.id == eventId) event.isRegisteredByMe = true;
      return event;
    }).toList();
    notifyListeners();
  }

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> unregisterFromEvent(String eventId) async {
    _currentUser = await unregForEvent(eventId, currentUser!.uid);
    _events = _events?.map((event) {
      if (event.id == eventId) event.isRegisteredByMe = false;
      return event;
    }).toList();
    notifyListeners();
  }

  bool isBadgeUnlocked(int threshold) {
    int length = currentUser?.eventsRegistered.length ?? 0;
    return length >= threshold;
  }
}
