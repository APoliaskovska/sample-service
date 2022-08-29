// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_doc.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class UploadDoc extends _UploadDoc with RealmEntity, RealmObject {
  UploadDoc(
    String title, {
    String? docType,
    String? laptopId,
    Iterable<int> file = const [],
  }) {
    RealmObject.set(this, 'title', title);
    RealmObject.set(this, 'docType', docType);
    RealmObject.set(this, 'laptopId', laptopId);
    RealmObject.set<RealmList<int>>(this, 'file', RealmList<int>(file));
  }

  UploadDoc._();

  @override
  String get title => RealmObject.get<String>(this, 'title') as String;
  @override
  set title(String value) => throw RealmUnsupportedSetError();

  @override
  String? get docType => RealmObject.get<String>(this, 'docType') as String?;
  @override
  set docType(String? value) => RealmObject.set(this, 'docType', value);

  @override
  String? get laptopId => RealmObject.get<String>(this, 'laptopId') as String?;
  @override
  set laptopId(String? value) => RealmObject.set(this, 'laptopId', value);

  @override
  RealmList<int> get file =>
      RealmObject.get<int>(this, 'file') as RealmList<int>;
  @override
  set file(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<UploadDoc>> get changes =>
      RealmObject.getChanges<UploadDoc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(UploadDoc._);
    return const SchemaObject(UploadDoc, 'UploadDoc', [
      SchemaProperty('title', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('docType', RealmPropertyType.string, optional: true),
      SchemaProperty('laptopId', RealmPropertyType.string, optional: true),
      SchemaProperty('file', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
