//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of influxdb_client_api;

class DeletePredicateRequest {
  /// Returns a new [DeletePredicateRequest] instance.
  DeletePredicateRequest({
    @required this.start,
    @required this.stop,
    this.predicate,
  });

  /// RFC3339Nano
  String start;

  /// RFC3339Nano
  String stop;

  /// InfluxQL-like delete statement
  String predicate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeletePredicateRequest &&
     other.start == start &&
     other.stop == stop &&
     other.predicate == predicate;

  @override
  int get hashCode =>
    (start == null ? 0 : start.hashCode) +
    (stop == null ? 0 : stop.hashCode) +
    (predicate == null ? 0 : predicate.hashCode);

  @override
  String toString() => 'DeletePredicateRequest[start=$start, stop=$stop, predicate=$predicate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (start != null) {
      json[r'start'] = start;
    }
    if (stop != null) {
      json[r'stop'] = stop;
    }
    if (predicate != null) {
      json[r'predicate'] = predicate;
    }
    return json;
  }

  /// Returns a new [DeletePredicateRequest] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static DeletePredicateRequest fromJson(Map<String, dynamic> json) => json == null
    ? null
    : DeletePredicateRequest(
        start: json[r'start'],
        stop: json[r'stop'],
        predicate: json[r'predicate'],
    );

  static List<DeletePredicateRequest> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <DeletePredicateRequest>[]
      : json.map((v) => DeletePredicateRequest.fromJson(v)).toList(growable: true == growable);

  static Map<String, DeletePredicateRequest> mapFromJson(Map<String, dynamic> json) {
    final map = <String, DeletePredicateRequest>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = DeletePredicateRequest.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of DeletePredicateRequest-objects as value to a dart map
  static Map<String, List<DeletePredicateRequest>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<DeletePredicateRequest>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = DeletePredicateRequest.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

