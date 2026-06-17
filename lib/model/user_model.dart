import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  String uid;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String phone;
  @HiveField(4)
  List<String> eventsRegistered;
  
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.eventsRegistered
  });
}