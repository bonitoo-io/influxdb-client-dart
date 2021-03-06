// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:logging/logging.dart';

// @dart=2.0

part of influxdb_client_api;

String CLIENT_VERSION = '0.1.1';
String CLIENT_NAME = 'influxdb-client-dart';

///
/// Superclass for all services.
///
abstract class DefaultService {
  final InfluxDBClient influxDB;

  DefaultService(this.influxDB);

  Uri _buildUri(
      String influxUrl, String path, Map<String, String> queryParams) {
    Uri uri;
    if (influxUrl.startsWith('https://')) {
      uri =
          Uri.https(influxUrl.substring('https://'.length), path, queryParams);
    } else if (influxUrl.startsWith('http://')) {
      uri = Uri.http(influxUrl.substring('http://'.length), path, queryParams);
    } else {
      throw ArgumentError('Invalid url: ' + influxUrl);
    }
    return uri;
  }

  Client getClient() {
    return influxDB.client;
  }

  ApiClient getApiClient(String basePath) {
    return influxDB.getApiClient(basePath: basePath);
  }
}

/// Log printer; defaults print log to console.
void Function(Object object) logPrint = print;

///
/// Main InfluxDB client class
///
class InfluxDBClient {
  ///
  /// Create a new client for a InfluxDB.
  ///
  /// Example:
  /// ```
  ///  var client = InfluxDBClient(
  ///     url: 'http://localhost:8086',
  ///     token: 'my-token',
  ///     org: 'my-org',
  ///     bucket: 'my-bucket'
  ///   );
  /// ```
  /// * [debug] - enable/disable verbose http call traing
  /// * [username] and [password] is only for InfluxDB 1.8 comatibility
  ///
  InfluxDBClient({

    String url,
    String token,
    String bucket,
    String org,
    http.Client client,
    /// InfluxDB 1.x compatibility only
    String username,
    /// InfluxDB 1.x compatibility only
    String password,
    /// verbose logging of http calls
    bool debug = false,
  }) {
    this.url = url ?? String.fromEnvironment('INFLUXDB_URL');
    this.token = token ?? String.fromEnvironment('INFLUXDB_TOKEN');
    this.bucket = bucket ?? String.fromEnvironment('INFLUXDB_BUCKET');
    this.org = org ?? String.fromEnvironment('INFLUXDB_ORG');
    this.client = client ?? LoggingClient(debug, http.Client());
    this.debug = debug;

    // 1.8 compatibility token
    if (username != null && password != null && token == null) {
      token = '$username:$password';
    }
    defaultHeaders['Authorization'] = 'Token $token';
    defaultHeaders['User-Agent'] = '${CLIENT_NAME}/$CLIENT_VERSION';
  }

  String token;
  String url;
  String bucket;
  String org;
  bool debug;

  http.Client client;

  /// Closes the client and cleans up any resources associated with it.
  ///
  void close() {
    client.close();
  }

  Map<String, String> defaultHeaders = {};

  ApiClient getApiClient({String basePath = '/api/v2'}) {
    var api = ApiClient(basePath: url + basePath);
    api._client = client;
    api._defaultHeaderMap.addAll(defaultHeaders);
    return api;
  }

  AuthorizationsApi getAuthorizationsApi() {
    return AuthorizationsApi(getApiClient());
  }

  BucketsApi getBucketsApi() {
    return BucketsApi(getApiClient());
  }

  HealthApi getHealthApi() {
    return HealthApi(getApiClient(basePath: '/health'));
  }

  LabelsApi getLabelsApi() {
    return LabelsApi(getApiClient());
  }

  OrganizationsApi getOrganizationsApi() {
    return OrganizationsApi(getApiClient());
  }

  ReadyApi getReadyApi() {
    return ReadyApi(getApiClient(basePath: '/ready'));
  }

  TasksApi getTasksApi() {
    return TasksApi(getApiClient());
  }

  UsersApi getUsersApi() {
    return UsersApi(getApiClient());
  }

  WriteService getWriteService([WriteOptions writeOptions]) {
    return WriteService(this, writeOptions: writeOptions);
  }

  QueryService getQueryService({QueryOptions queryOptions}) {
    return QueryService(this, queryOptions: queryOptions);
  }

  DeleteService getDeleteService() {
    return DeleteService(this);
  }
}

/// Logging wrapper for http client.
class LoggingClient extends BaseClient {
  bool debugEnabled = true;
  final Client delegate;

  LoggingClient(this.debugEnabled, this.delegate);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (debugEnabled) {
      _traceRequest(request);
    }
    var send = delegate.send(request);
    if (debugEnabled) {
      send.then((r) {
        logPrint(
            '<< status: ${r.statusCode} - contentLength: ${r.contentLength}');
        logPrint('<< headers: ${r.headers}');
      });
    }
    return send;
  }

  @override
  void close() => delegate.close();

  void _traceRequest(BaseRequest request) {
    logPrint('>> ${request.method} ${request.url} =====');
    logPrint('>> headers: ${request.headers}');
    logPrint('>> contentLength: ${request.contentLength}');
  }
}
