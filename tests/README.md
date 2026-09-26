# Automated test status

The requested generated GraphQL API tests cannot run from this checkout yet. The repository has no Firebase Data Connect schema/config, generated Dart GraphQL SDK, seed mutations, backend endpoint configuration, or server implementation. The `PostgresService` calls a Cloud Functions REST URL, which is not the generated GraphQL API described in the report and does not expose enough contract to write trustworthy FK/NOT NULL/composite-key/concurrency assertions.

Once the backend source and a test endpoint are available, add the API and journey tests listed in [`../docs/test-plan.md`](../docs/test-plan.md), configure test-only credentials through environment variables, and run them against an isolated test database/emulator. Do not use a production Firebase Admin service-account key as a test credential.

At present, no API/integration tests are represented as passing. `flutter test` only exercises Flutter tests and cannot establish PostgreSQL/Data Connect behavior.
