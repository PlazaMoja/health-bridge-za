# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
HealthbridgeConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListClinics
#### Required Arguments
```dart
// No required arguments
HealthbridgeConnector.instance.listClinics().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListClinicsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listClinics();
ListClinicsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = HealthbridgeConnector.instance.listClinics().ref();
ref.execute();

ref.subscribe(...);
```


### ListHealthcareWorkers
#### Required Arguments
```dart
String clinicId = ...;
HealthbridgeConnector.instance.listHealthcareWorkers(
  clinicId: clinicId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListHealthcareWorkersData, ListHealthcareWorkersVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listHealthcareWorkers(
  clinicId: clinicId,
);
ListHealthcareWorkersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String clinicId = ...;

final ref = HealthbridgeConnector.instance.listHealthcareWorkers(
  clinicId: clinicId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListServices
#### Required Arguments
```dart
String clinicId = ...;
HealthbridgeConnector.instance.listServices(
  clinicId: clinicId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListServicesData, ListServicesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listServices(
  clinicId: clinicId,
);
ListServicesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String clinicId = ...;

final ref = HealthbridgeConnector.instance.listServices(
  clinicId: clinicId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAppointments
#### Required Arguments
```dart
String patientId = ...;
HealthbridgeConnector.instance.listAppointments(
  patientId: patientId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAppointmentsData, ListAppointmentsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listAppointments(
  patientId: patientId,
);
ListAppointmentsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String patientId = ...;

final ref = HealthbridgeConnector.instance.listAppointments(
  patientId: patientId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMedicalRecords
#### Required Arguments
```dart
String patientId = ...;
HealthbridgeConnector.instance.listMedicalRecords(
  patientId: patientId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMedicalRecordsData, ListMedicalRecordsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listMedicalRecords(
  patientId: patientId,
);
ListMedicalRecordsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String patientId = ...;

final ref = HealthbridgeConnector.instance.listMedicalRecords(
  patientId: patientId,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAllHealthcareWorkers
#### Required Arguments
```dart
// No required arguments
HealthbridgeConnector.instance.listAllHealthcareWorkers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllHealthcareWorkersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.listAllHealthcareWorkers();
ListAllHealthcareWorkersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = HealthbridgeConnector.instance.listAllHealthcareWorkers().ref();
ref.execute();

ref.subscribe(...);
```


### GetUser
#### Required Arguments
```dart
String firebaseUid = ...;
HealthbridgeConnector.instance.getUser(
  firebaseUid: firebaseUid,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserData, GetUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.getUser(
  firebaseUid: firebaseUid,
);
GetUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String firebaseUid = ...;

final ref = HealthbridgeConnector.instance.getUser(
  firebaseUid: firebaseUid,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetPatientByUserId
#### Required Arguments
```dart
String userId = ...;
HealthbridgeConnector.instance.getPatientByUserId(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetPatientByUserIdData, GetPatientByUserIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.getPatientByUserId(
  userId: userId,
);
GetPatientByUserIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = HealthbridgeConnector.instance.getPatientByUserId(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetUserByEmail
#### Required Arguments
```dart
String email = ...;
HealthbridgeConnector.instance.getUserByEmail(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByEmailData, GetUserByEmailVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await HealthbridgeConnector.instance.getUserByEmail(
  email: email,
);
GetUserByEmailData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = HealthbridgeConnector.instance.getUserByEmail(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### InsertAppointment
#### Required Arguments
```dart
String patientId = ...;
String clinicId = ...;
String serviceId = ...;
DateTime appointmentDate = ...;
String startTime = ...;
HealthbridgeConnector.instance.insertAppointment(
  patientId: patientId,
  clinicId: clinicId,
  serviceId: serviceId,
  appointmentDate: appointmentDate,
  startTime: startTime,
).execute();
```

#### Optional Arguments
We return a builder for each query. For InsertAppointment, we created `InsertAppointmentBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class InsertAppointmentVariablesBuilder {
  ...
   InsertAppointmentVariablesBuilder healthcareWorkerId(String? t) {
   _healthcareWorkerId.value = t;
   return this;
  }
  InsertAppointmentVariablesBuilder endTime(String? t) {
   _endTime.value = t;
   return this;
  }
  InsertAppointmentVariablesBuilder reason(String? t) {
   _reason.value = t;
   return this;
  }

  ...
}
HealthbridgeConnector.instance.insertAppointment(
  patientId: patientId,
  clinicId: clinicId,
  serviceId: serviceId,
  appointmentDate: appointmentDate,
  startTime: startTime,
)
.healthcareWorkerId(healthcareWorkerId)
.endTime(endTime)
.reason(reason)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<InsertAppointmentData, InsertAppointmentVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await HealthbridgeConnector.instance.insertAppointment(
  patientId: patientId,
  clinicId: clinicId,
  serviceId: serviceId,
  appointmentDate: appointmentDate,
  startTime: startTime,
);
InsertAppointmentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String patientId = ...;
String clinicId = ...;
String serviceId = ...;
DateTime appointmentDate = ...;
String startTime = ...;

final ref = HealthbridgeConnector.instance.insertAppointment(
  patientId: patientId,
  clinicId: clinicId,
  serviceId: serviceId,
  appointmentDate: appointmentDate,
  startTime: startTime,
).ref();
ref.execute();
```


### UpdateAppointment
#### Required Arguments
```dart
String id = ...;
HealthbridgeConnector.instance.updateAppointment(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateAppointment, we created `UpdateAppointmentBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateAppointmentVariablesBuilder {
  ...
   UpdateAppointmentVariablesBuilder status(String? t) {
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

  ...
}
HealthbridgeConnector.instance.updateAppointment(
  id: id,
)
.status(status)
.reason(reason)
.cancellationReason(cancellationReason)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateAppointmentData, UpdateAppointmentVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await HealthbridgeConnector.instance.updateAppointment(
  id: id,
);
UpdateAppointmentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = HealthbridgeConnector.instance.updateAppointment(
  id: id,
).ref();
ref.execute();
```


### InsertPatient
#### Required Arguments
```dart
String userId = ...;
HealthbridgeConnector.instance.insertPatient(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertPatientData, InsertPatientVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await HealthbridgeConnector.instance.insertPatient(
  userId: userId,
);
InsertPatientData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = HealthbridgeConnector.instance.insertPatient(
  userId: userId,
).ref();
ref.execute();
```


### InsertUser
#### Required Arguments
```dart
String firebaseUid = ...;
String email = ...;
String firstName = ...;
String lastName = ...;
HealthbridgeConnector.instance.insertUser(
  firebaseUid: firebaseUid,
  email: email,
  firstName: firstName,
  lastName: lastName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For InsertUser, we created `InsertUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class InsertUserVariablesBuilder {
  ...
   InsertUserVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  InsertUserVariablesBuilder role(String? t) {
   _role.value = t;
   return this;
  }

  ...
}
HealthbridgeConnector.instance.insertUser(
  firebaseUid: firebaseUid,
  email: email,
  firstName: firstName,
  lastName: lastName,
)
.phoneNumber(phoneNumber)
.role(role)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<InsertUserData, InsertUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await HealthbridgeConnector.instance.insertUser(
  firebaseUid: firebaseUid,
  email: email,
  firstName: firstName,
  lastName: lastName,
);
InsertUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String firebaseUid = ...;
String email = ...;
String firstName = ...;
String lastName = ...;

final ref = HealthbridgeConnector.instance.insertUser(
  firebaseUid: firebaseUid,
  email: email,
  firstName: firstName,
  lastName: lastName,
).ref();
ref.execute();
```

