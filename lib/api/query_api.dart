//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of influxdb_client_api;

class QueryApi {
  QueryApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;


  /// Query InfluxDB
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] zapTraceSpan:
  ///   OpenTracing span context
  ///
  /// * [String] acceptEncoding:
  ///   The Accept-Encoding request HTTP header advertises which content encoding, usually a compression algorithm, the client is able to understand.
  ///
  /// * [String] contentType:
  ///
  /// * [String] org:
  ///   Specifies the name of the organization executing the query. Takes either the ID or Name interchangeably. If both `orgID` and `org` are specified, `org` takes precedence.
  ///
  /// * [String] orgID:
  ///   Specifies the ID of the organization executing the query. If both `orgID` and `org` are specified, `org` takes precedence.
  ///
  Future<Response> postQueryWithHttpInfo({ String zapTraceSpan, String acceptEncoding, String contentType, String org, String orgID, Query query }) async {
    // Verify required params are set.

    final path = '/query'.replaceAll('{format}', 'json');

    Object postBody = query.toJson();

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (org != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'org', org));
    }
    if (orgID != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'orgID', orgID));
    }

    if (zapTraceSpan != null) {
      headerParams[r'Zap-Trace-Span'] = parameterToString(zapTraceSpan);
    }
    if (acceptEncoding != null) {
      headerParams[r'Accept-Encoding'] = parameterToString(acceptEncoding);
    }
    if (contentType != null) {
      headerParams[r'Content-Type'] = parameterToString(contentType);
    }

    final contentTypes = <String>['application/json', 'application/vnd.flux'];
    final nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    final authNames = <String>[];

    if (
      nullableContentType != null &&
      nullableContentType.toLowerCase().startsWith('multipart/form-data')
    ) {
      bool hasFields = false;
      final mp = MultipartRequest(null, null);
      if (hasFields) {
        postBody = mp;
      }
    } else {
    }

    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      nullableContentType,
      authNames,
    );
  }

  /// Query InfluxDB
  ///
  /// Parameters:
  ///
  /// * [String] zapTraceSpan:
  ///   OpenTracing span context
  ///
  /// * [String] acceptEncoding:
  ///   The Accept-Encoding request HTTP header advertises which content encoding, usually a compression algorithm, the client is able to understand.
  ///
  /// * [String] contentType:
  ///
  /// * [String] org:
  ///   Specifies the name of the organization executing the query. Takes either the ID or Name interchangeably. If both `orgID` and `org` are specified, `org` takes precedence.
  ///
  /// * [String] orgID:
  ///   Specifies the ID of the organization executing the query. If both `orgID` and `org` are specified, `org` takes precedence.
  ///
  Future<String> postQuery({ String zapTraceSpan, String acceptEncoding, String contentType, String org, String orgID, Query query }) async {
    final response = await postQueryWithHttpInfo( zapTraceSpan: zapTraceSpan, acceptEncoding: acceptEncoding, contentType: contentType, org: org, orgID: orgID, query: query );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'String') as String;
    }
    return null;
  }


}
