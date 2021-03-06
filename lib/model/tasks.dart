//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of influxdb_client_api;

class Tasks {
  /// Returns a new [Tasks] instance.
  Tasks({
    this.links,
    this.tasks = const [],
  });

  Links links;

  List<Task> tasks;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Tasks &&
     other.links == links &&
     other.tasks == tasks;

  @override
  int get hashCode =>
    (links == null ? 0 : links.hashCode) +
    (tasks == null ? 0 : tasks.hashCode);

  @override
  String toString() => 'Tasks[links=$links, tasks=$tasks]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (links != null) {
      json[r'links'] = links;
    }
    if (tasks != null) {
      json[r'tasks'] = tasks;
    }
    return json;
  }

  /// Returns a new [Tasks] instance and imports its values from
  /// [json] if it's non-null, null if [json] is null.
  static Tasks fromJson(Map<String, dynamic> json) => json == null
    ? null
    : Tasks(
        links: Links.fromJson(json[r'links']),
        tasks: Task.listFromJson(json[r'tasks']),
    );

  static List<Tasks> listFromJson(List<dynamic> json, {bool emptyIsNull, bool growable,}) =>
    json == null || json.isEmpty
      ? true == emptyIsNull ? null : <Tasks>[]
      : json.map((v) => Tasks.fromJson(v)).toList(growable: true == growable);

  static Map<String, Tasks> mapFromJson(Map<String, dynamic> json) {
    final map = <String, Tasks>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) => map[key] = Tasks.fromJson(v));
    }
    return map;
  }

  // maps a json object with a list of Tasks-objects as value to a dart map
  static Map<String, List<Tasks>> mapListFromJson(Map<String, dynamic> json, {bool emptyIsNull, bool growable,}) {
    final map = <String, List<Tasks>>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic v) {
        map[key] = Tasks.listFromJson(v, emptyIsNull: emptyIsNull, growable: growable);
      });
    }
    return map;
  }
}

