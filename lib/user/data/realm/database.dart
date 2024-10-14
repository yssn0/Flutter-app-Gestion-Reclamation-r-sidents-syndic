//lib\user\data\realm\database.dart
import 'package:realm/realm.dart';
part 'database.realm.dart';

@RealmModel()
class _AppUser {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  
  late String email;
  late String? phoneNumber;
  late String userType; // 'user' or 'syndic'
  late String? name;
  late String? surname;
}

@RealmModel()
class _Reclamation {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  
  late String imageUrl; 
  late String? problem;
  late String? commentaire;
  late String? status;
  late String? color;
  late bool? isOpen;
  late DateTime? date;
  late String? imageConfirmedUrl;
  
  late ObjectId? userId; // ID of the user who created the reclamation 
  late ObjectId? syndicId; // ID of the syndic assigned to the reclamation
  late int? satisfactionLevel; // 0 for sad, 50 for medium, 100 for happy
  late String? reactionComment;
  late String? syndicComment;
}


@RealmModel()
class _AppNotification {  // Changed from _Notification to _AppNotification
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  
  late String title;
  late String content;
  late DateTime createdAt;
  late bool isRead;
  late ObjectId userId; // ID of the user this notification is for
}

@RealmModel() 
class _Sponsorship { 
  @PrimaryKey() 
  @MapTo('_id') 
  late ObjectId id; 
  late ObjectId userId; // ID of the user creating the sponsorship 
  late String name; 
  late String surname;
  late String phoneNumber; 
  late String email; 
  String? comment; 
  @MapTo('createdAt') 
  late DateTime createdAt; 
  } 

@RealmModel()
class _AccessRequest {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
  late String surname;
  late String phoneNumber;
  late String email;
  late String reason;
  @MapTo('createdAt')
  late DateTime createdAt;
  late String status; // 'pending', 'approved', or 'rejected'
}