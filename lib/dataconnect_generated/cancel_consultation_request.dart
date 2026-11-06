part of 'generated.dart';

class CancelConsultationRequestVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  CancelConsultationRequestVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<CancelConsultationRequestData> dataDeserializer = (dynamic json)  => CancelConsultationRequestData.fromJson(jsonDecode(json));
  Serializer<CancelConsultationRequestVariables> varsSerializer = (CancelConsultationRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CancelConsultationRequestData, CancelConsultationRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CancelConsultationRequestData, CancelConsultationRequestVariables> ref() {
    CancelConsultationRequestVariables vars= CancelConsultationRequestVariables(id: id,);
    return _dataConnect.mutation("CancelConsultationRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CancelConsultationRequestConsultationRequestUpdate {
  final String id;
  CancelConsultationRequestConsultationRequestUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelConsultationRequestConsultationRequestUpdate otherTyped = other as CancelConsultationRequestConsultationRequestUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelConsultationRequestConsultationRequestUpdate({
    required this.id,
  });
}

@immutable
class CancelConsultationRequestData {
  final CancelConsultationRequestConsultationRequestUpdate? consultationRequest_update;
  CancelConsultationRequestData.fromJson(dynamic json):
  
  consultationRequest_update = json['consultationRequest_update'] == null ? null : CancelConsultationRequestConsultationRequestUpdate.fromJson(json['consultationRequest_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelConsultationRequestData otherTyped = other as CancelConsultationRequestData;
    return consultationRequest_update == otherTyped.consultationRequest_update;
    
  }
  @override
  int get hashCode => consultationRequest_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (consultationRequest_update != null) {
      json['consultationRequest_update'] = consultationRequest_update!.toJson();
    }
    return json;
  }

  CancelConsultationRequestData({
    this.consultationRequest_update,
  });
}

@immutable
class CancelConsultationRequestVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CancelConsultationRequestVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelConsultationRequestVariables otherTyped = other as CancelConsultationRequestVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelConsultationRequestVariables({
    required this.id,
  });
}

