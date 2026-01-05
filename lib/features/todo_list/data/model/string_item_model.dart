import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
class StringItemModel extends ParseObject implements ParseCloneable {
  StringItemModel({required String value}) : super(_keyTableName) {
    this.value = value;
  }
  StringItemModel.clone() : this(value: "");

  @override
  clone(Map map) =>
      StringItemModel.clone()..fromJson(Map<String, dynamic>.from(map));

  static const String _keyTableName = "Tasks";
  static const String keyName = "value";

  String get value => get<String>(keyName) ?? "";
  set value(String value) => set<String>(keyName, value);

  String get id => objectId ?? "";
}
