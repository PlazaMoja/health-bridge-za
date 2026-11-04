part of 'generated.dart';

class InsertMedicationOrderItemVariablesBuilder {
  String orderId;
  String medicationId;
  String name;
  int quantity;
  double unitPrice;
  double lineTotal;

  final FirebaseDataConnect _dataConnect;
  InsertMedicationOrderItemVariablesBuilder(this._dataConnect, {required  this.orderId,required  this.medicationId,required  this.name,required  this.quantity,required  this.unitPrice,required  this.lineTotal,});
  Deserializer<InsertMedicationOrderItemData> dataDeserializer = (dynamic json)  => InsertMedicationOrderItemData.fromJson(jsonDecode(json));
  Serializer<InsertMedicationOrderItemVariables> varsSerializer = (InsertMedicationOrderItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMedicationOrderItemData, InsertMedicationOrderItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMedicationOrderItemData, InsertMedicationOrderItemVariables> ref() {
    InsertMedicationOrderItemVariables vars= InsertMedicationOrderItemVariables(orderId: orderId,medicationId: medicationId,name: name,quantity: quantity,unitPrice: unitPrice,lineTotal: lineTotal,);
    return _dataConnect.mutation("InsertMedicationOrderItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMedicationOrderItemMedicationOrderItemInsert {
  final String id;
  InsertMedicationOrderItemMedicationOrderItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderItemMedicationOrderItemInsert otherTyped = other as InsertMedicationOrderItemMedicationOrderItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMedicationOrderItemMedicationOrderItemInsert({
    required this.id,
  });
}

@immutable
class InsertMedicationOrderItemData {
  final InsertMedicationOrderItemMedicationOrderItemInsert medicationOrderItem_insert;
  InsertMedicationOrderItemData.fromJson(dynamic json):
  
  medicationOrderItem_insert = InsertMedicationOrderItemMedicationOrderItemInsert.fromJson(json['medicationOrderItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderItemData otherTyped = other as InsertMedicationOrderItemData;
    return medicationOrderItem_insert == otherTyped.medicationOrderItem_insert;
    
  }
  @override
  int get hashCode => medicationOrderItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medicationOrderItem_insert'] = medicationOrderItem_insert.toJson();
    return json;
  }

  InsertMedicationOrderItemData({
    required this.medicationOrderItem_insert,
  });
}

@immutable
class InsertMedicationOrderItemVariables {
  final String orderId;
  final String medicationId;
  final String name;
  final int quantity;
  final double unitPrice;
  final double lineTotal;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMedicationOrderItemVariables.fromJson(Map<String, dynamic> json):
  
  orderId = nativeFromJson<String>(json['orderId']),
  medicationId = nativeFromJson<String>(json['medicationId']),
  name = nativeFromJson<String>(json['name']),
  quantity = nativeFromJson<int>(json['quantity']),
  unitPrice = nativeFromJson<double>(json['unitPrice']),
  lineTotal = nativeFromJson<double>(json['lineTotal']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMedicationOrderItemVariables otherTyped = other as InsertMedicationOrderItemVariables;
    return orderId == otherTyped.orderId && 
    medicationId == otherTyped.medicationId && 
    name == otherTyped.name && 
    quantity == otherTyped.quantity && 
    unitPrice == otherTyped.unitPrice && 
    lineTotal == otherTyped.lineTotal;
    
  }
  @override
  int get hashCode => Object.hashAll([orderId.hashCode, medicationId.hashCode, name.hashCode, quantity.hashCode, unitPrice.hashCode, lineTotal.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['orderId'] = nativeToJson<String>(orderId);
    json['medicationId'] = nativeToJson<String>(medicationId);
    json['name'] = nativeToJson<String>(name);
    json['quantity'] = nativeToJson<int>(quantity);
    json['unitPrice'] = nativeToJson<double>(unitPrice);
    json['lineTotal'] = nativeToJson<double>(lineTotal);
    return json;
  }

  InsertMedicationOrderItemVariables({
    required this.orderId,
    required this.medicationId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });
}

