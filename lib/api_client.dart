//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of influxdb_client_api;

class ApiClient {
  ApiClient({this.basePath = 'https://raw.githubusercontent.com/api/v2'}) {
    // Setup authentications (key: authentication name, value: authentication).
    _authentications[r'BasicAuth'] = HttpBasicAuth();
  }

  final String basePath;

  var _client = Client();

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  ///
  /// If the [newClient] is null, an [ArgumentError] is thrown.
  set client(Client newClient) {
    if (newClient == null) {
      throw ArgumentError('New client instance cannot be null.');
    }
    _client = newClient;
  }

  final _defaultHeaderMap = <String, String>{};
  final _authentications = <String, Authentication>{};

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  dynamic deserialize(String json, String targetType, {bool growable}) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    return targetType == 'String'
      ? json
      : _deserialize(jsonDecode(json), targetType, growable: true == growable);
  }

  String serialize(Object obj) => obj == null ? '' : json.encode(obj);

  T getAuthentication<T extends Authentication>(String name) {
    final authentication = _authentications[name];
    return authentication is T ? authentication : null;
  }

  // We don’t use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    Iterable<QueryParam> queryParams,
    Object body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String nullableContentType,
    List<String> authNames,
  ) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);

    final urlEncodedQueryParams = queryParams
      .where((param) => param.value != null)
      .map((param) => '$param');

    final queryString = urlEncodedQueryParams.isNotEmpty
      ? '?${urlEncodedQueryParams.join('&')}'
      : '';

    final url = '$basePath$path$queryString';

    if (nullableContentType != null) {
      headerParams['Content-Type'] = nullableContentType;
    }

    try {
      // Special case for uploading a single file which isn’t a 'multipart/form-data'.
      if (
        body is MultipartFile && (nullableContentType == null ||
        !nullableContentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = StreamedRequest(method, Uri.parse(url));
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          onError: (error, trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, Uri.parse(url));
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = nullableContentType == 'application/x-www-form-urlencoded'
        ? formParams
        : serialize(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch(method) {
        case 'POST': return await _client.post(url, headers: nullableHeaderParams, body: msgBody,);
        case 'PUT': return await _client.put(url, headers: nullableHeaderParams, body: msgBody,);
        case 'DELETE': return await _client.delete(url, headers: nullableHeaderParams,);
        case 'PATCH': return await _client.patch(url, headers: nullableHeaderParams, body: msgBody,);
        case 'HEAD': return await _client.head(url, headers: nullableHeaderParams,);
        case 'GET': return await _client.get(url, headers: nullableHeaderParams,);
      }
    } on SocketException catch (e, trace) {
      throw ApiException.withInner(HttpStatus.badRequest, 'Socket operation failed: $method $path', e, trace,);
    } on TlsException catch (e, trace) {
      throw ApiException.withInner(HttpStatus.badRequest, 'TLS/SSL communication failed: $method $path', e, trace,);
    } on IOException catch (e, trace) {
      throw ApiException.withInner(HttpStatus.badRequest, 'I/O operation failed: $method $path', e, trace,);
    } on ClientException catch (e, trace) {
      throw ApiException.withInner(HttpStatus.badRequest, 'HTTP connection failed: $method $path', e, trace,);
    } on Exception catch (e, trace) {
      throw ApiException.withInner(HttpStatus.badRequest, 'Exception occurred: $method $path', e, trace,);
    }

    throw ApiException(HttpStatus.badRequest, 'Invalid HTTP operation: $method $path',);
  }

  dynamic _deserialize(dynamic value, String targetType, {bool growable}) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
          break;
        case 'double':
          return value is double ? value : double.parse('$value');
        // case 'ASTResponse':
        //   return ASTResponse.fromJson(value);
        case 'AddResourceMemberRequestBody':
          return AddResourceMemberRequestBody.fromJson(value);
        // case 'AnalyzeQueryResponse':
        //   return AnalyzeQueryResponse.fromJson(value);
        // case 'AnalyzeQueryResponseErrors':
        //   return AnalyzeQueryResponseErrors.fromJson(value);
        // case 'ArrayExpression':
        //   return ArrayExpression.fromJson(value);
        case 'Authorization':
          return Authorization.fromJson(value);
        case 'AuthorizationAllOf':
          return AuthorizationAllOf.fromJson(value);
        case 'AuthorizationAllOfLinks':
          return AuthorizationAllOfLinks.fromJson(value);
        case 'AuthorizationUpdateRequest':
          return AuthorizationUpdateRequest.fromJson(value);
        case 'Authorizations':
          return Authorizations.fromJson(value);
        // case 'Axes':
        //   return Axes.fromJson(value);
        // case 'Axis':
        //   return Axis.fromJson(value);
        // case 'AxisScale':
        //   return AxisScaleTypeTransformer().decode(value);
        // case 'BadStatement':
        //   return BadStatement.fromJson(value);
        // case 'BandViewProperties':
        //   return BandViewProperties.fromJson(value);
        // case 'BinaryExpression':
        //   return BinaryExpression.fromJson(value);
        // case 'Block':
        //   return Block.fromJson(value);
        // case 'BooleanLiteral':
        //   return BooleanLiteral.fromJson(value);
        case 'Bucket':
          return Bucket.fromJson(value);
        case 'BucketLinks':
          return BucketLinks.fromJson(value);
        case 'Buckets':
          return Buckets.fromJson(value);
        // case 'BuilderAggregateFunctionType':
        //   return BuilderAggregateFunctionTypeTypeTransformer().decode(value);
        // case 'BuilderConfig':
        //   return BuilderConfig.fromJson(value);
        // case 'BuilderConfigAggregateWindow':
        //   return BuilderConfigAggregateWindow.fromJson(value);
        // case 'BuilderFunctionsType':
        //   return BuilderFunctionsType.fromJson(value);
        // case 'BuilderTagsType':
        //   return BuilderTagsType.fromJson(value);
        // case 'BuiltinStatement':
        //   return BuiltinStatement.fromJson(value);
        // case 'CallExpression':
        //   return CallExpression.fromJson(value);
        // case 'Cell':
        //   return Cell.fromJson(value);
        // case 'CellLinks':
        //   return CellLinks.fromJson(value);
        // case 'CellUpdate':
        //   return CellUpdate.fromJson(value);
        // case 'CellWithViewProperties':
        //   return CellWithViewProperties.fromJson(value);
        // case 'CellWithViewPropertiesAllOf':
        //   return CellWithViewPropertiesAllOf.fromJson(value);
        // case 'Check':
        //   return Check.fromJson(value);
        // case 'CheckBase':
        //   return CheckBase.fromJson(value);
        // case 'CheckBaseLinks':
        //   return CheckBaseLinks.fromJson(value);
        // case 'CheckDiscriminator':
        //   return CheckDiscriminator.fromJson(value);
        // case 'CheckPatch':
        //   return CheckPatch.fromJson(value);
        // case 'CheckStatusLevel':
        //   return CheckStatusLevelTypeTransformer().decode(value);
        // case 'CheckViewProperties':
        //   return CheckViewProperties.fromJson(value);
        // case 'Checks':
        //   return Checks.fromJson(value);
        // case 'ConditionalExpression':
        //   return ConditionalExpression.fromJson(value);
        // case 'ConstantVariableProperties':
        //   return ConstantVariableProperties.fromJson(value);
        // case 'CreateCell':
        //   return CreateCell.fromJson(value);
        // case 'CreateDashboardRequest':
        //   return CreateDashboardRequest.fromJson(value);
        // case 'CustomCheck':
        //   return CustomCheck.fromJson(value);
        // case 'CustomCheckAllOf':
        //   return CustomCheckAllOf.fromJson(value);
        // case 'DBRP':
        //   return DBRP.fromJson(value);
        // case 'DBRPUpdate':
        //   return DBRPUpdate.fromJson(value);
        // case 'DBRPs':
        //   return DBRPs.fromJson(value);
        // case 'Dashboard':
        //   return Dashboard.fromJson(value);
        // case 'DashboardAllOf':
        //   return DashboardAllOf.fromJson(value);
        // case 'DashboardColor':
        //   return DashboardColor.fromJson(value);
        // case 'DashboardQuery':
        //   return DashboardQuery.fromJson(value);
        // case 'DashboardWithViewProperties':
        //   return DashboardWithViewProperties.fromJson(value);
        // case 'DashboardWithViewPropertiesAllOf':
        //   return DashboardWithViewPropertiesAllOf.fromJson(value);
        // case 'DashboardWithViewPropertiesAllOfLinks':
        //   return DashboardWithViewPropertiesAllOfLinks.fromJson(value);
        // case 'DashboardWithViewPropertiesAllOfMeta':
        //   return DashboardWithViewPropertiesAllOfMeta.fromJson(value);
        // case 'Dashboards':
        //   return Dashboards.fromJson(value);
        // case 'DateTimeLiteral':
        //   return DateTimeLiteral.fromJson(value);
        // case 'DeadmanCheck':
        //   return DeadmanCheck.fromJson(value);
        // case 'DeadmanCheckAllOf':
        //   return DeadmanCheckAllOf.fromJson(value);
        // case 'DecimalPlaces':
        //   return DecimalPlaces.fromJson(value);
        // case 'DeletePredicateRequest':
        //   return DeletePredicateRequest.fromJson(value);
        // case 'Dialect':
        //   return Dialect.fromJson(value);
        // case 'Document':
        //   return Document.fromJson(value);
        // case 'DocumentCreate':
        //   return DocumentCreate.fromJson(value);
        // case 'DocumentLinks':
        //   return DocumentLinks.fromJson(value);
        // case 'DocumentListEntry':
        //   return DocumentListEntry.fromJson(value);
        // case 'DocumentMeta':
        //   return DocumentMeta.fromJson(value);
        // case 'DocumentUpdate':
        //   return DocumentUpdate.fromJson(value);
        // case 'Documents':
        //   return Documents.fromJson(value);
        // case 'Duration':
        //   return Duration.fromJson(value);
        // case 'DurationLiteral':
        //   return DurationLiteral.fromJson(value);
        // case 'Error':
        //   return Error.fromJson(value);
        // case 'Expression':
        //   return Expression.fromJson(value);
        // case 'ExpressionStatement':
        //   return ExpressionStatement.fromJson(value);
        // case 'Field':
        //   return Field.fromJson(value);
        // case 'FloatLiteral':
        //   return FloatLiteral.fromJson(value);
        // case 'FluxResponse':
        //   return FluxResponse.fromJson(value);
        // case 'FluxSuggestion':
        //   return FluxSuggestion.fromJson(value);
        // case 'FluxSuggestions':
        //   return FluxSuggestions.fromJson(value);
        // case 'FunctionExpression':
        //   return FunctionExpression.fromJson(value);
        // case 'GaugeViewProperties':
        //   return GaugeViewProperties.fromJson(value);
        // case 'GreaterThreshold':
        //   return GreaterThreshold.fromJson(value);
        // case 'GreaterThresholdAllOf':
        //   return GreaterThresholdAllOf.fromJson(value);
        // case 'HTTPNotificationEndpoint':
        //   return HTTPNotificationEndpoint.fromJson(value);
        // case 'HTTPNotificationEndpointAllOf':
        //   return HTTPNotificationEndpointAllOf.fromJson(value);
        // case 'HTTPNotificationRule':
        //   return HTTPNotificationRule.fromJson(value);
        // case 'HTTPNotificationRuleBase':
        //   return HTTPNotificationRuleBase.fromJson(value);
        case 'HealthCheck':
          return HealthCheck.fromJson(value);
        // case 'HeatmapViewProperties':
        //   return HeatmapViewProperties.fromJson(value);
        // case 'HistogramViewProperties':
        //   return HistogramViewProperties.fromJson(value);
        // case 'Identifier':
        //   return Identifier.fromJson(value);
        // case 'ImportDeclaration':
        //   return ImportDeclaration.fromJson(value);
        // case 'IndexExpression':
        //   return IndexExpression.fromJson(value);
        // case 'InfluxQLQuery':
        //   return InfluxQLQuery.fromJson(value);
        // case 'InlineObject':
        //   return InlineObject.fromJson(value);
        // case 'InlineObject1':
        //   return InlineObject1.fromJson(value);
        // case 'InlineObject2':
        //   return InlineObject2.fromJson(value);
        // case 'InlineResponse200':
        //   return InlineResponse200.fromJson(value);
        // case 'IntegerLiteral':
        //   return IntegerLiteral.fromJson(value);
        // case 'IsOnboarding':
        //   return IsOnboarding.fromJson(value);
        case 'Label':
          return Label.fromJson(value);
        case 'LabelCreateRequest':
          return LabelCreateRequest.fromJson(value);
        case 'LabelMapping':
          return LabelMapping.fromJson(value);
        case 'LabelResponse':
          return LabelResponse.fromJson(value);
        case 'LabelUpdate':
          return LabelUpdate.fromJson(value);
        case 'LabelsResponse':
          return LabelsResponse.fromJson(value);
        // case 'LanguageRequest':
        //   return LanguageRequest.fromJson(value);
        // case 'Legend':
        //   return Legend.fromJson(value);
        // case 'LesserThreshold':
        //   return LesserThreshold.fromJson(value);
        // case 'LesserThresholdAllOf':
        //   return LesserThresholdAllOf.fromJson(value);
        // case 'LinePlusSingleStatProperties':
        //   return LinePlusSingleStatProperties.fromJson(value);
        // case 'LineProtocolError':
        //   return LineProtocolError.fromJson(value);
        // case 'LineProtocolLengthError':
        //   return LineProtocolLengthError.fromJson(value);
        case 'Links':
          return Links.fromJson(value);
        case 'LogEvent':
          return LogEvent.fromJson(value);
        // case 'LogicalExpression':
        //   return LogicalExpression.fromJson(value);
        // case 'Logs':
        //   return Logs.fromJson(value);
        // case 'MapVariableProperties':
        //   return MapVariableProperties.fromJson(value);
        // case 'MarkdownViewProperties':
        //   return MarkdownViewProperties.fromJson(value);
        // case 'MemberAssignment':
        //   return MemberAssignment.fromJson(value);
        // case 'MemberExpression':
        //   return MemberExpression.fromJson(value);
        // case 'ModelFile':
        //   return ModelFile.fromJson(value);
        // case 'ModelSource':
        //   return ModelSource.fromJson(value);
        // case 'MosaicViewProperties':
        //   return MosaicViewProperties.fromJson(value);
        // case 'Node':
        //   return Node.fromJson(value);
        // case 'NotificationEndpoint':
        //   return NotificationEndpoint.fromJson(value);
        // case 'NotificationEndpointBase':
        //   return NotificationEndpointBase.fromJson(value);
        // case 'NotificationEndpointBaseLinks':
        //   return NotificationEndpointBaseLinks.fromJson(value);
        // case 'NotificationEndpointDiscrimator':
        //   return NotificationEndpointDiscrimator.fromJson(value);
        // case 'NotificationEndpointType':
        //   return NotificationEndpointTypeTypeTransformer().decode(value);
        // case 'NotificationEndpointUpdate':
        //   return NotificationEndpointUpdate.fromJson(value);
        // case 'NotificationEndpoints':
        //   return NotificationEndpoints.fromJson(value);
        // case 'NotificationRule':
        //   return NotificationRule.fromJson(value);
        // case 'NotificationRuleBase':
        //   return NotificationRuleBase.fromJson(value);
        // case 'NotificationRuleBaseLinks':
        //   return NotificationRuleBaseLinks.fromJson(value);
        // case 'NotificationRuleDiscriminator':
        //   return NotificationRuleDiscriminator.fromJson(value);
        // case 'NotificationRuleUpdate':
        //   return NotificationRuleUpdate.fromJson(value);
        // case 'NotificationRules':
        //   return NotificationRules.fromJson(value);
        // case 'ObjectExpression':
        //   return ObjectExpression.fromJson(value);
        // case 'OnboardingRequest':
        //   return OnboardingRequest.fromJson(value);
        // case 'OnboardingResponse':
        //   return OnboardingResponse.fromJson(value);
        // case 'OptionStatement':
        //   return OptionStatement.fromJson(value);
        case 'Organization':
          return Organization.fromJson(value);
        case 'OrganizationLinks':
          return OrganizationLinks.fromJson(value);
        case 'Organizations':
          return Organizations.fromJson(value);
        // case 'Package':
        //   return Package.fromJson(value);
        // case 'PackageClause':
        //   return PackageClause.fromJson(value);
        // case 'PagerDutyNotificationEndpoint':
        //   return PagerDutyNotificationEndpoint.fromJson(value);
        // case 'PagerDutyNotificationEndpointAllOf':
        //   return PagerDutyNotificationEndpointAllOf.fromJson(value);
        // case 'PagerDutyNotificationRule':
        //   return PagerDutyNotificationRule.fromJson(value);
        // case 'PagerDutyNotificationRuleBase':
        //   return PagerDutyNotificationRuleBase.fromJson(value);
        // case 'ParenExpression':
        //   return ParenExpression.fromJson(value);
        // case 'PasswordResetBody':
        //   return PasswordResetBody.fromJson(value);
        // case 'Permission':
        //   return Permission.fromJson(value);
        // case 'PipeExpression':
        //   return PipeExpression.fromJson(value);
        // case 'PipeLiteral':
        //   return PipeLiteral.fromJson(value);
        case 'PostBucketRequest':
          return PostBucketRequest.fromJson(value);
        // case 'PostCheck':
        //   return PostCheck.fromJson(value);
        // case 'PostNotificationEndpoint':
        //   return PostNotificationEndpoint.fromJson(value);
        // case 'PostNotificationRule':
        //   return PostNotificationRule.fromJson(value);
        // case 'Property':
        //   return Property.fromJson(value);
        // case 'PropertyKey':
        //   return PropertyKey.fromJson(value);
        case 'Query':
          return Query.fromJson(value);
        // case 'QueryEditMode':
        //   return QueryEditModeTypeTransformer().decode(value);
        // case 'QueryVariableProperties':
        //   return QueryVariableProperties.fromJson(value);
        // case 'QueryVariablePropertiesValues':
        //   return QueryVariablePropertiesValues.fromJson(value);
        // case 'RangeThreshold':
        //   return RangeThreshold.fromJson(value);
        // case 'RangeThresholdAllOf':
        //   return RangeThresholdAllOf.fromJson(value);
        case 'Ready':
          return Ready.fromJson(value);
        // case 'RegexpLiteral':
        //   return RegexpLiteral.fromJson(value);
        // case 'RenamableField':
        //   return RenamableField.fromJson(value);
        case 'Resource':
          return Resource.fromJson(value);
        case 'ResourceMember':
          return ResourceMember.fromJson(value);
        case 'ResourceMemberAllOf':
          return ResourceMemberAllOf.fromJson(value);
        case 'ResourceMembers':
          return ResourceMembers.fromJson(value);
        case 'ResourceOwner':
          return ResourceOwner.fromJson(value);
        case 'ResourceOwnerAllOf':
          return ResourceOwnerAllOf.fromJson(value);
        case 'ResourceOwners':
          return ResourceOwners.fromJson(value);
        case 'RetentionRule':
          return RetentionRule.fromJson(value);
        // case 'ReturnStatement':
        //   return ReturnStatement.fromJson(value);
        // case 'Routes':
        //   return Routes.fromJson(value);
        // case 'RoutesExternal':
        //   return RoutesExternal.fromJson(value);
        // case 'RoutesQuery':
        //   return RoutesQuery.fromJson(value);
        // case 'RoutesSystem':
        //   return RoutesSystem.fromJson(value);
        // case 'RuleStatusLevel':
        //   return RuleStatusLevelTypeTransformer().decode(value);
        case 'Run':
          return Run.fromJson(value);
        case 'RunLinks':
          return RunLinks.fromJson(value);
        case 'RunLog':
          return RunLog.fromJson(value);
        case 'RunManually':
          return RunManually.fromJson(value);
        case 'Runs':
          return Runs.fromJson(value);
        // case 'SMTPNotificationRule':
        //   return SMTPNotificationRule.fromJson(value);
        // case 'SMTPNotificationRuleBase':
        //   return SMTPNotificationRuleBase.fromJson(value);
        // case 'ScatterViewProperties':
        //   return ScatterViewProperties.fromJson(value);
        // case 'ScraperTargetRequest':
        //   return ScraperTargetRequest.fromJson(value);
        // case 'ScraperTargetResponse':
        //   return ScraperTargetResponse.fromJson(value);
        // case 'ScraperTargetResponseAllOf':
        //   return ScraperTargetResponseAllOf.fromJson(value);
        // case 'ScraperTargetResponseAllOfLinks':
        //   return ScraperTargetResponseAllOfLinks.fromJson(value);
        // case 'ScraperTargetResponses':
        //   return ScraperTargetResponses.fromJson(value);
        case 'SecretKeys':
          return SecretKeys.fromJson(value);
        case 'SecretKeysResponse':
          return SecretKeysResponse.fromJson(value);
        case 'SecretKeysResponseAllOf':
          return SecretKeysResponseAllOf.fromJson(value);
        case 'SecretKeysResponseAllOfLinks':
          return SecretKeysResponseAllOfLinks.fromJson(value);
        // case 'SingleStatViewProperties':
        //   return SingleStatViewProperties.fromJson(value);
        // case 'SlackNotificationEndpoint':
        //   return SlackNotificationEndpoint.fromJson(value);
        // case 'SlackNotificationEndpointAllOf':
        //   return SlackNotificationEndpointAllOf.fromJson(value);
        // case 'SlackNotificationRule':
        //   return SlackNotificationRule.fromJson(value);
        // case 'SlackNotificationRuleBase':
        //   return SlackNotificationRuleBase.fromJson(value);
        // case 'SourceLinks':
        //   return SourceLinks.fromJson(value);
        // case 'Sources':
        //   return Sources.fromJson(value);
        // case 'Stack':
        //   return Stack.fromJson(value);
        // case 'StackAssociations':
        //   return StackAssociations.fromJson(value);
        // case 'StackEvents':
        //   return StackEvents.fromJson(value);
        // case 'StackLinks':
        //   return StackLinks.fromJson(value);
        // case 'StackResources':
        //   return StackResources.fromJson(value);
        // case 'StacksStackIdAdditionalResources':
        //   return StacksStackIdAdditionalResources.fromJson(value);
        // case 'Statement':
        //   return Statement.fromJson(value);
        // case 'StatusRule':
        //   return StatusRule.fromJson(value);
        // case 'StringLiteral':
        //   return StringLiteral.fromJson(value);
        // case 'TableViewProperties':
        //   return TableViewProperties.fromJson(value);
        // case 'TagRule':
        //   return TagRule.fromJson(value);
        case 'Task':
          return Task.fromJson(value);
        case 'TaskCreateRequest':
          return TaskCreateRequest.fromJson(value);
        case 'TaskLinks':
          return TaskLinks.fromJson(value);
        case 'TaskStatusType':
          return TaskStatusTypeTypeTransformer().decode(value);
        case 'TaskUpdateRequest':
          return TaskUpdateRequest.fromJson(value);
        case 'Tasks':
          return Tasks.fromJson(value);
        // case 'Telegraf':
        //   return Telegraf.fromJson(value);
        // case 'TelegrafAllOf':
        //   return TelegrafAllOf.fromJson(value);
        // case 'TelegrafAllOfLinks':
        //   return TelegrafAllOfLinks.fromJson(value);
        // case 'TelegrafPlugin':
        //   return TelegrafPlugin.fromJson(value);
        // case 'TelegrafPluginInputCpu':
        //   return TelegrafPluginInputCpu.fromJson(value);
        // case 'TelegrafPluginInputDisk':
        //   return TelegrafPluginInputDisk.fromJson(value);
        // case 'TelegrafPluginInputDiskio':
        //   return TelegrafPluginInputDiskio.fromJson(value);
        // case 'TelegrafPluginInputDocker':
        //   return TelegrafPluginInputDocker.fromJson(value);
        // case 'TelegrafPluginInputDockerConfig':
        //   return TelegrafPluginInputDockerConfig.fromJson(value);
        // case 'TelegrafPluginInputFile':
        //   return TelegrafPluginInputFile.fromJson(value);
        // case 'TelegrafPluginInputFileConfig':
        //   return TelegrafPluginInputFileConfig.fromJson(value);
        // case 'TelegrafPluginInputKernel':
        //   return TelegrafPluginInputKernel.fromJson(value);
        // case 'TelegrafPluginInputKubernetes':
        //   return TelegrafPluginInputKubernetes.fromJson(value);
        // case 'TelegrafPluginInputKubernetesConfig':
        //   return TelegrafPluginInputKubernetesConfig.fromJson(value);
        // case 'TelegrafPluginInputLogParser':
        //   return TelegrafPluginInputLogParser.fromJson(value);
        // case 'TelegrafPluginInputLogParserConfig':
        //   return TelegrafPluginInputLogParserConfig.fromJson(value);
        // case 'TelegrafPluginInputMem':
        //   return TelegrafPluginInputMem.fromJson(value);
        // case 'TelegrafPluginInputNet':
        //   return TelegrafPluginInputNet.fromJson(value);
        // case 'TelegrafPluginInputNetResponse':
        //   return TelegrafPluginInputNetResponse.fromJson(value);
        // case 'TelegrafPluginInputNginx':
        //   return TelegrafPluginInputNginx.fromJson(value);
        // case 'TelegrafPluginInputProcesses':
        //   return TelegrafPluginInputProcesses.fromJson(value);
        // case 'TelegrafPluginInputProcstat':
        //   return TelegrafPluginInputProcstat.fromJson(value);
        // case 'TelegrafPluginInputProcstatConfig':
        //   return TelegrafPluginInputProcstatConfig.fromJson(value);
        // case 'TelegrafPluginInputPrometheus':
        //   return TelegrafPluginInputPrometheus.fromJson(value);
        // case 'TelegrafPluginInputPrometheusConfig':
        //   return TelegrafPluginInputPrometheusConfig.fromJson(value);
        // case 'TelegrafPluginInputRedis':
        //   return TelegrafPluginInputRedis.fromJson(value);
        // case 'TelegrafPluginInputRedisConfig':
        //   return TelegrafPluginInputRedisConfig.fromJson(value);
        // case 'TelegrafPluginInputSwap':
        //   return TelegrafPluginInputSwap.fromJson(value);
        // case 'TelegrafPluginInputSyslog':
        //   return TelegrafPluginInputSyslog.fromJson(value);
        // case 'TelegrafPluginInputSyslogConfig':
        //   return TelegrafPluginInputSyslogConfig.fromJson(value);
        // case 'TelegrafPluginInputSystem':
        //   return TelegrafPluginInputSystem.fromJson(value);
        // case 'TelegrafPluginInputTail':
        //   return TelegrafPluginInputTail.fromJson(value);
        // case 'TelegrafPluginOutputFile':
        //   return TelegrafPluginOutputFile.fromJson(value);
        // case 'TelegrafPluginOutputFileConfig':
        //   return TelegrafPluginOutputFileConfig.fromJson(value);
        // case 'TelegrafPluginOutputFileConfigFiles':
        //   return TelegrafPluginOutputFileConfigFiles.fromJson(value);
        // case 'TelegrafPluginOutputInfluxDBV2':
        //   return TelegrafPluginOutputInfluxDBV2.fromJson(value);
        // case 'TelegrafPluginOutputInfluxDBV2Config':
        //   return TelegrafPluginOutputInfluxDBV2Config.fromJson(value);
        // case 'TelegrafPlugins':
        //   return TelegrafPlugins.fromJson(value);
        // case 'TelegrafRequest':
        //   return TelegrafRequest.fromJson(value);
        // case 'TelegrafRequestMetadata':
        //   return TelegrafRequestMetadata.fromJson(value);
        // case 'TelegrafRequestPlugin':
        //   return TelegrafRequestPlugin.fromJson(value);
        // case 'Telegrafs':
        //   return Telegrafs.fromJson(value);
        // case 'TelegramNotificationEndpoint':
        //   return TelegramNotificationEndpoint.fromJson(value);
        // case 'TelegramNotificationEndpointAllOf':
        //   return TelegramNotificationEndpointAllOf.fromJson(value);
        // case 'TelegramNotificationRule':
        //   return TelegramNotificationRule.fromJson(value);
        // case 'TelegramNotificationRuleBase':
        //   return TelegramNotificationRuleBase.fromJson(value);
        // case 'TemplateApply':
        //   return TemplateApply.fromJson(value);
        // case 'TemplateApplyRemotes':
        //   return TemplateApplyRemotes.fromJson(value);
        // case 'TemplateApplyTemplate':
        //   return TemplateApplyTemplate.fromJson(value);
        // case 'TemplateChart':
        //   return TemplateChart.fromJson(value);
        // case 'TemplateExportByID':
        //   return TemplateExportByID.fromJson(value);
        // case 'TemplateExportByIDOrgIDs':
        //   return TemplateExportByIDOrgIDs.fromJson(value);
        // case 'TemplateExportByIDResourceFilters':
        //   return TemplateExportByIDResourceFilters.fromJson(value);
        // case 'TemplateExportByIDResources':
        //   return TemplateExportByIDResources.fromJson(value);
        // case 'TemplateExportByName':
        //   return TemplateExportByName.fromJson(value);
        // case 'TemplateExportByNameResources':
        //   return TemplateExportByNameResources.fromJson(value);
        // case 'TemplateKind':
        //   return TemplateKindTypeTransformer().decode(value);
        // case 'TemplateSummary':
        //   return TemplateSummary.fromJson(value);
        // case 'TemplateSummaryDiff':
        //   return TemplateSummaryDiff.fromJson(value);
        // case 'TemplateSummaryDiffBuckets':
        //   return TemplateSummaryDiffBuckets.fromJson(value);
        // case 'TemplateSummaryDiffChecks':
        //   return TemplateSummaryDiffChecks.fromJson(value);
        // case 'TemplateSummaryDiffDashboards':
        //   return TemplateSummaryDiffDashboards.fromJson(value);
        // case 'TemplateSummaryDiffLabelMappings':
        //   return TemplateSummaryDiffLabelMappings.fromJson(value);
        // case 'TemplateSummaryDiffLabels':
        //   return TemplateSummaryDiffLabels.fromJson(value);
        // case 'TemplateSummaryDiffNew':
        //   return TemplateSummaryDiffNew.fromJson(value);
        // case 'TemplateSummaryDiffNew1':
        //   return TemplateSummaryDiffNew1.fromJson(value);
        // case 'TemplateSummaryDiffNew2':
        //   return TemplateSummaryDiffNew2.fromJson(value);
        // case 'TemplateSummaryDiffNew3':
        //   return TemplateSummaryDiffNew3.fromJson(value);
        // case 'TemplateSummaryDiffNew4':
        //   return TemplateSummaryDiffNew4.fromJson(value);
        // case 'TemplateSummaryDiffNew5':
        //   return TemplateSummaryDiffNew5.fromJson(value);
        // case 'TemplateSummaryDiffNotificationEndpoints':
        //   return TemplateSummaryDiffNotificationEndpoints.fromJson(value);
        // case 'TemplateSummaryDiffNotificationRules':
        //   return TemplateSummaryDiffNotificationRules.fromJson(value);
        // case 'TemplateSummaryDiffTasks':
        //   return TemplateSummaryDiffTasks.fromJson(value);
        // case 'TemplateSummaryDiffTelegrafConfigs':
        //   return TemplateSummaryDiffTelegrafConfigs.fromJson(value);
        // case 'TemplateSummaryDiffVariables':
        //   return TemplateSummaryDiffVariables.fromJson(value);
        // case 'TemplateSummaryErrors':
        //   return TemplateSummaryErrors.fromJson(value);
        // case 'TemplateSummaryLabel':
        //   return TemplateSummaryLabel.fromJson(value);
        // case 'TemplateSummaryLabelProperties':
        //   return TemplateSummaryLabelProperties.fromJson(value);
        // case 'TemplateSummarySummary':
        //   return TemplateSummarySummary.fromJson(value);
        // case 'TemplateSummarySummaryBuckets':
        //   return TemplateSummarySummaryBuckets.fromJson(value);
        // case 'TemplateSummarySummaryDashboards':
        //   return TemplateSummarySummaryDashboards.fromJson(value);
        // case 'TemplateSummarySummaryLabelMappings':
        //   return TemplateSummarySummaryLabelMappings.fromJson(value);
        // case 'TemplateSummarySummaryNotificationRules':
        //   return TemplateSummarySummaryNotificationRules.fromJson(value);
        // case 'TemplateSummarySummaryStatusRules':
        //   return TemplateSummarySummaryStatusRules.fromJson(value);
        // case 'TemplateSummarySummaryTagRules':
        //   return TemplateSummarySummaryTagRules.fromJson(value);
        // case 'TemplateSummarySummaryTasks':
        //   return TemplateSummarySummaryTasks.fromJson(value);
        // case 'TemplateSummarySummaryVariables':
        //   return TemplateSummarySummaryVariables.fromJson(value);
        // case 'TestStatement':
        //   return TestStatement.fromJson(value);
        // case 'Threshold':
        //   return Threshold.fromJson(value);
        // case 'ThresholdBase':
        //   return ThresholdBase.fromJson(value);
        // case 'ThresholdCheck':
        //   return ThresholdCheck.fromJson(value);
        // case 'ThresholdCheckAllOf':
        //   return ThresholdCheckAllOf.fromJson(value);
        // case 'ThresholdCheckAllOfTags':
        //   return ThresholdCheckAllOfTags.fromJson(value);
        // case 'UnaryExpression':
        //   return UnaryExpression.fromJson(value);
        // case 'UnsignedIntegerLiteral':
        //   return UnsignedIntegerLiteral.fromJson(value);
        case 'User':
          return User.fromJson(value);
        case 'UserLinks':
          return UserLinks.fromJson(value);
        case 'Users':
          return Users.fromJson(value);
        case 'UsersLinks':
          return UsersLinks.fromJson(value);
        // case 'Variable':
        //   return Variable.fromJson(value);
        // case 'VariableAssignment':
        //   return VariableAssignment.fromJson(value);
        // case 'VariableLinks':
        //   return VariableLinks.fromJson(value);
        // case 'VariableProperties':
        //   return VariableProperties.fromJson(value);
        // case 'Variables':
        //   return Variables.fromJson(value);
        // case 'View':
        //   return View.fromJson(value);
        // case 'ViewLinks':
        //   return ViewLinks.fromJson(value);
        // case 'ViewProperties':
        //   return ViewProperties.fromJson(value);
        // case 'Views':
        //   return Views.fromJson(value);
        // case 'WritePrecision':
        //   return WritePrecisionTypeTransformer().decode(value);
        // case 'XYGeom':
        //   return XYGeomTypeTransformer().decode(value);
        // case 'XYViewProperties':
        //   return XYViewProperties.fromJson(value);

        default:
          // found type using reflection
          // var mirrors = currentMirrorSystem();
          // ClassMirror classMirror = mirrors.findLibrary(Symbol('influxdb_client_api')).declarations[Symbol(targetType)];
          // if (classMirror != null) {
          //   return classMirror.invoke(Symbol('fromJson'), [value]).reflectee;
          // }

          Match match;
          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            final newTargetType = match[1];
            return value
              .map((v) => _deserialize(v, newTargetType, growable: growable))
              .toList(growable: true == growable);
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            final newTargetType = match[1];
            return Map.fromIterables(
              value.keys,
              value.values.map((v) => _deserialize(v, newTargetType, growable: growable)),
            );
          }
          break;
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', e, stack,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization for $targetType',);
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(
    List<String> authNames,
    List<QueryParam> queryParams,
    Map<String, String> headerParams,
  ) {
    authNames.forEach((authName) {
      final auth = _authentications[authName];
      if (auth == null) {
        throw ArgumentError('Authentication undefined: $authName');
      }
      auth.applyToParams(queryParams, headerParams);
    });
  }
}
