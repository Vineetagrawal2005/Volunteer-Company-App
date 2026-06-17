import 'package:hive/hive.dart';
part 'event_model.g.dart';

@HiveType(typeId: 1)
class EventModel extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String date;
  @HiveField(3)
  String location;
  @HiveField(4)
  String description;
  @HiveField(5)
  String tag;
  @HiveField(6)
  bool isRegisteredByMe;
  
  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.tag,
    required this.isRegisteredByMe
  });
}