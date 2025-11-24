// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gyges_logger_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class GLLoggerItem extends _GLLoggerItem
    with RealmEntity, RealmObjectBase, RealmObject {
  GLLoggerItem(
    int id,
    String ts,
    String log,
    String userInfo,
    String deviceInfo,
    int status,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'ts', ts);
    RealmObjectBase.set(this, 'log', log);
    RealmObjectBase.set(this, 'userInfo', userInfo);
    RealmObjectBase.set(this, 'deviceInfo', deviceInfo);
    RealmObjectBase.set(this, 'status', status);
  }

  GLLoggerItem._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get ts => RealmObjectBase.get<String>(this, 'ts') as String;
  @override
  set ts(String value) => RealmObjectBase.set(this, 'ts', value);

  @override
  String get log => RealmObjectBase.get<String>(this, 'log') as String;
  @override
  set log(String value) => RealmObjectBase.set(this, 'log', value);

  @override
  String get userInfo =>
      RealmObjectBase.get<String>(this, 'userInfo') as String;
  @override
  set userInfo(String value) => RealmObjectBase.set(this, 'userInfo', value);

  @override
  String get deviceInfo =>
      RealmObjectBase.get<String>(this, 'deviceInfo') as String;
  @override
  set deviceInfo(String value) =>
      RealmObjectBase.set(this, 'deviceInfo', value);

  @override
  int get status => RealmObjectBase.get<int>(this, 'status') as int;
  @override
  set status(int value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<GLLoggerItem>> get changes =>
      RealmObjectBase.getChanges<GLLoggerItem>(this);

  @override
  Stream<RealmObjectChanges<GLLoggerItem>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<GLLoggerItem>(this, keyPaths);

  @override
  GLLoggerItem freeze() => RealmObjectBase.freezeObject<GLLoggerItem>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'ts': ts.toEJson(),
      'log': log.toEJson(),
      'userInfo': userInfo.toEJson(),
      'deviceInfo': deviceInfo.toEJson(),
      'status': status.toEJson(),
    };
  }

  static EJsonValue _toEJson(GLLoggerItem value) => value.toEJson();
  static GLLoggerItem _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'ts': EJsonValue ts,
        'log': EJsonValue log,
        'userInfo': EJsonValue userInfo,
        'deviceInfo': EJsonValue deviceInfo,
        'status': EJsonValue status,
      } =>
        GLLoggerItem(
          fromEJson(id),
          fromEJson(ts),
          fromEJson(log),
          fromEJson(userInfo),
          fromEJson(deviceInfo),
          fromEJson(status),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(GLLoggerItem._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, GLLoggerItem, 'GLLoggerItem', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('ts', RealmPropertyType.string),
      SchemaProperty('log', RealmPropertyType.string),
      SchemaProperty('userInfo', RealmPropertyType.string),
      SchemaProperty('deviceInfo', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
