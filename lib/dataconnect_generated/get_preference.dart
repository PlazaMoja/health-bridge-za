part of 'generated.dart';

class GetPreferenceVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetPreferenceVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetPreferenceData> dataDeserializer = (dynamic json)  => GetPreferenceData.fromJson(jsonDecode(json));
  Serializer<GetPreferenceVariables> varsSerializer = (GetPreferenceVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetPreferenceData, GetPreferenceVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPreferenceData, GetPreferenceVariables> ref() {
    GetPreferenceVariables vars= GetPreferenceVariables(userId: userId,);
    return _dataConnect.query("GetPreference", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetPreferencePreference {
  final String id;
  final String? themeMode;
  final String? textSize;
  final bool? appointmentReminders;
  final String? reminderTime;
  final bool? medicationReminders;
  final bool? healthTips;
  final bool? promotions;
  final bool? shareDataForResearch;
  GetPreferencePreference.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  themeMode = json['themeMode'] == null ? null : nativeFromJson<String>(json['themeMode']),
  textSize = json['textSize'] == null ? null : nativeFromJson<String>(json['textSize']),
  appointmentReminders = json['appointmentReminders'] == null ? null : nativeFromJson<bool>(json['appointmentReminders']),
  reminderTime = json['reminderTime'] == null ? null : nativeFromJson<String>(json['reminderTime']),
  medicationReminders = json['medicationReminders'] == null ? null : nativeFromJson<bool>(json['medicationReminders']),
  healthTips = json['healthTips'] == null ? null : nativeFromJson<bool>(json['healthTips']),
  promotions = json['promotions'] == null ? null : nativeFromJson<bool>(json['promotions']),
  shareDataForResearch = json['shareDataForResearch'] == null ? null : nativeFromJson<bool>(json['shareDataForResearch']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPreferencePreference otherTyped = other as GetPreferencePreference;
    return id == otherTyped.id && 
    themeMode == otherTyped.themeMode && 
    textSize == otherTyped.textSize && 
    appointmentReminders == otherTyped.appointmentReminders && 
    reminderTime == otherTyped.reminderTime && 
    medicationReminders == otherTyped.medicationReminders && 
    healthTips == otherTyped.healthTips && 
    promotions == otherTyped.promotions && 
    shareDataForResearch == otherTyped.shareDataForResearch;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, themeMode.hashCode, textSize.hashCode, appointmentReminders.hashCode, reminderTime.hashCode, medicationReminders.hashCode, healthTips.hashCode, promotions.hashCode, shareDataForResearch.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (themeMode != null) {
      json['themeMode'] = nativeToJson<String?>(themeMode);
    }
    if (textSize != null) {
      json['textSize'] = nativeToJson<String?>(textSize);
    }
    if (appointmentReminders != null) {
      json['appointmentReminders'] = nativeToJson<bool?>(appointmentReminders);
    }
    if (reminderTime != null) {
      json['reminderTime'] = nativeToJson<String?>(reminderTime);
    }
    if (medicationReminders != null) {
      json['medicationReminders'] = nativeToJson<bool?>(medicationReminders);
    }
    if (healthTips != null) {
      json['healthTips'] = nativeToJson<bool?>(healthTips);
    }
    if (promotions != null) {
      json['promotions'] = nativeToJson<bool?>(promotions);
    }
    if (shareDataForResearch != null) {
      json['shareDataForResearch'] = nativeToJson<bool?>(shareDataForResearch);
    }
    return json;
  }

  GetPreferencePreference({
    required this.id,
    this.themeMode,
    this.textSize,
    this.appointmentReminders,
    this.reminderTime,
    this.medicationReminders,
    this.healthTips,
    this.promotions,
    this.shareDataForResearch,
  });
}

@immutable
class GetPreferenceData {
  final GetPreferencePreference? preference;
  GetPreferenceData.fromJson(dynamic json):
  
  preference = json['preference'] == null ? null : GetPreferencePreference.fromJson(json['preference']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPreferenceData otherTyped = other as GetPreferenceData;
    return preference == otherTyped.preference;
    
  }
  @override
  int get hashCode => preference.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (preference != null) {
      json['preference'] = preference!.toJson();
    }
    return json;
  }

  GetPreferenceData({
    this.preference,
  });
}

@immutable
class GetPreferenceVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetPreferenceVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPreferenceVariables otherTyped = other as GetPreferenceVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetPreferenceVariables({
    required this.userId,
  });
}

