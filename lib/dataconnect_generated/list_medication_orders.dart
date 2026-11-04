part of 'generated.dart';

class ListMedicationOrdersVariablesBuilder {
  String patientId;

  final FirebaseDataConnect _dataConnect;
  ListMedicationOrdersVariablesBuilder(this._dataConnect, {required  this.patientId,});
  Deserializer<ListMedicationOrdersData> dataDeserializer = (dynamic json)  => ListMedicationOrdersData.fromJson(jsonDecode(json));
  Serializer<ListMedicationOrdersVariables> varsSerializer = (ListMedicationOrdersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListMedicationOrdersData, ListMedicationOrdersVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMedicationOrdersData, ListMedicationOrdersVariables> ref() {
    ListMedicationOrdersVariables vars= ListMedicationOrdersVariables(patientId: patientId,);
    return _dataConnect.query("ListMedicationOrders", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListMedicationOrdersMedicationOrders {
  final String id;
  final String fulfilment;
  final String? deliveryAddress;
  final String? notes;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String status;
  final Timestamp? createdAt;
  final ListMedicationOrdersMedicationOrdersClinic? clinic;
  final List<ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder> medicationOrderItems_on_order;
  ListMedicationOrdersMedicationOrders.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  fulfilment = nativeFromJson<String>(json['fulfilment']),
  deliveryAddress = json['deliveryAddress'] == null ? null : nativeFromJson<String>(json['deliveryAddress']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  subtotal = nativeFromJson<double>(json['subtotal']),
  deliveryFee = nativeFromJson<double>(json['deliveryFee']),
  total = nativeFromJson<double>(json['total']),
  status = nativeFromJson<String>(json['status']),
  createdAt = json['createdAt'] == null ? null : Timestamp.fromJson(json['createdAt']),
  clinic = json['clinic'] == null ? null : ListMedicationOrdersMedicationOrdersClinic.fromJson(json['clinic']),
  medicationOrderItems_on_order = (json['medicationOrderItems_on_order'] as List<dynamic>)
        .map((e) => ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationOrdersMedicationOrders otherTyped = other as ListMedicationOrdersMedicationOrders;
    return id == otherTyped.id && 
    fulfilment == otherTyped.fulfilment && 
    deliveryAddress == otherTyped.deliveryAddress && 
    notes == otherTyped.notes && 
    subtotal == otherTyped.subtotal && 
    deliveryFee == otherTyped.deliveryFee && 
    total == otherTyped.total && 
    status == otherTyped.status && 
    createdAt == otherTyped.createdAt && 
    clinic == otherTyped.clinic && 
    medicationOrderItems_on_order == otherTyped.medicationOrderItems_on_order;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, fulfilment.hashCode, deliveryAddress.hashCode, notes.hashCode, subtotal.hashCode, deliveryFee.hashCode, total.hashCode, status.hashCode, createdAt.hashCode, clinic.hashCode, medicationOrderItems_on_order.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['fulfilment'] = nativeToJson<String>(fulfilment);
    if (deliveryAddress != null) {
      json['deliveryAddress'] = nativeToJson<String?>(deliveryAddress);
    }
    if (notes != null) {
      json['notes'] = nativeToJson<String?>(notes);
    }
    json['subtotal'] = nativeToJson<double>(subtotal);
    json['deliveryFee'] = nativeToJson<double>(deliveryFee);
    json['total'] = nativeToJson<double>(total);
    json['status'] = nativeToJson<String>(status);
    if (createdAt != null) {
      json['createdAt'] = createdAt!.toJson();
    }
    if (clinic != null) {
      json['clinic'] = clinic!.toJson();
    }
    json['medicationOrderItems_on_order'] = medicationOrderItems_on_order.map((e) => e.toJson()).toList();
    return json;
  }

  ListMedicationOrdersMedicationOrders({
    required this.id,
    required this.fulfilment,
    this.deliveryAddress,
    this.notes,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    this.createdAt,
    this.clinic,
    required this.medicationOrderItems_on_order,
  });
}

@immutable
class ListMedicationOrdersMedicationOrdersClinic {
  final String name;
  ListMedicationOrdersMedicationOrdersClinic.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationOrdersMedicationOrdersClinic otherTyped = other as ListMedicationOrdersMedicationOrdersClinic;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListMedicationOrdersMedicationOrdersClinic({
    required this.name,
  });
}

@immutable
class ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder {
  final String name;
  final int quantity;
  final double unitPrice;
  final double lineTotal;
  ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder.fromJson(dynamic json):
  
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

    final ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder otherTyped = other as ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder;
    return name == otherTyped.name && 
    quantity == otherTyped.quantity && 
    unitPrice == otherTyped.unitPrice && 
    lineTotal == otherTyped.lineTotal;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, quantity.hashCode, unitPrice.hashCode, lineTotal.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['quantity'] = nativeToJson<int>(quantity);
    json['unitPrice'] = nativeToJson<double>(unitPrice);
    json['lineTotal'] = nativeToJson<double>(lineTotal);
    return json;
  }

  ListMedicationOrdersMedicationOrdersMedicationOrderItemsOnOrder({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });
}

@immutable
class ListMedicationOrdersData {
  final List<ListMedicationOrdersMedicationOrders> medicationOrders;
  ListMedicationOrdersData.fromJson(dynamic json):
  
  medicationOrders = (json['medicationOrders'] as List<dynamic>)
        .map((e) => ListMedicationOrdersMedicationOrders.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationOrdersData otherTyped = other as ListMedicationOrdersData;
    return medicationOrders == otherTyped.medicationOrders;
    
  }
  @override
  int get hashCode => medicationOrders.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medicationOrders'] = medicationOrders.map((e) => e.toJson()).toList();
    return json;
  }

  ListMedicationOrdersData({
    required this.medicationOrders,
  });
}

@immutable
class ListMedicationOrdersVariables {
  final String patientId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListMedicationOrdersVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationOrdersVariables otherTyped = other as ListMedicationOrdersVariables;
    return patientId == otherTyped.patientId;
    
  }
  @override
  int get hashCode => patientId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    return json;
  }

  ListMedicationOrdersVariables({
    required this.patientId,
  });
}

