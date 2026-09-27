part of 'generated.dart';

class ListAppointmentsVariablesBuilder {
  String patientId;

  final FirebaseDataConnect _dataConnect;
  ListAppointmentsVariablesBuilder(this._dataConnect, {required  this.patientId,});
  Deserializer<ListAppointmentsData> dataDeserializer = (dynamic json)  => ListAppointmentsData.fromJson(jsonDecode(json));
  Serializer<ListAppointmentsVariables> varsSerializer = (ListAppointmentsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListAppointmentsData, ListAppointmentsVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListAppointmentsData, ListAppointmentsVariables> ref() {
    ListAppointmentsVariables vars= ListAppointmentsVariables(patientId: patientId,);
    return _dataConnect.query("ListAppointments", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListAppointmentsAppointments {
  final String id;
  final DateTime appointmentDate;
  final String startTime;
  final String? endTime;
  final String? status;
  final String? reason;
  final ListAppointmentsAppointmentsClinic clinic;
  final ListAppointmentsAppointmentsService service;
  ListAppointmentsAppointments.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  appointmentDate = nativeFromJson<DateTime>(json['appointmentDate']),
  startTime = nativeFromJson<String>(json['startTime']),
  endTime = json['endTime'] == null ? null : nativeFromJson<String>(json['endTime']),
  status = json['status'] == null ? null : nativeFromJson<String>(json['status']),
  reason = json['reason'] == null ? null : nativeFromJson<String>(json['reason']),
  clinic = ListAppointmentsAppointmentsClinic.fromJson(json['clinic']),
  service = ListAppointmentsAppointmentsService.fromJson(json['service']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAppointmentsAppointments otherTyped = other as ListAppointmentsAppointments;
    return id == otherTyped.id && 
    appointmentDate == otherTyped.appointmentDate && 
    startTime == otherTyped.startTime && 
    endTime == otherTyped.endTime && 
    status == otherTyped.status && 
    reason == otherTyped.reason && 
    clinic == otherTyped.clinic && 
    service == otherTyped.service;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, appointmentDate.hashCode, startTime.hashCode, endTime.hashCode, status.hashCode, reason.hashCode, clinic.hashCode, service.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['appointmentDate'] = nativeToJson<DateTime>(appointmentDate);
    json['startTime'] = nativeToJson<String>(startTime);
    if (endTime != null) {
      json['endTime'] = nativeToJson<String?>(endTime);
    }
    if (status != null) {
      json['status'] = nativeToJson<String?>(status);
    }
    if (reason != null) {
      json['reason'] = nativeToJson<String?>(reason);
    }
    json['clinic'] = clinic.toJson();
    json['service'] = service.toJson();
    return json;
  }

  ListAppointmentsAppointments({
    required this.id,
    required this.appointmentDate,
    required this.startTime,
    this.endTime,
    this.status,
    this.reason,
    required this.clinic,
    required this.service,
  });
}

@immutable
class ListAppointmentsAppointmentsClinic {
  final String name;
  ListAppointmentsAppointmentsClinic.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAppointmentsAppointmentsClinic otherTyped = other as ListAppointmentsAppointmentsClinic;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListAppointmentsAppointmentsClinic({
    required this.name,
  });
}

@immutable
class ListAppointmentsAppointmentsService {
  final String name;
  ListAppointmentsAppointmentsService.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAppointmentsAppointmentsService otherTyped = other as ListAppointmentsAppointmentsService;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListAppointmentsAppointmentsService({
    required this.name,
  });
}

@immutable
class ListAppointmentsData {
  final List<ListAppointmentsAppointments> appointments;
  ListAppointmentsData.fromJson(dynamic json):
  
  appointments = (json['appointments'] as List<dynamic>)
        .map((e) => ListAppointmentsAppointments.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAppointmentsData otherTyped = other as ListAppointmentsData;
    return appointments == otherTyped.appointments;
    
  }
  @override
  int get hashCode => appointments.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['appointments'] = appointments.map((e) => e.toJson()).toList();
    return json;
  }

  ListAppointmentsData({
    required this.appointments,
  });
}

@immutable
class ListAppointmentsVariables {
  final String patientId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListAppointmentsVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAppointmentsVariables otherTyped = other as ListAppointmentsVariables;
    return patientId == otherTyped.patientId;
    
  }
  @override
  int get hashCode => patientId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    return json;
  }

  ListAppointmentsVariables({
    required this.patientId,
  });
}

