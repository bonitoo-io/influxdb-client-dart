// @dart=2.0

part of influxdb_client_api;

class QueryOptions {
  bool gzip;
  QueryOptions({this.gzip = false});
}

final defaultQueryOptions = QueryOptions(gzip: true);

final Dialect DEFAULT_dialect = Dialect(
    header: true,
    delimiter: ',',
    annotations: [
      DialectAnnotationsEnum.datatype,
      DialectAnnotationsEnum.group,
      DialectAnnotationsEnum.default_
    ],
    commentPrefix: '#',
    dateTimeFormat: DialectDateTimeFormatEnum.rFC3339);

/// Query InfluxDB 2.0. Provides methods for stream Flux query.
/// See {@link https://v2.docs.influxdata.com/v2.0/api/#operation/PostQuery }

class QueryService extends DefaultService {
  QueryApi queryApi;
  bool gzip = false;
  QueryOptions queryOptions;

  QueryService(InfluxDBClient client, {QueryOptions queryOptions})
      : super(client) {
    this.queryOptions = queryOptions ?? defaultQueryOptions;
    queryApi = QueryApi(client.getApiClient());
  }

  /// Gets the result of [fluxQuery] as a raw string.
  ///
  /// Use this with care, all response is stored in memory.
  /// Result CSV format can be changed using [dialect].
  Future<String> queryRaw(String fluxQuery, {Dialect dialect}) async {
    var query = Query(dialect: dialect, query: fluxQuery);
    return await queryApi.postQuery(
        query: query,
        acceptEncoding: queryOptions.gzip ? 'gzip' : 'identity',
        org: influxDB.org);
  }

  /// Streams the result of [fluxQuery] using [Dialect].
  ///
  /// Each line is CSV parsed list of objects.
  Future<Stream<List<dynamic>>> queryLines(String fluxQuery,
      {Dialect dialect}) async {
    var q = Query(query: fluxQuery, dialect: dialect);
    var response = await _send('/api/v2/query', {'org': influxDB.org}, q);
    return utf8.decoder.bind(response.stream).transform(CsvToListConverter());
  }

  /// Streams the result of query into [Stream<FluxRecord>]
  Future<Stream<FluxRecord>> query(String fluxQuery) async {
    var q = Query(query: fluxQuery, dialect: DEFAULT_dialect);
    var response = await _send('/api/v2/query', {'org': influxDB.org}, q);
    return utf8.decoder
        .bind(response.stream)
        .transform(CsvToListConverter())
        .transform(FluxTransformer());
  }

  Future<StreamedResponse> _send(String path, Map<String,String> queryParams, body) async {
    var uri = _buildUri(influxDB.url, path, queryParams);
    var r = Request('POST', uri);
    r.headers.addAll(influxDB.defaultHeaders);
    r.headers[r'Accept-Encoding'] = queryOptions.gzip ? 'gzip' : 'identity';
    r.body = jsonEncode(body.toJson());
    var response = await influxDB.client.send(r);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw InfluxDBException.fromJson(
          await response.stream.bytesToString(), response.statusCode, response.headers);
    }
    return response;
  }
}
