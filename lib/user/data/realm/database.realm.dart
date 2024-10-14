// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AppUser extends _AppUser with RealmEntity, RealmObjectBase, RealmObject {
  AppUser(
    ObjectId id,
    String email,
    String userType, {
    String? phoneNumber,
    String? name,
    String? surname,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'userType', userType);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'surname', surname);
  }

  AppUser._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String?;
  @override
  set phoneNumber(String? value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  String get userType =>
      RealmObjectBase.get<String>(this, 'userType') as String;
  @override
  set userType(String value) => RealmObjectBase.set(this, 'userType', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get surname =>
      RealmObjectBase.get<String>(this, 'surname') as String?;
  @override
  set surname(String? value) => RealmObjectBase.set(this, 'surname', value);

  @override
  Stream<RealmObjectChanges<AppUser>> get changes =>
      RealmObjectBase.getChanges<AppUser>(this);

  @override
  Stream<RealmObjectChanges<AppUser>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppUser>(this, keyPaths);

  @override
  AppUser freeze() => RealmObjectBase.freezeObject<AppUser>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'email': email.toEJson(),
      'phoneNumber': phoneNumber.toEJson(),
      'userType': userType.toEJson(),
      'name': name.toEJson(),
      'surname': surname.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppUser value) => value.toEJson();
  static AppUser _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'email': EJsonValue email,
        'phoneNumber': EJsonValue phoneNumber,
        'userType': EJsonValue userType,
        'name': EJsonValue name,
        'surname': EJsonValue surname,
      } =>
        AppUser(
          fromEJson(id),
          fromEJson(email),
          fromEJson(userType),
          phoneNumber: fromEJson(phoneNumber),
          name: fromEJson(name),
          surname: fromEJson(surname),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppUser._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, AppUser, 'AppUser', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('userType', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('surname', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Reclamation extends _Reclamation
    with RealmEntity, RealmObjectBase, RealmObject {
  Reclamation(
    ObjectId id,
    String imageUrl, {
    String? problem,
    String? commentaire,
    String? status,
    String? color,
    bool? isOpen,
    DateTime? date,
    String? imageConfirmedUrl,
    ObjectId? userId,
    ObjectId? syndicId,
    int? satisfactionLevel,
    String? reactionComment,
    String? syndicComment,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'problem', problem);
    RealmObjectBase.set(this, 'commentaire', commentaire);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'isOpen', isOpen);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'imageConfirmedUrl', imageConfirmedUrl);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'syndicId', syndicId);
    RealmObjectBase.set(this, 'satisfactionLevel', satisfactionLevel);
    RealmObjectBase.set(this, 'reactionComment', reactionComment);
    RealmObjectBase.set(this, 'syndicComment', syndicComment);
  }

  Reclamation._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String? get problem =>
      RealmObjectBase.get<String>(this, 'problem') as String?;
  @override
  set problem(String? value) => RealmObjectBase.set(this, 'problem', value);

  @override
  String? get commentaire =>
      RealmObjectBase.get<String>(this, 'commentaire') as String?;
  @override
  set commentaire(String? value) =>
      RealmObjectBase.set(this, 'commentaire', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  bool? get isOpen => RealmObjectBase.get<bool>(this, 'isOpen') as bool?;
  @override
  set isOpen(bool? value) => RealmObjectBase.set(this, 'isOpen', value);

  @override
  DateTime? get date =>
      RealmObjectBase.get<DateTime>(this, 'date') as DateTime?;
  @override
  set date(DateTime? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get imageConfirmedUrl =>
      RealmObjectBase.get<String>(this, 'imageConfirmedUrl') as String?;
  @override
  set imageConfirmedUrl(String? value) =>
      RealmObjectBase.set(this, 'imageConfirmedUrl', value);

  @override
  ObjectId? get userId =>
      RealmObjectBase.get<ObjectId>(this, 'userId') as ObjectId?;
  @override
  set userId(ObjectId? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  ObjectId? get syndicId =>
      RealmObjectBase.get<ObjectId>(this, 'syndicId') as ObjectId?;
  @override
  set syndicId(ObjectId? value) => RealmObjectBase.set(this, 'syndicId', value);

  @override
  int? get satisfactionLevel =>
      RealmObjectBase.get<int>(this, 'satisfactionLevel') as int?;
  @override
  set satisfactionLevel(int? value) =>
      RealmObjectBase.set(this, 'satisfactionLevel', value);

  @override
  String? get reactionComment =>
      RealmObjectBase.get<String>(this, 'reactionComment') as String?;
  @override
  set reactionComment(String? value) =>
      RealmObjectBase.set(this, 'reactionComment', value);

  @override
  String? get syndicComment =>
      RealmObjectBase.get<String>(this, 'syndicComment') as String?;
  @override
  set syndicComment(String? value) =>
      RealmObjectBase.set(this, 'syndicComment', value);

  @override
  Stream<RealmObjectChanges<Reclamation>> get changes =>
      RealmObjectBase.getChanges<Reclamation>(this);

  @override
  Stream<RealmObjectChanges<Reclamation>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Reclamation>(this, keyPaths);

  @override
  Reclamation freeze() => RealmObjectBase.freezeObject<Reclamation>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'imageUrl': imageUrl.toEJson(),
      'problem': problem.toEJson(),
      'commentaire': commentaire.toEJson(),
      'status': status.toEJson(),
      'color': color.toEJson(),
      'isOpen': isOpen.toEJson(),
      'date': date.toEJson(),
      'imageConfirmedUrl': imageConfirmedUrl.toEJson(),
      'userId': userId.toEJson(),
      'syndicId': syndicId.toEJson(),
      'satisfactionLevel': satisfactionLevel.toEJson(),
      'reactionComment': reactionComment.toEJson(),
      'syndicComment': syndicComment.toEJson(),
    };
  }

  static EJsonValue _toEJson(Reclamation value) => value.toEJson();
  static Reclamation _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'imageUrl': EJsonValue imageUrl,
        'problem': EJsonValue problem,
        'commentaire': EJsonValue commentaire,
        'status': EJsonValue status,
        'color': EJsonValue color,
        'isOpen': EJsonValue isOpen,
        'date': EJsonValue date,
        'imageConfirmedUrl': EJsonValue imageConfirmedUrl,
        'userId': EJsonValue userId,
        'syndicId': EJsonValue syndicId,
        'satisfactionLevel': EJsonValue satisfactionLevel,
        'reactionComment': EJsonValue reactionComment,
        'syndicComment': EJsonValue syndicComment,
      } =>
        Reclamation(
          fromEJson(id),
          fromEJson(imageUrl),
          problem: fromEJson(problem),
          commentaire: fromEJson(commentaire),
          status: fromEJson(status),
          color: fromEJson(color),
          isOpen: fromEJson(isOpen),
          date: fromEJson(date),
          imageConfirmedUrl: fromEJson(imageConfirmedUrl),
          userId: fromEJson(userId),
          syndicId: fromEJson(syndicId),
          satisfactionLevel: fromEJson(satisfactionLevel),
          reactionComment: fromEJson(reactionComment),
          syndicComment: fromEJson(syndicComment),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Reclamation._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Reclamation, 'Reclamation', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('imageUrl', RealmPropertyType.string),
      SchemaProperty('problem', RealmPropertyType.string, optional: true),
      SchemaProperty('commentaire', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('isOpen', RealmPropertyType.bool, optional: true),
      SchemaProperty('date', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('imageConfirmedUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.objectid, optional: true),
      SchemaProperty('syndicId', RealmPropertyType.objectid, optional: true),
      SchemaProperty('satisfactionLevel', RealmPropertyType.int,
          optional: true),
      SchemaProperty('reactionComment', RealmPropertyType.string,
          optional: true),
      SchemaProperty('syndicComment', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AppNotification extends _AppNotification
    with RealmEntity, RealmObjectBase, RealmObject {
  AppNotification(
    ObjectId id,
    String title,
    String content,
    DateTime createdAt,
    bool isRead,
    ObjectId userId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'isRead', isRead);
    RealmObjectBase.set(this, 'userId', userId);
  }

  AppNotification._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  bool get isRead => RealmObjectBase.get<bool>(this, 'isRead') as bool;
  @override
  set isRead(bool value) => RealmObjectBase.set(this, 'isRead', value);

  @override
  ObjectId get userId =>
      RealmObjectBase.get<ObjectId>(this, 'userId') as ObjectId;
  @override
  set userId(ObjectId value) => RealmObjectBase.set(this, 'userId', value);

  @override
  Stream<RealmObjectChanges<AppNotification>> get changes =>
      RealmObjectBase.getChanges<AppNotification>(this);

  @override
  Stream<RealmObjectChanges<AppNotification>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppNotification>(this, keyPaths);

  @override
  AppNotification freeze() =>
      RealmObjectBase.freezeObject<AppNotification>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'title': title.toEJson(),
      'content': content.toEJson(),
      'createdAt': createdAt.toEJson(),
      'isRead': isRead.toEJson(),
      'userId': userId.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppNotification value) => value.toEJson();
  static AppNotification _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'title': EJsonValue title,
        'content': EJsonValue content,
        'createdAt': EJsonValue createdAt,
        'isRead': EJsonValue isRead,
        'userId': EJsonValue userId,
      } =>
        AppNotification(
          fromEJson(id),
          fromEJson(title),
          fromEJson(content),
          fromEJson(createdAt),
          fromEJson(isRead),
          fromEJson(userId),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppNotification._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, AppNotification, 'AppNotification', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('isRead', RealmPropertyType.bool),
      SchemaProperty('userId', RealmPropertyType.objectid),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Sponsorship extends _Sponsorship
    with RealmEntity, RealmObjectBase, RealmObject {
  Sponsorship(
    ObjectId id,
    ObjectId userId,
    String name,
    String surname,
    String phoneNumber,
    String email,
    DateTime createdAt, {
    String? comment,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'surname', surname);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'comment', comment);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  Sponsorship._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  ObjectId get userId =>
      RealmObjectBase.get<ObjectId>(this, 'userId') as ObjectId;
  @override
  set userId(ObjectId value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get surname => RealmObjectBase.get<String>(this, 'surname') as String;
  @override
  set surname(String value) => RealmObjectBase.set(this, 'surname', value);

  @override
  String get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get comment =>
      RealmObjectBase.get<String>(this, 'comment') as String?;
  @override
  set comment(String? value) => RealmObjectBase.set(this, 'comment', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<Sponsorship>> get changes =>
      RealmObjectBase.getChanges<Sponsorship>(this);

  @override
  Stream<RealmObjectChanges<Sponsorship>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Sponsorship>(this, keyPaths);

  @override
  Sponsorship freeze() => RealmObjectBase.freezeObject<Sponsorship>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'userId': userId.toEJson(),
      'name': name.toEJson(),
      'surname': surname.toEJson(),
      'phoneNumber': phoneNumber.toEJson(),
      'email': email.toEJson(),
      'comment': comment.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Sponsorship value) => value.toEJson();
  static Sponsorship _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'userId': EJsonValue userId,
        'name': EJsonValue name,
        'surname': EJsonValue surname,
        'phoneNumber': EJsonValue phoneNumber,
        'email': EJsonValue email,
        'comment': EJsonValue comment,
        'createdAt': EJsonValue createdAt,
      } =>
        Sponsorship(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(name),
          fromEJson(surname),
          fromEJson(phoneNumber),
          fromEJson(email),
          fromEJson(createdAt),
          comment: fromEJson(comment),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Sponsorship._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Sponsorship, 'Sponsorship', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.objectid),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('surname', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('comment', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AccessRequest extends _AccessRequest
    with RealmEntity, RealmObjectBase, RealmObject {
  AccessRequest(
    ObjectId id,
    String name,
    String surname,
    String phoneNumber,
    String email,
    String reason,
    DateTime createdAt,
    String status,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'surname', surname);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'reason', reason);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'status', status);
  }

  AccessRequest._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get surname => RealmObjectBase.get<String>(this, 'surname') as String;
  @override
  set surname(String value) => RealmObjectBase.set(this, 'surname', value);

  @override
  String get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get reason => RealmObjectBase.get<String>(this, 'reason') as String;
  @override
  set reason(String value) => RealmObjectBase.set(this, 'reason', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<AccessRequest>> get changes =>
      RealmObjectBase.getChanges<AccessRequest>(this);

  @override
  Stream<RealmObjectChanges<AccessRequest>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AccessRequest>(this, keyPaths);

  @override
  AccessRequest freeze() => RealmObjectBase.freezeObject<AccessRequest>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'surname': surname.toEJson(),
      'phoneNumber': phoneNumber.toEJson(),
      'email': email.toEJson(),
      'reason': reason.toEJson(),
      'createdAt': createdAt.toEJson(),
      'status': status.toEJson(),
    };
  }

  static EJsonValue _toEJson(AccessRequest value) => value.toEJson();
  static AccessRequest _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'surname': EJsonValue surname,
        'phoneNumber': EJsonValue phoneNumber,
        'email': EJsonValue email,
        'reason': EJsonValue reason,
        'createdAt': EJsonValue createdAt,
        'status': EJsonValue status,
      } =>
        AccessRequest(
          fromEJson(id),
          fromEJson(name),
          fromEJson(surname),
          fromEJson(phoneNumber),
          fromEJson(email),
          fromEJson(reason),
          fromEJson(createdAt),
          fromEJson(status),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AccessRequest._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, AccessRequest, 'AccessRequest', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('surname', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('reason', RealmPropertyType.string),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('status', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
