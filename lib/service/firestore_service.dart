import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volunteer_companion_app/model/event_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<EventModel>> fetchAllEvents(String uid) async {
  QuerySnapshot snapshot = await _firestore
      .collection('events')
      .get()
      .timeout(const Duration(seconds: 8));

  List<EventModel> eventList = [];

  for (var doc in snapshot.docs) {
    try {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      List<String> registeredUids = List<String>.from(
        data['registeredUids'] ?? [],
      );
      bool isRegisteredByMe = registeredUids.contains(uid);

      EventModel event = EventModel(
        id: doc.id,
        title: data['title'] ?? 'Untitled Event',
        date: data['date'] ?? 'TBA',
        location: data['location'] ?? 'Location TBA',
        description: data['description'] ?? '',
        tag: data['tag'] ?? 'meetup',
        isRegisteredByMe: isRegisteredByMe,
      );

      eventList.add(event);
    } catch (_) {}
  }

  return eventList;
}

Future<void> updateEventRegistration(
  String eventId,
  String uid,
  bool isRegistering,
) async {
  DocumentReference eventDoc = _firestore.collection('events').doc(eventId);

  if (isRegistering) {
    await eventDoc.update({
      'registeredUids': FieldValue.arrayUnion([uid]),
    });
  } else {
    await eventDoc.update({
      'registeredUids': FieldValue.arrayRemove([uid]),
    });
  }
}
