part of 'generated.dart';

class CancelMedicationOrderVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  CancelMedicationOrderVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<CancelMedicationOrderData> dataDeserializer = (dynamic json)  => CancelMedicationOrderData.fromJson(jsonDecode(json));
  Serializer<CancelMedicationOrderVariables> varsSerializer = (CancelMedicationOrderVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CancelMedicationOrderData, CancelMedicationOrderVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CancelMedicationOrderData, CancelMedicationOrderVariables> ref() {
    CancelMedicationOrderVariables vars= CancelMedicationOrderVariables(id: id,);
    return _dataConnect.mutation("CancelMedicationOrder", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CancelMedicationOrderMedicationOrderUpdate {
  final String id;
  CancelMedicationOrderMedicationOrderUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelMedicationOrderMedicationOrderUpdate otherTyped = other as CancelMedicationOrderMedicationOrderUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelMedicationOrderMedicationOrderUpdate({
    required this.id,
  });
}

@immutable
class CancelMedicationOrderData {
  final CancelMedicationOrderMedicationOrderUpdate? medicationOrder_update;
  CancelMedicationOrderData.fromJson(dynamic json):
  
  medicationOrder_update = json['medicationOrder_update'] == null ? null : CancelMedicationOrderMedicationOrderUpdate.fromJson(json['medicationOrder_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelMedicationOrderData otherTyped = other as CancelMedicationOrderData;
    return medicationOrder_update == otherTyped.medicationOrder_update;
    
  }
  @override
  int get hashCode => medicationOrder_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (medicationOrder_update != null) {
      json['medicationOrder_update'] = medicationOrder_update!.toJson();
    }
    return json;
  }

  CancelMedicationOrderData({
    this.medicationOrder_update,
  });
}

@immutable
class CancelMedicationOrderVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CancelMedicationOrderVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CancelMedicationOrderVariables otherTyped = other as CancelMedicationOrderVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CancelMedicationOrderVariables({
    required this.id,
  });
}

