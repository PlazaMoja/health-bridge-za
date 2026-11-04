part of 'generated.dart';

class UpdatePreferenceVariablesBuilder {
  String id;
  Optional<String> _themeMode = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _textSize = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _appointmentReminders = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _reminderTime = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _medicationReminders = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _healthTips = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _promotions = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _shareDataForResearch = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdatePreferenceVariablesBuilder themeMode(String? t) {
   _themeMode.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder textSize(String? t) {
   _textSize.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder appointmentReminders(bool? t) {
   _appointmentReminders.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder reminderTime(String? t) {
   _reminderTime.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder medicationReminders(bool? t) {
   _medicationReminders.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder healthTips(bool? t) {
   _healthTips.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder promotions(bool? t) {
   _promotions.value = t;
   return this;
  }
  UpdatePreferenceVariablesBuilder shareDataForResearch(bool? t) {
   _shareDataForResearch.value = t;
   return this;
  }

  UpdatePreferenceVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdatePreferenceData> dataDeserializer = (dynamic json)  => UpdatePreferenceData.fromJson(jsonDecode(json));
  Serializer<UpdatePreferenceVariables> varsSerializer = (UpdatePreferenceVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdatePreferenceData, UpdatePreferenceVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdatePreferenceData, UpdatePreferenceVariables> ref() {
    UpdatePreferenceVariables vars= UpdatePreferenceVariables(id: id,themeMode: _themeMode,textSize: _textSize,appointmentReminders: _appointmentReminders,reminderTime: _reminderTime,medicationReminders: _medicationReminders,healthTips: _healthTips,promotions: _promotions,shareDataForResearch: _shareDataForResearch,);
    return _dataConnect.mutation("UpdatePreference", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdatePreferencePreferenceUpdate {
  final String id;
  UpdatePreferencePreferenceUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePreferencePreferenceUpdate otherTyped = other as UpdatePreferencePreferenceUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdatePreferencePreferenceUpdate({
    required this.id,
  });
}

@immutable
class UpdatePreferenceData {
  final UpdatePreferencePreferenceUpdate? preference_update;
  UpdatePreferenceData.fromJson(dynamic json):
  
  preference_update = json['preference_update'] == null ? null : UpdatePreferencePreferenceUpdate.fromJson(json['preference_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePreferenceData otherTyped = other as UpdatePreferenceData;
    return preference_update == otherTyped.preference_update;
    
  }
  @override
  int get hashCode => preference_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (preference_update != null) {
      json['preference_update'] = preference_update!.toJson();
    }
    return json;
  }

  UpdatePreferenceData({
    this.preference_update,
  });
}

@immutable
class UpdatePreferenceVariables {
  final String id;
  late final Optional<String>themeMode;
  late final Optional<String>textSize;
  late final Optional<bool>appointmentReminders;
  late final Optional<String>reminderTime;
  late final Optional<bool>medicationReminders;
  late final Optional<bool>healthTips;
  late final Optional<bool>promotions;
  late final Optional<bool>shareDataForResearch;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdatePreferenceVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    themeMode = Optional.optional(nativeFromJson, nativeToJson);
    themeMode.value = json['themeMode'] == null ? null : nativeFromJson<String>(json['themeMode']);
  
  
    textSize = Optional.optional(nativeFromJson, nativeToJson);
    textSize.value = json['textSize'] == null ? null : nativeFromJson<String>(json['textSize']);
  
  
    appointmentReminders = Optional.optional(nativeFromJson, nativeToJson);
    appointmentReminders.value = json['appointmentReminders'] == null ? null : nativeFromJson<bool>(json['appointmentReminders']);
  
  
    reminderTime = Optional.optional(nativeFromJson, nativeToJson);
    reminderTime.value = json['reminderTime'] == null ? null : nativeFromJson<String>(json['reminderTime']);
  
  
    medicationReminders = Optional.optional(nativeFromJson, nativeToJson);
    medicationReminders.value = json['medicationReminders'] == null ? null : nativeFromJson<bool>(json['medicationReminders']);
  
  
    healthTips = Optional.optional(nativeFromJson, nativeToJson);
    healthTips.value = json['healthTips'] == null ? null : nativeFromJson<bool>(json['healthTips']);
  
  
    promotions = Optional.optional(nativeFromJson, nativeToJson);
    promotions.value = json['promotions'] == null ? null : nativeFromJson<bool>(json['promotions']);
  
  
    shareDataForResearch = Optional.optional(nativeFromJson, nativeToJson);
    shareDataForResearch.value = json['shareDataForResearch'] == null ? null : nativeFromJson<bool>(json['shareDataForResearch']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePreferenceVariables otherTyped = other as UpdatePreferenceVariables;
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
    if(themeMode.state == OptionalState.set) {
      json['themeMode'] = themeMode.toJson();
    }
    if(textSize.state == OptionalState.set) {
      json['textSize'] = textSize.toJson();
    }
    if(appointmentReminders.state == OptionalState.set) {
      json['appointmentReminders'] = appointmentReminders.toJson();
    }
    if(reminderTime.state == OptionalState.set) {
      json['reminderTime'] = reminderTime.toJson();
    }
    if(medicationReminders.state == OptionalState.set) {
      json['medicationReminders'] = medicationReminders.toJson();
    }
    if(healthTips.state == OptionalState.set) {
      json['healthTips'] = healthTips.toJson();
    }
    if(promotions.state == OptionalState.set) {
      json['promotions'] = promotions.toJson();
    }
    if(shareDataForResearch.state == OptionalState.set) {
      json['shareDataForResearch'] = shareDataForResearch.toJson();
    }
    return json;
  }

  UpdatePreferenceVariables({
    required this.id,
    required this.themeMode,
    required this.textSize,
    required this.appointmentReminders,
    required this.reminderTime,
    required this.medicationReminders,
    required this.healthTips,
    required this.promotions,
    required this.shareDataForResearch,
  });
}

