part of 'generated.dart';

class InsertMedicationOrderVariablesBuilder {
  String patientId;
  String fulfilment;
  Optional<String> _clinicId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _deliveryAddress = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _notes = Optional.optional(nativeFromJson, nativeToJson);
  double subtotal;
  double deliveryFee;
  double total;

  final FirebaseDataConnect _dataConnect;  InsertMedicationOrderVariablesBuilder clinicId(String? t) {
   _clinicId.value = t;
   return this;
  }
  InsertMedicationOrderVariablesBuilder deliveryAddress(String? t) {
   _deliveryAddress.value = t;
   return this;
  }
  InsertMedicationOrderVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  InsertMedicationOrderVariablesBuilder(this._dataConnect, {required  this.patientId,required  this.fulfilment,required  this.subtotal,required  this.deliveryFee,required  this.total,});
  Deserializer<InsertMedicationOrderData> dataDeserializer = (dynamic json)  => InsertMedicationOrderData.fromJson(jsonDecode(json));
  Serializer<InsertMedicationOrderVariables> varsSerializer = (InsertMedicationOrderVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMedicationOrderData, InsertMedicationOrderVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMedicationOrderData, InsertMedicationOrderVariables> ref() {
    InsertMedicationOrderVariables vars= InsertMedicationOrderVariables(patientId: patientId,fulfilment: fulfilment,clinicId: _clinicId,deliveryAddress: _deliveryAddress,notes: _notes,subtotal: subtotal,deliveryFee: deliveryFee,total: total,);
    return _dataConnect.mutation("InsertMedicationOrder", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMedicationOrderMedicationOrderInsert {
  final String id;
  InsertMedicationOrderMedicationOrderInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderMedicationOrderInsert otherTyped = other as InsertMedicationOrderMedicationOrderInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMedicationOrderMedicationOrderInsert({
    required this.id,
  });
}

@immutable
class InsertMedicationOrderData {
  final InsertMedicationOrderMedicationOrderInsert medicationOrder_insert;
  InsertMedicationOrderData.fromJson(dynamic json):
  
  medicationOrder_insert = InsertMedicationOrderMedicationOrderInsert.fromJson(json['medicationOrder_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderData otherTyped = other as InsertMedicationOrderData;
    return medicationOrder_insert == otherTyped.medicationOrder_insert;
    
  }
  @override
  int get hashCode => medicationOrder_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medicationOrder_insert'] = medicationOrder_insert.toJson();
    return json;
  }

  InsertMedicationOrderData({
    required this.medicationOrder_insert,
  });
}

@immutable
class InsertMedicationOrderVariables {
  final String patientId;
  final String fulfilment;
  late final Optional<String>clinicId;
  late final Optional<String>deliveryAddress;
  late final Optional<String>notes;
  final double subtotal;
  final double deliveryFee;
  final double total;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMedicationOrderVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']),
  fulfilment = nativeFromJson<String>(json['fulfilment']),
  subtotal = nativeFromJson<double>(json['subtotal']),
  deliveryFee = nativeFromJson<double>(json['deliveryFee']),
  total = nativeFromJson<double>(json['total']) {
  
  
  
  
    clinicId = Optional.optional(nativeFromJson, nativeToJson);
    clinicId.value = json['clinicId'] == null ? null : nativeFromJson<String>(json['clinicId']);
  
  
    deliveryAddress = Optional.optional(nativeFromJson, nativeToJson);
    deliveryAddress.value = json['deliveryAddress'] == null ? null : nativeFromJson<String>(json['deliveryAddress']);
  
  
    notes = Optional.optional(nativeFromJson, nativeToJson);
    notes.value = json['notes'] == null ? null : nativeFromJson<String>(json['notes']);
  
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderVariables otherTyped = other as InsertMedicationOrderVariables;
    return patientId == otherTyped.patientId && 
    fulfilment == otherTyped.fulfilment && 
    clinicId == otherTyped.clinicId && 
    deliveryAddress == otherTyped.deliveryAddress && 
    notes == otherTyped.notes && 
    subtotal == otherTyped.subtotal && 
    deliveryFee == otherTyped.deliveryFee && 
    total == otherTyped.total;
    
  }
  @override
  int get hashCode => Object.hashAll([patientId.hashCode, fulfilment.hashCode, clinicId.hashCode, deliveryAddress.hashCode, notes.hashCode, subtotal.hashCode, deliveryFee.hashCode, total.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    json['fulfilment'] = nativeToJson<String>(fulfilment);
    if(clinicId.state == OptionalState.set) {
      json['clinicId'] = clinicId.toJson();
    }
    if(deliveryAddress.state == OptionalState.set) {
      json['deliveryAddress'] = deliveryAddress.toJson();
    }
    if(notes.state == OptionalState.set) {
      json['notes'] = notes.toJson();
    }
    json['subtotal'] = nativeToJson<double>(subtotal);
    json['deliveryFee'] = nativeToJson<double>(deliveryFee);
    json['total'] = nativeToJson<double>(total);
    return json;
  }

  InsertMedicationOrderVariables({
    required this.patientId,
    required this.fulfilment,
    required this.clinicId,
    required this.deliveryAddress,
    required this.notes,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });
}

