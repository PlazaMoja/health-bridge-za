part of 'generated.dart';

class UpdateAppointmentVariablesBuilder {
  String id;
  Optional<String> _status = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _reason = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _cancellationReason = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateAppointmentVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }
  UpdateAppointmentVariablesBuilder reason(String? t) {
   _reason.value = t;
   return this;
  }
  UpdateAppointmentVariablesBuilder cancellationReason(String? t) {
   _cancellationReason.value = t;
   return this;
  }

  UpdateAppointmentVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateAppointmentData> dataDeserializer = (dynamic json)  => UpdateAppointmentData.fromJson(jsonDecode(json));
  Serializer<UpdateAppointmentVariables> varsSerializer = (UpdateAppointmentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateAppointmentData, UpdateAppointmentVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateAppointmentData, UpdateAppointmentVariables> ref() {
    UpdateAppointmentVariables vars= UpdateAppointmentVariables(id: id,status: _status,reason: _reason,cancellationReason: _cancellationReason,);
    return _dataConnect.mutation("UpdateAppointment", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateAppointmentAppointmentUpdate {
  final String id;
  UpdateAppointmentAppointmentUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAppointmentAppointmentUpdate otherTyped = other as UpdateAppointmentAppointmentUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateAppointmentAppointmentUpdate({
    required this.id,
  });
}

@immutable
class UpdateAppointmentData {
  final UpdateAppointmentAppointmentUpdate? appointment_update;
  UpdateAppointmentData.fromJson(dynamic json):
  
  appointment_update = json['appointment_update'] == null ? null : UpdateAppointmentAppointmentUpdate.fromJson(json['appointment_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAppointmentData otherTyped = other as UpdateAppointmentData;
    return appointment_update == otherTyped.appointment_update;
    
  }
  @override
  int get hashCode => appointment_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (appointment_update != null) {
      json['appointment_update'] = appointment_update!.toJson();
    }
    return json;
  }

  UpdateAppointmentData({
    this.appointment_update,
  });
}

@immutable
class UpdateAppointmentVariables {
  final String id;
  late final Optional<String>status;
  late final Optional<String>reason;
  late final Optional<String>cancellationReason;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateAppointmentVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    status = Optional.optional(nativeFromJson, nativeToJson);
    status.value = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  
  
    reason = Optional.optional(nativeFromJson, nativeToJson);
    reason.value = json['reason'] == null ? null : nativeFromJson<String>(json['reason']);
  
  
    cancellationReason = Optional.optional(nativeFromJson, nativeToJson);
    cancellationReason.value = json['cancellationReason'] == null ? null : nativeFromJson<String>(json['cancellationReason']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAppointmentVariables otherTyped = other as UpdateAppointmentVariables;
    return id == otherTyped.id && 
    status == otherTyped.status && 
    reason == otherTyped.reason && 
    cancellationReason == otherTyped.cancellationReason;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode, reason.hashCode, cancellationReason.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    if(reason.state == OptionalState.set) {
      json['reason'] = reason.toJson();
    }
    if(cancellationReason.state == OptionalState.set) {
      json['cancellationReason'] = cancellationReason.toJson();
    }
    return json;
  }

  UpdateAppointmentVariables({
    required this.id,
    required this.status,
    required this.reason,
    required this.cancellationReason,
  });
}

