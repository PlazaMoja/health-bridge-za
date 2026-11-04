part of 'generated.dart';

class InsertPreferenceVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  InsertPreferenceVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<InsertPreferenceData> dataDeserializer = (dynamic json)  => InsertPreferenceData.fromJson(jsonDecode(json));
  Serializer<InsertPreferenceVariables> varsSerializer = (InsertPreferenceVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertPreferenceData, InsertPreferenceVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertPreferenceData, InsertPreferenceVariables> ref() {
    InsertPreferenceVariables vars= InsertPreferenceVariables(userId: userId,);
    return _dataConnect.mutation("InsertPreference", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertPreferencePreferenceInsert {
  final String id;
  InsertPreferencePreferenceInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPreferencePreferenceInsert otherTyped = other as InsertPreferencePreferenceInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertPreferencePreferenceInsert({
    required this.id,
  });
}

@immutable
class InsertPreferenceData {
  final InsertPreferencePreferenceInsert preference_insert;
  InsertPreferenceData.fromJson(dynamic json):
  
  preference_insert = InsertPreferencePreferenceInsert.fromJson(json['preference_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPreferenceData otherTyped = other as InsertPreferenceData;
    return preference_insert == otherTyped.preference_insert;
    
  }
  @override
  int get hashCode => preference_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['preference_insert'] = preference_insert.toJson();
    return json;
  }

  InsertPreferenceData({
    required this.preference_insert,
  });
}

@immutable
class InsertPreferenceVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertPreferenceVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPreferenceVariables otherTyped = other as InsertPreferenceVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  InsertPreferenceVariables({
    required this.userId,
  });
}

